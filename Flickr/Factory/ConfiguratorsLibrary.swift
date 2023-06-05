//
//  FactoryLibrary.swift
//  Flickr
//
//  Created by Артур Кулик on 01.06.2023.
//

import Foundation

enum ConfiguratorsLibrary {
    private static let sceneFactory = SceneFactory()
    
    static let searchPhotosScene = SearchPhotosSceneConfigurator(sceneFactory: sceneFactory)
    static let detailScene = DetailSceneConfigurator(sceneFactory: sceneFactory)
    static let favoritesScene = FavoritesSceneConfigurator(sceneFactory: sceneFactory)
    static let photoEditorScene = PhotoEditorSceneConfigurator(sceneFactory: sceneFactory)
}
