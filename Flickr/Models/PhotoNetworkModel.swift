//
//  PhotoNetworkModel.swift
//  Flickr
//
//  Created by Артур Кулик on 30.05.2023.
//

import UIKit

struct PhotoNetworkModel: Decodable {
    let photos: PageDescription
}

struct PageDescription: Decodable {
    let page: Int
    let pages: Int
    let perpage: Int
    let total: Int
    let photo: [PhotoInfo]
}

struct PhotoInfo: Decodable {
    let id: String
    let owner: String
    let secret: String
    let server: String
    let farm: Int
    let title: String
    let ispublic: Int
    let isfriend: Int
    let isfamily: Int
    var photoUrl: URL {
        if let url = URL(string: "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_b.jpg") {
            return url
        } else {
            return URL(string: "https://cdn0.iconfinder.com/data/icons/technology-business-and-people/1000/file_light-14-1024.png")!
        }
    }
}
