//
//  SearchPhotosSceneViewController.swift
//  Flickr
//
//  Created by Артур Кулик on 01.06.2023.
//  Copyright (c) All rights reserved.

import UIKit

protocol SearchPhotosSceneDisplayLogic: AnyObject {
    func loadSuccess(viewModel: SearchPhotosScene.LoadPhotos.ViewModel)
    func loadError(viewModel: SearchPhotosScene.LoadPhotos.ViewModel)
}

class SearchPhotosSceneViewController: UIViewController, SearchPhotosSceneDisplayLogic {
    var interactor: SearchPhotosSceneInteractor?
    var router: (NSObjectProtocol & SearchPhotosSceneRoutingLogic & SearchPhotosSceneDataPassing)?
    @IBOutlet private var collectionViewContainer: UIView!
    
    let collectionView = PhotoCollectionViewController(collectionViewLayout: UICollectionViewLayout(), layoutSize: .medium)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDependencies()
        photoSelectionCallbackObserver()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
    }
    
    // MARK: - Protocol methods
    
    func loadSuccess(viewModel: SearchPhotosScene.LoadPhotos.ViewModel) {
        guard let photos = viewModel.photos else { return }
        collectionView.display(photos: photos)
    }
    
    func loadError(viewModel: SearchPhotosScene.LoadPhotos.ViewModel) {
        guard let message = viewModel.errorMessage else { return }
        DispatchQueue.main.async {
            AlertController.show(title: "Error", message: message, style: .alert, showOn: self)
        }
    }
    
    // MARK: - Requests to interactor
    
    private func loadPhotos(by text: String, withCount: Int) {
        let request = SearchPhotosScene.LoadPhotos.Request(text: text, photosCount: withCount)
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

extension SearchPhotosSceneViewController {
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
        ConfiguratorsLibrary.searchPhotosScene.configure(self)
    }
    
    private func configureNavigationBar() {
        navigationItem.searchController = createSearchController()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func createSearchController() -> UISearchController {
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "Enter text"
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        return searchController
    }
}

extension SearchPhotosSceneViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        loadPhotos(by: text, withCount: 35)
    }
}
