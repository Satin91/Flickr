//
//  MainSceneWorker.swift
//  Flickr
//
//  Created by Артур Кулик on 01.06.2023.
//

import UIKit

protocol MainSceneWorkerLogic {
    func execute(request: MainScene.Something.Request) async throws -> MainScene.Something.Response
}

class MainSceneWorker {
    var networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
}

extension MainSceneWorker: MainSceneWorkerLogic {
    func execute(request: MainScene.Something.Request) async throws -> MainScene.Something.Response {
        let params = [
            "api_key": Constants.Api.flickrKey,
            "format": "json",
            "method": "flickr.photos.search",
            "per_page": "25",
            "text": request.text,
            "nojsoncallback": "1"
        ]
        let flickr = try await networkService.parseJson(url: Constants.Api.baseURL, params: params, type: Flickr.self)
        var images: [UIImage] = []
        for photo in flickr.photos.photo {
            let image = try await networkService.downloadImage(url: photo.photoUrl.absoluteString)
            print("Download colpleted \(photo.photoUrl.absoluteString)")
            images.append(image)
        }
        return MainScene.Something.Response(photos: images)
    }
}
