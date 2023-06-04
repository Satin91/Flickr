//
//  PhotoEditorSceneInteractor.swift
//  Flickr
//
//  Created by Артур Кулик on 03.06.2023.
//  Copyright (c) 2023 All rights reserved.

import UIKit

protocol PhotoEditorSceneBusinessLogic {
    func initialSetup(request: PhotoEditorScene.InitialSetup.Request)
    func applyFilter(request: PhotoEditorScene.PhotoEditor.Request)
    func fetchFilters(request: PhotoEditorScene.LoadFilters.Request)
}

protocol PhotoEditorSceneDataStore {
    var photo: PhotoModel { get set }
}

class PhotoEditorSceneInteractor: PhotoEditorSceneBusinessLogic, PhotoEditorSceneDataStore {
    var photo = PhotoModel(title: "", owner: "", imageURL: "", image: UIImage())
    let filterArray: [
        PhotoFilterType?] = [
            nil,
            .photoEffectChrome,
            .photoEffectFade,
            .photoEffectInstant,
            .photoEffectMono,
            .photoEffectNoir,
            .photoEffectProcess,
            .photoEffectTonal,
            .photoEffectTransfer
        ]
    var presenter: PhotoEditorScenePresentationLogic?
    var worker: PhotoEditorSceneWorker?
    
    func initialSetup(request: PhotoEditorScene.InitialSetup.Request) {
        let response = PhotoEditorScene.InitialSetup.Response(photoModel: photo)
        presenter?.presentInitialSetup(response: response)
    }
    
    func fetchFilters(request: PhotoEditorScene.LoadFilters.Request) {
        Task { [weak self] in
            guard let self else { return }
            let respose = await self.worker?.applyFilterToImageArray(image: self.photo.image, filterArray: filterArray)
            presenter?.presentFilteredArray(response: respose!)
        }
    }
    
    func applyFilter(request: PhotoEditorScene.PhotoEditor.Request) {
        Task { [weak self] in
            guard let self else { return }
            let response = await worker?.applyFIlterToImage(image: self.photo.image, filterType: filterArray[request.filterIndex])
            presenter?.presentPhotoFilter(response: response!)
        }
    }
}
