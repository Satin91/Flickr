//
//  NetworkInteractor.swift
//  Flickr
//
//  Created by Артур Кулик on 30.05.2023.
//

import UIKit

protocol NetworkInteractorProtocol {
    func getPhotos(text: String) async throws -> [UIImage]
}

final class NetworkInteractor: NetworkInteractorProtocol {
    var networkRepository: NetworkRepositoryProtocol
    
    init(networkRepository: NetworkRepositoryProtocol) {
        self.networkRepository = networkRepository
    }
    
    func getPhotos(text: String) async throws -> [UIImage] {
        let params = ["api_key": Constants.Api.flickrKey,
                      "format": "json",
                      "method": "flickr.photos.search",
                      "per_page": "25",
                      "text": text,
                      "nojsoncallback": "1"]
        let flickr = try await networkRepository.parseJson(url: Constants.Api.baseURL, params: params, type: Flickr.self)
        var images: [UIImage] = []
        for photo in flickr.photos.photo {
            let image = try await networkRepository.downloadImage(url: photo.photoUrl.absoluteString)
            print("Download colpleted \(photo.photoUrl.absoluteString)")
            images.append(image)
        }
        return images
    }
}
