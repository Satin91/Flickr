//
//  SearchPhotosScenePresenter.swift
//  Flickr
//
//  Created by Артур Кулик on 01.06.2023.
//  Copyright (c) All rights reserved.

import UIKit

protocol SearchPhotosScenePresentationLogic {
    func handOverPhotos(response: SearchPhotosScene.LoadPhotos.Response)
}

class SearchPhotosScenePresenter: SearchPhotosScenePresentationLogic {
    weak var viewController: SearchPhotosSceneDisplayLogic?
    
    func handOverPhotos(response: SearchPhotosScene.LoadPhotos.Response) {
        if response.errorMessage != nil {
            let viewModel = SearchPhotosScene.LoadPhotos.ViewModel(errorMessage: response.errorMessage)
            viewController?.loadError(viewModel: viewModel)
        } else {
            let viewModel = SearchPhotosScene.LoadPhotos.ViewModel(photos: response.photos)
            viewController?.loadSuccess(viewModel: viewModel)
        }
    }
}
