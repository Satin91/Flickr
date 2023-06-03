//
//  PhotoEditorSceneInteractor.swift
//  Flickr
//
//  Created by Артур Кулик on 03.06.2023.
//  Copyright (c) 2023 All rights reserved.

import UIKit

protocol PhotoEditorSceneBusinessLogic {
    func initialSetup(request: PhotoEditorScene.InitialSetup.Request)
//    func doSomethingElse(request: PhotoEditorScene.SomethingElse.Request)
}

protocol PhotoEditorSceneDataStore {
    var photo: PhotoModel { get set }
}

class PhotoEditorSceneInteractor: PhotoEditorSceneBusinessLogic, PhotoEditorSceneDataStore {
    var photo = PhotoModel(title: "", owner: "", imageURL: "", image: UIImage())
    var presenter: PhotoEditorScenePresentationLogic?
    var worker: PhotoEditorSceneWorker?
    
    func initialSetup(request: PhotoEditorScene.InitialSetup.Request) {
        let response = PhotoEditorScene.InitialSetup.Response(photoModel: photo)
        presenter?.presentInitialSetup(response: response)
    }
}
