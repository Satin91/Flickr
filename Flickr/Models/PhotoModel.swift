//
//  PhotoModel.swift
//  Flickr
//
//  Created by Артур Кулик on 02.06.2023.
//

import UIKit

struct PhotoModel {
    var title: String
    var owner: String
    var imageURL: String
    var image: UIImage
    
    init(title: String, owner: String, imageURL: String, image: UIImage) {
        self.title = title
        self.owner = owner
        self.imageURL = imageURL
        self.image = image
    }
    
    init(from photo: PhotoInfo, with image: UIImage?) {
        self.title = photo.title
        self.owner = photo.owner
        self.imageURL = photo.photoUrl.absoluteString
        self.image = (image ?? UIImage(systemName: "photo.fill"))!
    }
}
