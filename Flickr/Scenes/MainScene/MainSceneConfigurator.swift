//
//  Configurator.swift
//  Flickr
//
//  Created by Артур Кулик on 01.06.2023.
//

import UIKit

final class MainSceneConfigurator {
    private var sceneFactory: SceneFactoryProtocol
    
    init(sceneFactory: SceneFactoryProtocol) {
        self.sceneFactory = sceneFactory
    }
}

extension MainSceneConfigurator: ConfiguratorProtocol {
    func configure<T>(_ vc: T) -> T where T: UIViewController {
        let vc = vc as! MainSceneViewController
        sceneFactory.sceneConfigurator = self
        let networkService = NetworkService()
        let worker = MainSceneWorker(networkService: networkService)
        let presenter = MainScenePresenter()
        let interactor = MainSceneInteractor(worker: worker, presenter: presenter)
        let router = MainSceneRouter()
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
    
    @discardableResult
    func configure(_ vc: MainSceneViewController) -> MainSceneViewController {
        sceneFactory.sceneConfigurator = self
        let networkService = NetworkService()
        let worker = MainSceneWorker(networkService: networkService)
        let presenter = MainScenePresenter()
        let interactor = MainSceneInteractor(worker: worker, presenter: presenter)
        let router = MainSceneRouter()
        vc.interactor = interactor
        vc.router = router
        interactor.presenter = presenter
        presenter.viewController = vc
        router.viewController = vc
        router.dataStore = interactor
        vc.interactor = interactor
        vc.router = router
        return vc
    }
}
