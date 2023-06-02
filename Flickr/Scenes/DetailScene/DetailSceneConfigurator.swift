//
//  Configurator.swift
//  Flickr
//
//  Created by Артур Кулик on 01.06.2023.
//

import UIKit

final class DetailSceneConfigurator: ConfiguratorProtocol {
    private weak var sceneFactory: SceneFactoryProtocol?
    
    init(sceneFactory: SceneFactoryProtocol) {
        self.sceneFactory = sceneFactory
    }
    
    // This attribute is needed so as not to bother with a warning that the method is not used
    @discardableResult
    func configure<T>(_ vc: T) -> T where T: UIViewController {
        let vc = vc as! DetailSceneViewController
        sceneFactory?.sceneConfigurator = self
        let interactor = DetailSceneInteractor()
        let presenter = DetailScenePresenter()
        let router = DetailSceneRouter()
        vc.interactor = interactor
        vc.router = router
        interactor.presenter = presenter
        presenter.viewController = vc
        router.viewController = vc
        router.dataStore = interactor
        return vc as! T
    }
}
