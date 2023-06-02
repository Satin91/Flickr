//
//  Constants.swift
//  Flickr
//
//  Created by Артур Кулик on 30.05.2023.
//

import Foundation

enum Constants {
    enum Navigation {
        enum StoryboardsNames {
            static let main = "Main"
        }
        
        enum StoryboardSegueIDs {
            static let toDetailScene = "toDetailScene"
        }
        
        enum ViewControllersIDs {
            static let MainSceneViewController = "MainSceneViewController"
            static let DetailSceneViewController = "DetailSceneViewController"
        }
    }
    
    enum ViewIdentifiers {
        static let photoDescriptionCell = "photoDescriptionCell"
    }
    
    enum Api {
        static let flickrKey = "2ce510bc4e5c8496d98918cbe75553c0"
        static let baseURL = "https://api.flickr.com/services/rest/"
    }
}
