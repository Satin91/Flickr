//
//  SceneFactory.swift
//  Flickr
//
//  Created by Артур Кулик on 01.06.2023.
//

import UIKit

// Protocol that all configurators must subscribe to
protocol ConfiguratorProtocol {
    func configure<T: UIViewController>(_ vc: T) -> T
}

protocol SceneFactoryProtocol {
    var sceneConfigurator: ConfiguratorProtocol! { get set }

    func makeScene<T: UIViewController>(vc: T) -> T
}

final class SceneFactory: SceneFactoryProtocol {
    var sceneConfigurator: ConfiguratorProtocol!
    
    func configure<T>(_ vc: T) -> T where T: UIViewController {
        let vc = vc.instantiate() as! T
        return sceneConfigurator.configure(vc)
    }
    
    func makeScene<T: UIViewController>(vc: T) -> T {
        let vc = vc.instantiate() as! T
        return sceneConfigurator.configure(vc)
    }
}
