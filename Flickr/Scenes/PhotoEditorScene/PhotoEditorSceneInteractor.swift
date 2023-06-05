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
    func uploadToGallery(request: PhotoEditorScene.Gallery.Request)
    func removePhoto()
    func updatePhoto(request: PhotoEditorScene.Database.Request)
}

protocol PhotoEditorSceneDataStore {
    var photo: PhotoModel { get set }
}

class PhotoEditorSceneInteractor: PhotoEditorSceneBusinessLogic, PhotoEditorSceneDataStore {
    var photo = PhotoModel(id: "", title: "", owner: "", imageURL: "", image: UIImage())
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
            let respose = await self.worker?.applyFilters(to: self.photo.image, from: filterArray)
            presenter?.presentFilteredArray(response: respose!)
        }
    }
    
    func applyFilter(request: PhotoEditorScene.PhotoEditor.Request) {
        Task { [weak self] in
            guard let self else { return }
            let response = await worker?.applyFilter(to: self.photo.image, type: filterArray[request.filterIndex])
            presenter?.presentPhotoFilter(response: response!)
        }
    }
    
    func uploadToGallery(request: PhotoEditorScene.Gallery.Request) {
        Task {
            try await worker?.upload(image: request.image)
        }
    }
    
    func removePhoto() {
        Task {
            let response = try await worker?.removeFromDB(object: photo)
            presenter?.presentRemovingResult(response: response!)
        }
    }
    
    func updatePhoto(request: PhotoEditorScene.Database.Request) {
        photo.image = request.image
        Task {
            let response = try await worker?.updateDBObject(object: photo)
            presenter?.presentUpdatingResult(response: response!)
        }
    }
}
