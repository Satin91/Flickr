//
//  SearchPhotosSceneModels.swift
//  Flickr
//
//  Created by Артур Кулик on 01.06.2023.
//  Copyright (c) All rights reserved.

import UIKit

enum SearchPhotosScene {
    enum LoadPhotos {
        struct Request {
            var params: [String: Any] = [:]
            
            init(text: String, photosCount: Int) {
                self.params = [
                    "api_key": Constants.Api.flickrKey,
                    "format": "json",
                    "method": "flickr.photos.search",
                    "per_page": String(photosCount),
                    "text": text,
                    "nojsoncallback": "1"
                ]
            }
        }
        
        struct Response {
            var photos: [PhotoModel]?
            var errorMessage: String?
        }
        
        struct ViewModel {
            var errorMessage: String?
            var photos: [PhotoModel]?
        }
    }
}
