//
//  DetailScenePresenter.swift
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

protocol DetailScenePresentationLogic {
    func presentSomething(response: DetailScene.Something.Response)
}

class DetailScenePresenter: DetailScenePresentationLogic {
    weak var viewController: DetailSceneDisplayLogic?

    // MARK: Parse and calc respnse from DetailSceneInteractor and send simple view model to DetailSceneViewController to be displayed

    func presentSomething(response: DetailScene.Something.Response) {
        let viewModel = DetailScene.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
//
//    func presentSomethingElse(response: DetailScene.SomethingElse.Response) {
//        let viewModel = DetailScene.SomethingElse.ViewModel()
//        viewController?.displaySomethingElse(viewModel: viewModel)
//    }
}
