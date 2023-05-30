//
//  MainViewModel.swift
//  Flickr
//
//  Created by Артур Кулик on 30.05.2023.
//

import UIKit

class MainViewModel {
    var networkInteractor: NetworkInteractorProtocol
    var photos: [UIImage] = []
    
    init(NetworkInteractor: NetworkInteractorProtocol) {
        self.networkInteractor = NetworkInteractor
    }
    
    func parse() async throws {
        self.photos = try await networkInteractor.getPhotos(text: "Gradient")
    }
}
