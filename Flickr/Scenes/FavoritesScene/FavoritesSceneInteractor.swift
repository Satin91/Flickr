//
//  FavoritesSceneInteractor.swift
//  Flickr
//
//  Created by Артур Кулик on 02.06.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol FavoritesSceneBusinessLogic {
    func doSomething(request: FavoritesScene.Database.Request)
    func fetchObjectsFromDatabase(request: FavoritesScene.Database.Request)
    func putInDataStore(photo: PhotoModel)
}

protocol FavoritesSceneDataStore {
    var selectedPhoto: PhotoModel { get set }
}

class FavoritesSceneInteractor: FavoritesSceneBusinessLogic, FavoritesSceneDataStore {
    var selectedPhoto = PhotoModel(title: "", owner: "", imageURL: "", image: UIImage())
    
    var presenter: FavoritesScenePresentationLogic?
    var worker: FavoritesSceneWorker?
    // var name: String = ""
    
    init(presenter: FavoritesScenePresentationLogic? = nil, worker: FavoritesSceneWorker? = nil) {
        self.presenter = presenter
        self.worker = worker
    }
    
    func doSomething(request: FavoritesScene.Database.Request) {
        let response = FavoritesScene.Database.Response(objects: [])
        presenter?.presentSomething(response: response)
    }
    
    func fetchObjectsFromDatabase(request: FavoritesScene.Database.Request) {
        let response = worker?.fetchObjectsFromDatabasse(request: request)
        presenter?.handOverDatabaseObjects(response: response!)
    }
    
    func putInDataStore(photo: PhotoModel) {
        self.selectedPhoto = photo
    }
}
