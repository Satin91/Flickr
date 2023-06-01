//
//  NetworkInteractor.swift
//  Flickr
//
//  Created by Артур Кулик on 30.05.2023.
//

import UIKit

protocol MainSceneBusinessLogic {
    func getPhotos(request: MainScene.Properties.Request) async throws
}

protocol MainSceneDataStore {
//    var photos: [UIImage] { get set }
}

final class MainSceneInteractor: MainSceneDataStore {
//    var photos: [UIImage] = []
    var worker: MainSceneWorkerLogic
    var presenter: MainScenePresentationLogic
    
    init(worker: MainSceneWorkerLogic, presenter: MainScenePresentationLogic) {
        self.worker = worker
        self.presenter = presenter
    }
}

extension MainSceneInteractor: MainSceneBusinessLogic {
    func getPhotos(request: MainScene.Properties.Request) async throws {
        let response = try await worker.execute(request: request)
        presenter.present(response: response)
//        self.photos = photos
    }
}
