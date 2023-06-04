//
//  PhotoGalleryManager.swift
//  Flickr
//
//  Created by Артур Кулик on 04.06.2023.
//

import UIKit

protocol PhotoGalleryManagerProtocol {
    func saveToPhotos(photo: UIImage) async throws -> Bool
}

class PhotoGalleryManager: PhotoGalleryManagerProtocol {
    func saveToPhotos(photo: UIImage) async throws -> Bool {
        UIImageWriteToSavedPhotosAlbum(photo, nil, nil, nil)
        return true
    }
    
    //    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
    //        print("Save finished!")
    //    }
}
