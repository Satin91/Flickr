//
//  PhotoEditorSceneWorker.swift
//  Flickr
//
//  Created by Артур Кулик on 03.06.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

class PhotoEditorSceneWorker {
    var photoEditorService: PhotoEditorServiceProtocol!
    var photoGalleryManager: PhotoGalleryManager!
    var databaseManager: DatabaseManager!
    
    init(photoEditorService: PhotoEditorServiceProtocol!, photoGalleryManager: PhotoGalleryManager!, databaseManager: DatabaseManager!) {
        self.photoEditorService = photoEditorService
        self.photoGalleryManager = photoGalleryManager
        self.databaseManager = databaseManager
    }
    
    func applyFilter(to image: UIImage, type: PhotoFilterType?) async -> PhotoEditorScene.PhotoEditor.Response {
        let image = await photoEditorService.applyBuiltInEffect(image: image, effectType: type)
        return PhotoEditorScene.PhotoEditor.Response(image: image)
    }
    
    func applyFilters(to image: UIImage, from filterArray: [PhotoFilterType?]) async -> PhotoEditorScene.LoadFilters.Response {
        var filteredImages: [UIImage] = []
        for filter in filterArray {
            let image = await photoEditorService.applyBuiltInEffect(image: image, effectType: filter)
            filteredImages.append(image)
        }
        return PhotoEditorScene.LoadFilters.Response(images: filteredImages)
    }
    
    func upload(image: UIImage) async throws -> PhotoEditorScene.Gallery.Response {
        let success = try await photoGalleryManager.saveToPhotos(photo: image)
        return PhotoEditorScene.Gallery.Response(success: success)
    }
    
    func removeFromDB(object: PhotoModel) async throws -> PhotoEditorScene.Database.Response {
        let realmObject = RealmPhotoModel()
        realmObject.id = object.id
        realmObject.image = object.image.pngData()
        realmObject.imageURL = object.imageURL
        realmObject.owner = object.owner
        realmObject.title = object.title
        databaseManager.delete(id: realmObject.id, object: RealmPhotoModel.self)
        return PhotoEditorScene.Database.Response(success: true)
    }
}