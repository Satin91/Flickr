//
//  PhotoEditorScenePresenter.swift
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

protocol PhotoEditorScenePresentationLogic {
    func presentInitialSetup(response: PhotoEditorScene.InitialSetup.Response)
    func presentPhotoFilter(response: PhotoEditorScene.PhotoEditor.Response)
    func presentFilteredArray(response: PhotoEditorScene.LoadFilters.Response)
}

class PhotoEditorScenePresenter: PhotoEditorScenePresentationLogic {
    weak var viewController: PhotoEditorSceneDisplayLogic?

    func presentInitialSetup(response: PhotoEditorScene.InitialSetup.Response) {
        let viewModel = PhotoEditorScene.InitialSetup.ViewModel(photoModel: response.photoModel)
        viewController?.fillData(viewModel: viewModel)
    }
    
    func presentPhotoFilter(response: PhotoEditorScene.PhotoEditor.Response) {
        let viewModel = PhotoEditorScene.PhotoEditor.ViewModel(image: response.image)
        viewController?.displayFilter(viewModel: viewModel)
    }
    
    func presentFilteredArray(response: PhotoEditorScene.LoadFilters.Response) {
        let viewModel = PhotoEditorScene.LoadFilters.ViewModel(images: response.images)
        viewController?.displayFilters(viewModel: viewModel)
    }
}
