//
//  NetworkInteractor.swift
//  Flickr
//
//  Created by Артур Кулик on 30.05.2023.
//

import UIKit

protocol MainSceneBusinessLogic {
    func fetchPhotos(request: MainScene.FetchPhotos.Request) async throws
    func putInDataStore(photoModel: PhotoModel)
}

protocol MainSceneDataStore {
    var selectedPhoto: PhotoModel { get set }
}

final class MainSceneInteractor: MainSceneDataStore {
    var selectedPhoto = PhotoModel(title: "", owner: "", imageURL: "", image: UIImage())
    
    var worker: MainSceneWorkerLogic
    var presenter: MainScenePresentationLogic
    
    init(worker: MainSceneWorkerLogic, presenter: MainScenePresentationLogic) {
        self.worker = worker
        self.presenter = presenter
    }
}

extension MainSceneInteractor: MainSceneBusinessLogic {
    func putInDataStore(photoModel: PhotoModel) {
        self.selectedPhoto = photoModel
    }
    
    func fetchPhotos(request: MainScene.FetchPhotos.Request) async throws {
        let response = try await worker.execute(request: request)
        presenter.present(response: response)
    }
}
