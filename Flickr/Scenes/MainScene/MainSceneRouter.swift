//
//  MainSceneRouter.swift
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

@objc protocol MainSceneRoutingLogic {
    func routeToDetailScene()
}

protocol MainSceneDataPassing {
    var dataStore: MainSceneDataStore? { get }
}

class MainSceneRouter: NSObject, MainSceneRoutingLogic, MainSceneDataPassing {
    weak var viewController: MainSceneViewController?
    var dataStore: MainSceneDataStore?
    
    // MARK: Routing (navigating to other screens)
    
    // MARK: Routing
    
    func routeToDetailScene() {
        let destinationVC = DetailSceneViewController().instantiate() as! DetailSceneViewController
        ConfiguratorLibrary.detailScene.configure(destinationVC)
        var destinationDS = destinationVC.router!.dataStore!
        passDataToDetailScene(source: dataStore!, destination: &destinationDS)
        navigateToDetailView(source: viewController!, destination: destinationVC)
    }
    
    func navigateToDetailView(source: MainSceneViewController, destination: DetailSceneViewController) {
        source.show(destination, sender: nil)
    }

    func passDataToDetailScene(source: MainSceneDataStore, destination: inout DetailSceneDataStore) {
        destination.photo = source.selectedPhoto
    }
}
