//
//  FavoritesSceneConfigurator.swift
//  Flickr
//
//  Created by Артур Кулик on 02.06.2023.
//

import UIKit

final class FavoritesSceneConfigurator: ConfiguratorProtocol {
    private weak var sceneFactory: SceneFactoryProtocol!
    
    init(sceneFactory: SceneFactoryProtocol) {
        self.sceneFactory = sceneFactory
    }
    
    // This attribute is needed so as not to bother with a warning that the method is not used
    @discardableResult
    func configure<T>(_ vc: T) -> T where T: UIViewController {
        let vc = vc as! FavoritesSceneViewController
        sceneFactory.sceneConfigurator = self
        let databaseManager = DatabaseManager()
        let worker = FavoritesSceneWorker(databaseManager: databaseManager)
        let presenter = FavoritesScenePresenter()
        let interactor = FavoritesSceneInteractor(presenter: presenter, worker: worker)
        let router = FavoritesSceneRouter()
        vc.interactor = interactor
        vc.router = router
        interactor.presenter = presenter
        presenter.viewController = vc
        router.viewController = vc
        router.dataStore = interactor
        vc.interactor = interactor
        vc.router = router
        return vc as! T
    }
}
