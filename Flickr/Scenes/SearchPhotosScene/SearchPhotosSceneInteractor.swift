//
//  NetworkInteractor.swift
//  Flickr
//
//  Created by Артур Кулик on 30.05.2023.
//

import UIKit

protocol MainSceneBusinessLogic {
    func fetchPhotos(request: SearchPhotosScene.LoadPhotos.Request) async throws
    func putInDataStore(photo: PhotoModel)
}

protocol SearchPhotosSceneDataStore {
    var selectedPhoto: PhotoModel { get set }
}

final class SearchPhotosSceneInteractor: SearchPhotosSceneDataStore {
    var selectedPhoto = PhotoModel(id: "", title: "", owner: "", imageURL: "", image: UIImage())
    
    var worker: MainSceneWorkerLogic
    var presenter: SearchPhotosScenePresentationLogic
    
    init(worker: MainSceneWorkerLogic, presenter: SearchPhotosScenePresentationLogic) {
        self.worker = worker
        self.presenter = presenter
    }
}

extension SearchPhotosSceneInteractor: MainSceneBusinessLogic {
    func putInDataStore(photo: PhotoModel) {
        self.selectedPhoto = photo
    }
    
    func fetchPhotos(request: SearchPhotosScene.LoadPhotos.Request) {
        Task {
            let response = try await worker.downLoadPhotos(request: request)
            presenter.handOverPhotos(response: response)
        }
    }
}
