//
//  FactoryLibrary.swift
//  Flickr
//
//  Created by Артур Кулик on 01.06.2023.
//

import Foundation

enum ConfiguratorLibrary {
    private static let sceneFactory = SceneFactory()
    
    static let mainScene = MainSceneConfigurator(sceneFactory: sceneFactory)
}
