//
//  NetworkInteractor.swift
//  Flickr
//
//  Created by Артур Кулик on 30.05.2023.
//

import UIKit

protocol MainSceneBusinessLogic {
    func fetchPhotos(request: MainScene.LoadPhotos.Request) async throws
    func putInDataStore(photo: PhotoModel)
}

protocol MainSceneDataStore {
    var selectedPhoto: PhotoModel { get set }
}

final class MainSceneInteractor: MainSceneDataStore {
    var selectedPhoto = PhotoModel(id: "", title: "", owner: "", imageURL: "", image: UIImage())
    
    var worker: MainSceneWorkerLogic
    var presenter: MainScenePresentationLogic
    
    init(worker: MainSceneWorkerLogic, presenter: MainScenePresentationLogic) {
        self.worker = worker
        self.presenter = presenter
    }
}

extension MainSceneInteractor: MainSceneBusinessLogic {
    func putInDataStore(photo: PhotoModel) {
        self.selectedPhoto = photo
    }
    
    func fetchPhotos(request: MainScene.LoadPhotos.Request) {
        Task {
            let response = try await worker.downLoadPhotos(request: request)
            presenter.handOverPhotos(response: response)
        }
    }
}
