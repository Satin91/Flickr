//
//  SearchPhotosSceneRouter.swift
//  Flickr
//
//  Created by Артур Кулик on 01.06.2023.
//  Copyright (c) All rights reserved.

import UIKit

@objc protocol SearchPhotosSceneRoutingLogic {
    func routeToDetailScene()
}

protocol SearchPhotosSceneDataPassing {
    var dataStore: SearchPhotosSceneDataStore? { get }
}

class SearchPhotosSceneRouter: NSObject, SearchPhotosSceneRoutingLogic, SearchPhotosSceneDataPassing {
    weak var viewController: SearchPhotosSceneViewController?
    var dataStore: SearchPhotosSceneDataStore?
    
    func routeToDetailScene() {
        let destinationVC = DetailSceneViewController().instantiate() as! DetailSceneViewController
        ConfiguratorsLibrary.detailScene.configure(destinationVC)
        var destinationDS = destinationVC.router!.dataStore!
        passDataToDetailScene(source: dataStore!, destination: &destinationDS)
        navigateToDetailScene(source: viewController!, destination: destinationVC)
    }
    
    func navigateToDetailScene(source: SearchPhotosSceneViewController, destination: DetailSceneViewController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }

    func passDataToDetailScene(source: SearchPhotosSceneDataStore, destination: inout DetailSceneDataStore) {
        destination.photo = source.selectedPhoto
    }
}
