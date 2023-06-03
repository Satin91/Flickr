//
//  PhotoEditorSceneConfigurator.swift
//  Flickr
//
//  Created by Артур Кулик on 03.06.2023.
//

import UIKit

final class PhotoEditorSceneConfigurator: ConfiguratorProtocol {
    private weak var sceneFactory: SceneFactoryProtocol?
    
    init(sceneFactory: SceneFactoryProtocol) {
        self.sceneFactory = sceneFactory
    }
    
    // This attribute is needed so as not to bother with a warning that the method is not used
    @discardableResult
    func configure<T>(_ vc: T) -> T where T: UIViewController {
        let vc = vc as! PhotoEditorSceneViewController
        sceneFactory?.sceneConfigurator = self
        let interactor = PhotoEditorSceneInteractor()
        let presenter = PhotoEditorScenePresenter()
        let router = PhotoEditorSceneRouter()
        let photoEditorService = PhotoEditorService()
        let worker = PhotoEditorSceneWorker(photoEditorService: photoEditorService)
        interactor.worker = worker
        vc.interactor = interactor
        vc.router = router
        interactor.presenter = presenter
        presenter.viewController = vc
        router.viewController = vc
        router.dataStore = interactor
        return vc as! T
    }
}
