//
//  FavoritesSceneRouter.swift
//  Flickr
//
//  Created by Артур Кулик on 02.06.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

@objc protocol FavoritesSceneRoutingLogic {
    func routeToPhotoEditorScene()
}

protocol FavoritesSceneDataPassing {
    var dataStore: FavoritesSceneDataStore? { get }
}

class FavoritesSceneRouter: NSObject, FavoritesSceneRoutingLogic, FavoritesSceneDataPassing {
    weak var viewController: FavoritesSceneViewController?
    var dataStore: FavoritesSceneDataStore?
    
    func routeToPhotoEditorScene() {
        let destinationVC = PhotoEditorSceneViewController().instantiate() as! PhotoEditorSceneViewController
        ConfiguratorsLibrary.photoEditorScene.configure(destinationVC)
        var destinationDS = destinationVC.router!.dataStore!
        passDataToPhotoEditorScene(source: dataStore!, destination: &destinationDS)
        navigateToPhotoEditorScene(source: viewController!, destination: destinationVC)
    }
    
    func navigateToPhotoEditorScene(source: FavoritesSceneViewController, destination: PhotoEditorSceneViewController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }

    func passDataToPhotoEditorScene(source: FavoritesSceneDataStore, destination: inout PhotoEditorSceneDataStore) {
        destination.photo = source.selectedPhoto
    }
}
