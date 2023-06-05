//
//  Configurator.swift
//  Flickr
//
//  Created by Артур Кулик on 01.06.2023.
//

import UIKit

final class SearchPhotosSceneConfigurator: ConfiguratorProtocol {
    private weak var sceneFactory: SceneFactoryProtocol!
    
    init(sceneFactory: SceneFactoryProtocol) {
        self.sceneFactory = sceneFactory
    }
    
    // This attribute is needed so as not to bother with a warning that the method is not used
    @discardableResult
    func configure<T>(_ vc: T) -> T where T: UIViewController {
        let vc = vc as! SearchPhotosSceneViewController
        sceneFactory.sceneConfigurator = self
        let networkService = NetworkService()
        let worker = SearchPhotosSceneWorker(networkService: networkService)
        let presenter = SearchPhotosScenePresenter()
        let interactor = SearchPhotosSceneInteractor(worker: worker, presenter: presenter)
        let router = SearchPhotosSceneRouter()
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
