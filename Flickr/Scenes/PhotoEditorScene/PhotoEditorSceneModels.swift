//
//  PhotoEditorSceneModels.swift
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

enum PhotoEditorScene {
    // MARK: Use cases

    enum InitialSetup {
        struct Request {
        }

        struct Response {
            var photoModel: PhotoModel
        }

        struct ViewModel {
            var photoModel: PhotoModel
        }
    }
    //    enum SomethingElse
    //    {
    //        struct Request
    //        {
    //
    //        }
    //
    //        struct Response
    //        {
    //
    //        }
    //
    //        struct ViewModel
    //        {
    //
    //        }
    //    }
}
