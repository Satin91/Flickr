//
//  PhotoEditorSceneViewController.swift
//  Flickr
//
//  Created by Артур Кулик on 03.06.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol PhotoEditorSceneDisplayLogic: AnyObject {
    func fillData(viewModel: PhotoEditorScene.InitialSetup.ViewModel)
    func displayFilter(viewModel: PhotoEditorScene.PhotoEditor.ViewModel)
    func displayFilters(viewModel: PhotoEditorScene.LoadFilters.ViewModel)
    func receiveSavingResult(viewModel: PhotoEditorScene.Gallery.ViewModel)
    func receiveRemovingResult(viewModel: PhotoEditorScene.Database.ViewModel)
}

class PhotoEditorSceneViewController: UIViewController, PhotoEditorSceneDisplayLogic {
    var interactor: PhotoEditorSceneBusinessLogic?
    var router: (NSObjectProtocol & PhotoEditorSceneRoutingLogic & PhotoEditorSceneDataPassing)?
    var collectionView: PhotoFilterCollectionViewController!
    
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private var collectionViewContainer: UIView!
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var menuButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animateActivityIndicator()
        initialUISetup()
        setupUI()
        loadFilters()
        filterSelectionObserver()
    }
    
    // MARK: Protocol methods
    
    func fillData(viewModel: PhotoEditorScene.InitialSetup.ViewModel) {
        imageView.image = viewModel.photoModel.image
    }
    
    func displayFilter(viewModel: PhotoEditorScene.PhotoEditor.ViewModel) {
        let image = viewModel.image
        DispatchQueue.main.async {
            self.changeFiltered(image: image)
        }
    }
    
    func displayFilters(viewModel: PhotoEditorScene.LoadFilters.ViewModel) {
        collectionView.display(filters: viewModel.images)
        stopAnimateActivityIndicator()
    }
    
    func receiveSavingResult(viewModel: PhotoEditorScene.Gallery.ViewModel) {
        print("Saving result \(viewModel.success)")
    }
    
    func receiveRemovingResult(viewModel: PhotoEditorScene.Database.ViewModel) {
        self.dismiss(animated: true)
    }
    
    // MARK: Requests to the interactor
    
    func initialUISetup() {
        let request = PhotoEditorScene.InitialSetup.Request()
        interactor?.initialSetup(request: request)
    }
    
    func loadFilters() {
        interactor?.fetchFilters(request: PhotoEditorScene.LoadFilters.Request(image: UIImage(), filters: []))
    }
    
    func savePhotoToGallery() {
        guard let image = imageView.image else { return }
        let request = PhotoEditorScene.Gallery.Request(image: image)
        interactor?.uploadToGallery(request: request)
    }
    
    // MARK: Menu actions
    
    private func savePhotoToGalleryAction() {
        savePhotoToGallery()
    }
    
    func removePhotoAction() {
        interactor?.removePhoto(request: PhotoEditorScene.Gallery.Request(image: UIImage()))
    }
    
    // MARK: Other
    
    private func filterSelectionObserver() {
        collectionView.didSelectFilter = { [weak self] index in
            guard let self else { return }
            self.interactor?.applyFilter(request: PhotoEditorScene.PhotoEditor.Request(image: UIImage(), filterIndex: index) )
        }
    }
}

extension PhotoEditorSceneViewController {
    private func setupUI() {
        addCollectionView()
        setupMenu()
    }
    
    private func addCollectionView() {
        collectionView = PhotoFilterCollectionViewController(collectionViewLayout: UICollectionViewLayout(), frame: collectionViewContainer.frame)
        addChild(collectionView)
        collectionViewContainer.addSubview(collectionView.view)
        collectionView.didMove(toParent: self)
        collectionView.view.translatesAutoresizingMaskIntoConstraints = false
        collectionView.view.equalConstraint(to: collectionViewContainer)
    }
    
    private func animateActivityIndicator() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    private func stopAnimateActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.isHidden = true
            self.activityIndicator.stopAnimating()
        }
    }
    
    private func setupMenu() {
        let saveToGallery = UIAction(title: "Save to photos", image: UIImage(systemName: "square.and.arrow.down")) { _ in
            self.savePhotoToGalleryAction()
        }
        
        let removePhoto = UIAction(title: "Remove", image: UIImage(systemName: "trash"), attributes: .destructive) { _ in
            self.removePhotoAction()
        }
        
        let menu = UIMenu(children: [saveToGallery, removePhoto])
        menuButton.menu = menu
        menuButton.showsMenuAsPrimaryAction = true
    }
    
    private func changeFiltered(image: UIImage) {
        UIView.transition(
            with: imageView,
            duration: 0.25,
            options: .transitionCrossDissolve,
            animations: { self.imageView.image = image },
            completion: nil
        )
    }
}
