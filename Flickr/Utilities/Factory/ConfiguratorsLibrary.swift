//
//  FactoryLibrary.swift
//  Flickr
//
//  Created by Артур Кулик on 01.06.2023.
//

import Foundation

enum ConfiguratorsLibrary {
    private static let sceneFactory = SceneFactory()
    
    static let mainScene = MainSceneConfigurator(sceneFactory: sceneFactory)
    static let detailScene = DetailSceneConfigurator(sceneFactory: sceneFactory)
}
