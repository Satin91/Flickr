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
    func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol MainSceneDataPassing {
    var dataStore: MainSceneDataStore? { get }
}

class MainSceneRouter: NSObject, MainSceneRoutingLogic, MainSceneDataPassing {
    func routeToSomewhere(segue: UIStoryboardSegue?) {
        print("Route to somewhere")
    }
    
    weak var viewController: MainSceneViewController?
    var dataStore: MainSceneDataStore?
    
    // MARK: Routing (navigating to other screens)
    
    // func routeToSomewhere(segue: UIStoryboardSegue?) {
    //    if let segue = segue {
    //        let destinationVC = segue.destination as! SomewhereViewController
    //        var destinationDS = destinationVC.router!.dataStore!
    //        passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //    } else {
    //        let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //        let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
    //        var destinationDS = destinationVC.router!.dataStore!
    //        passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //        navigateToSomewhere(source: viewController!, destination: destinationVC)
    //    }
    // }
    
    // MARK: Navigation to other screen
    
    // func navigateToSomewhere(source: MainSceneViewController, destination: SomewhereViewController) {
    //    source.show(destination, sender: nil)
    // }
    
    // MARK: Passing data to other screen
    
    // func passDataToSomewhere(source: MainSceneDataStore, destination: inout SomewhereDataStore) {
    //     destination.name = source.name
    // }
}
