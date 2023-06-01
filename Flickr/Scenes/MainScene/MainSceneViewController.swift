//
//  MainSceneViewController.swift
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

protocol MainSceneDisplayLogic: AnyObject {
    func updateUI(viewModel: MainScene.Something.ViewModel)
}

class MainSceneViewController: UIViewController, MainSceneDisplayLogic {
    var interactor: MainSceneInteractor?
    var router: (NSObjectProtocol & MainSceneRoutingLogic & MainSceneDataPassing)?
    
    let collectionView = PhotoCollectionViewController(collectionViewLayout: UICollectionViewLayout())
    var textFieldText = ""
    
    @IBOutlet private var collectionViewContainer: UIView!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addCollectionView()
        setupNavigationBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func doSomething() {
        let request = MainScene.Something.Request(text: textFieldText)
        Task {
            try await interactor?.getPhotos(request: request)
        }
    }
    
    private func setupNavigationBar() {
        guard let navigationBar = navigationController?.navigationBar else { return }
        let textFieldeight: CGFloat = 30
        let textFieldFrame = CGRect(x: .zero, y: .zero, width: navigationBar.bounds.width, height: textFieldeight)
        let textField = createTextField(frame: textFieldFrame)
        
        self.navigationItem.titleView = textField
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Search", style: .plain, target: self, action: #selector(searchButtonTapped))
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        textFieldText = text
    }
    
    @objc func searchButtonTapped() {
        self.doSomething()
    }
    
    private func createTextField(frame: CGRect) -> UITextField {
        let textField = UITextField(frame: frame)
        textField.borderStyle = .roundedRect
        textField.placeholder = "Search photo by text"
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return textField
    }
    
    private func setup() {
        let viewController = self
        let networkService = NetworkService()
        let worker = MainSceneWorker(networkService: networkService)
        let presenter = MainScenePresenter()
        let interactor = MainSceneInteractor(worker: worker, presenter: presenter)
        let router = MainSceneRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    func some() {
        print("Some")
    }
    
    func updateUI(viewModel: MainScene.Something.ViewModel) {
        collectionView.photoArray = viewModel.photos
        DispatchQueue.main.async {
            self.collectionView.collectionView.reloadData()
        }
    }
    
    func addCollectionView() {
        addChild(collectionView)
        collectionViewContainer.addSubview(collectionView.view)
        collectionView.didMove(toParent: self)
        collectionView.view.translatesAutoresizingMaskIntoConstraints = false
        collectionView.view.equalConstraint(to: collectionViewContainer)
    }
}
