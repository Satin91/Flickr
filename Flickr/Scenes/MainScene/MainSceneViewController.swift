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
    func successFetchHandler(viewModel: MainScene.FetchPhotos.ViewModel)
    func errorFetchHandler(viewModel: MainScene.FetchPhotos.ViewModel)
}

class MainSceneViewController: UIViewController, MainSceneDisplayLogic {
    let collectionView = PhotoCollectionViewController(collectionViewLayout: UICollectionViewLayout())
    
    var interactor: MainSceneInteractor?
    var router: (NSObjectProtocol & MainSceneRoutingLogic & MainSceneDataPassing)?
    private var textFieldText = ""
    
    @IBOutlet private var tabBarViewItem: UITabBarItem!
    @IBOutlet private var collectionViewContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        photoSelectionObserver()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        textFieldText = text
    }
    
    @objc func searchButtonTapped() {
        fetchPhotos(by: textFieldText)
    }
    
    func successFetchHandler(viewModel: MainScene.FetchPhotos.ViewModel) {
        guard let photoModel = viewModel.photoModel else { return }
        collectionView.photoArray = photoModel
        DispatchQueue.main.async {
            self.collectionView.collectionView.reloadData()
        }
    }
    
    func errorFetchHandler(viewModel: MainScene.FetchPhotos.ViewModel) {
        guard let message = viewModel.errorMessage else { return }
        DispatchQueue.main.async {
            AlertController.show(title: "Error", message: message, style: .alert, showOn: self)
        }
    }
    
    private func photoSelectionObserver() {
        collectionView.didSelectPhoto = { [weak self] photo in
            guard let self else { return }
            self.interactor?.putInDataStore(photoModel: photo)
            self.router?.routeToDetailScene()
        }
    }
    
    private func fetchPhotos(by text: String) {
        let request = MainScene.FetchPhotos.Request(text: text)
        Task {
            try await interactor?.fetchPhotos(request: request)
        }
    }
}

// MARK: Setup UI
extension MainSceneViewController {
    func setupUI() {
        configureDependencies()
        addCollectionView()
        configureNavigationBar()
    }
    
    private func addCollectionView() {
        addChild(collectionView)
        collectionViewContainer.addSubview(collectionView.view)
        collectionView.didMove(toParent: self)
        collectionView.view.translatesAutoresizingMaskIntoConstraints = false
        collectionView.view.equalConstraint(to: collectionViewContainer)
        collectionView.itemsPerLine = 3
    }
    
    private func createTextField(frame: CGRect) -> UITextField {
        let textField = UITextField(frame: frame)
        textField.borderStyle = .roundedRect
        textField.placeholder = "Search photo by text"
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return textField
    }
    
    func configureDependencies() {
        ConfiguratorsLibrary.mainScene.configure(self)
    }
    
    private func configureNavigationBar() {
        guard let navigationBar = navigationController?.navigationBar else { return }
        let textFieldeight: CGFloat = 30
        let textFieldFrame = CGRect(x: .zero, y: .zero, width: navigationBar.bounds.width, height: textFieldeight)
        let textField = createTextField(frame: textFieldFrame)
        self.navigationItem.titleView = textField
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "magnifyingglass"),
            style: .plain,
            target: self,
            action: #selector(searchButtonTapped)
        )
    }
}
