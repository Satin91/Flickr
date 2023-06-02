//
//  DetailSceneInteractor.swift
//  Flickr
//
//  Created by Артур Кулик on 01.06.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol DetailSceneBusinessLogic {
    func initialSetup(request: DetailScene.InitialSetup.Request)
    func shareLink()
}

protocol DetailSceneDataStore {
    var photo: PhotoModel! { get set }
}

class DetailSceneInteractor: DetailSceneBusinessLogic, DetailSceneDataStore {
    var presenter: DetailScenePresentationLogic?
    var worker: DetailSceneWorker?
    var photo: PhotoModel!
    
    func initialSetup(request: DetailScene.InitialSetup.Request) {
        worker = DetailSceneWorker()
        worker?.doSomeWork()
        guard let photo else { fatalError("Image not received") }
        let response = DetailScene.InitialSetup.Response(photoModel: photo)
        presenter?.initialSetup(response: response)
    }
    
    func shareLink() {
        let response = DetailScene.Share.Response(isValidAddress: true, urlString: photo.imageURL)
        presenter?.showActivityView(response: response)
    }
}
