//
//  MainSceneWorker.swift
//  Flickr
//
//  Created by Артур Кулик on 01.06.2023.
//

import UIKit

protocol MainSceneWorkerLogic {
    func execute(request: MainScene.FetchPhotos.Request) async throws -> MainScene.FetchPhotos.Response
}

class MainSceneWorker {
    var networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
}

extension MainSceneWorker: MainSceneWorkerLogic {
    func execute(request: MainScene.FetchPhotos.Request) async throws -> MainScene.FetchPhotos.Response {
        let params = [
            "api_key": Constants.Api.flickrKey,
            "format": "json",
            "method": "flickr.photos.search",
            "per_page": "25",
            "text": request.text,
            "nojsoncallback": "1"
        ]
        var photoNetworkModel: PhotoNetworkModel!
        do {
            photoNetworkModel = try await networkService.parseJson(url: Constants.Api.baseURL, params: params, type: PhotoNetworkModel.self)
        } catch let error {
            return MainScene.FetchPhotos.Response(errorMessage: error.localizedDescription)
        }
        
        var photoModel: [PhotoModel] = []
        
        for photo in photoNetworkModel.photos.photo {
            var image: UIImage?
            do {
                image = try await networkService.downloadImage(url: photo.photoUrl.absoluteString)
            } catch let error {
                return MainScene.FetchPhotos.Response(errorMessage: error.localizedDescription)
            }
            print("Download colpleted \(photo.photoUrl.absoluteString)")
            photoModel.append(
                PhotoModel(
                    title: photo.title,
                    owner: photo.owner,
                    address: photo.photoUrl.absoluteString,
                    image: (image ?? UIImage(systemName: "photo.fill"))!
                )
            )
        }
        return MainScene.FetchPhotos.Response(photoModel: photoModel)
    }
}
