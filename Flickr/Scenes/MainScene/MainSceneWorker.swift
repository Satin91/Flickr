//
//  MainSceneWorker.swift
//  Flickr
//
//  Created by Артур Кулик on 01.06.2023.
//

import UIKit

enum ImageLoadError: Error {
    case timeout
    case invalidURL
    case noInternetConnection
}

protocol MainSceneWorkerLogic {
    func downLoadPhotos(request: MainScene.LoadPhotos.Request) async throws -> MainScene.LoadPhotos.Response
}

class MainSceneWorker {
    var networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
}

extension MainSceneWorker: MainSceneWorkerLogic {
    func downLoadPhotos(request: MainScene.LoadPhotos.Request) async throws -> MainScene.LoadPhotos.Response {
        var photoNetworkModel: PhotoNetworkModel
        do {
            photoNetworkModel = try await parseJson(params: request.params)
        } catch let error {
            let errorText = error.asAFError?.localizedDescription.removeTo(symbol: ":")
            return MainScene.LoadPhotos.Response(errorMessage: errorText)
        }
        
        var photos: [PhotoModel] = []
        do {
            photos = try await downloadImages(from: photoNetworkModel)
        } catch let error {
            let errorText = error.asAFError?.localizedDescription.removeTo(symbol: ":")
            return MainScene.LoadPhotos.Response(errorMessage: errorText)
        }
        return MainScene.LoadPhotos.Response(photos: photos)
    }
    
    private func parseJson(params: [String: Any]) async throws -> PhotoNetworkModel {
        try await networkService.parseJson(url: Constants.Api.baseURL, params: params, type: PhotoNetworkModel.self)
    }
    
    private func downloadImages(from networkModel: PhotoNetworkModel) async throws -> [PhotoModel] {
        var photos: [PhotoModel] = []
        for photoInfo in networkModel.photos.photo {
            var image: UIImage?
            do {
                image = try await networkService.downloadImage(url: photoInfo.photoUrl.absoluteString)
            } catch let error {
                throw error
            }
            let photo = PhotoModel(from: photoInfo, with: image)
            photos.append(photo)
        }
        return photos
    }
}
