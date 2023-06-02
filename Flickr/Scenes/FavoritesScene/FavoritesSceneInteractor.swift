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
    func doSomething(request: FavoritesScene.Something.Request)
//    func doSomethingElse(request: FavoritesScene.SomethingElse.Request)
}

protocol FavoritesSceneDataStore {
    // var name: String { get set }
}

class FavoritesSceneInteractor: FavoritesSceneBusinessLogic, FavoritesSceneDataStore {
    var presenter: FavoritesScenePresentationLogic?
    var worker: FavoritesSceneWorker?
    // var name: String = ""
    
    init(presenter: FavoritesScenePresentationLogic? = nil, worker: FavoritesSceneWorker? = nil) {
        self.presenter = presenter
        self.worker = worker
    }
    
    func doSomething(request: FavoritesScene.Something.Request) {
        let response = FavoritesScene.Something.Response()
        presenter?.presentSomething(response: response)
    }
    //
    //    func doSomethingElse(request: FavoritesScene.SomethingElse.Request) {
    //        worker = FavoritesSceneWorker()
    //        worker?.doSomeOtherWork()
    //
    //        let response = FavoritesScene.SomethingElse.Response()
    //        presenter?.presentSomethingElse(response: response)
    //    }
}
