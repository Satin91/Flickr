//
//  RealmPhotoModel.swift
//  Flickr
//
//  Created by Артур Кулик on 02.06.2023.
//

import RealmSwift

@objcMembers
class RealmPhotoModel: Object {
    dynamic var id: String = UUID().uuidString
    dynamic var title: String = ""
    dynamic var owner: String = ""
    dynamic var imageURL: String = ""
    dynamic var image: Data?
    
    override static func primaryKey() -> String? {
        "id"
    }
}
