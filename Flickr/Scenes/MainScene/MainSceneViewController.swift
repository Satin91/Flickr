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
    func loadSuccess(viewModel: MainScene.LoadPhotos.ViewModel)
    func loadError(viewModel: MainScene.LoadPhotos.ViewModel)
}

class MainSceneViewController: UIViewController, MainSceneDisplayLogic {
    var interactor: MainSceneInteractor?
    var router: (NSObjectProtocol & MainSceneRoutingLogic & MainSceneDataPassing)?
    private var searchText = ""
    @IBOutlet private var collectionViewContainer: UIView!
    
    let collectionView = PhotoCollectionViewController(collectionViewLayout: UICollectionViewLayout(), layoutSize: .medium)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureDependencies()
        photoSelectionCallbackObserver()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - Protocol methods
    
    func loadSuccess(viewModel: MainScene.LoadPhotos.ViewModel) {
        guard let photos = viewModel.photos else { return }
        collectionView.display(photos: photos)
    }
    
    func loadError(viewModel: MainScene.LoadPhotos.ViewModel) {
        guard let message = viewModel.errorMessage else { return }
        DispatchQueue.main.async {
            AlertController.show(title: "Error", message: message, style: .alert, showOn: self)
        }
    }
    
    // MARK: - Requests to interactor
    
    private func loadPhotos(by text: String, withCount: Int) {
        let request = MainScene.LoadPhotos.Request(text: text, photosCount: withCount)
        interactor?.fetchPhotos(request: request)
    }
    
    // MARK: Other
    private func photoSelectionCallbackObserver() {
        collectionView.didSelectPhoto = { [weak self] photo in
            guard let self else { return }
            self.interactor?.putInDataStore(photo: photo)
            self.router?.routeToDetailScene()
        }
    }
}

extension MainSceneViewController {
    func setupUI() {
        addCollectionView()
        configureNavigationBar()
    }
    
    private func addCollectionView() {
        addChild(collectionView)
        collectionViewContainer.addSubview(collectionView.view)
        collectionView.didMove(toParent: self)
        collectionView.view.translatesAutoresizingMaskIntoConstraints = false
        collectionView.view.equalConstraint(to: collectionViewContainer)
    }
    
    func configureDependencies() {
        ConfiguratorsLibrary.mainScene.configure(self)
    }
    
    private func configureNavigationBar() {
        navigationItem.searchController = createSearchController()
    }
    
    private func createSearchController() -> UISearchController {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Enter text"
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        return searchController
    }
}

extension MainSceneViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        searchText = text
    }
}

extension MainSceneViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        loadPhotos(by: text, withCount: 35)
    }
}
