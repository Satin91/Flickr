//
//  MainSceneModels.swift
//  Flickr
//
//  Created by Артур Кулик on 01.06.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum MainScene {
    // MARK: Use cases

    enum Something {
        struct Request {
            var text: String
        }

        struct Response {
            var photos: [UIImage]
        }

        struct ViewModel {
            var photos: [UIImage]
        }
    }
}
