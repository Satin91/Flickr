//
//  DetailSceneViewController.swift
//  Flickr
//
//  Created by Артур Кулик on 01.06.2023.
//  Copyright (c) 2023. All rights reserved.

import UIKit

protocol DetailSceneDisplayLogic: AnyObject {
    func displayData(viewModel: DetailScene.InitialSetup.ViewModel)
    func showActivityView(viewModel: DetailScene.Share.ViewModel)
    func receiveSavingToDB(viewModel: DetailScene.SaveToDB.ViewModel)
}

class DetailSceneViewController: UIViewController, DetailSceneDisplayLogic {
    @IBOutlet private var tableViewContainer: UIView!
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var menuButton: UIButton!
    
    var interactor: DetailSceneBusinessLogic?
    var router: (DetailSceneRoutingLogic & DetailSceneDataPassing)?
    
    let tableView = PhotoDescriptionTableView(style: .insetGrouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialUISetup()
        setupUI()
    }
    
    // MARK: - Protocol methods
    
    func displayData(viewModel: DetailScene.InitialSetup.ViewModel) {
        imageView.image = viewModel.photoModel.image
        tableView.display(
            text: [
                .init(title: "Title", body: viewModel.photoModel.title),
                .init(title: "Author", body: viewModel.photoModel.owner)
            ]
        )
    }
    
    func receiveSavingToDB(viewModel: DetailScene.SaveToDB.ViewModel) {
        print("Save to database completed ? \(viewModel.isSaved)")
    }
    
    func showActivityView(viewModel: DetailScene.Share.ViewModel) {
        viewModel.activityView.showOn(self)
    }
    
    // MARK: - Requests to interactor
    
    func initialUISetup() {
        let request = DetailScene.InitialSetup.Request()
        interactor?.loadData(request: request)
    }
    
    // MARK: - Menu actions
    
    private func saveToFavorites() {
        interactor?.saveObjectToDatabase()
    }
    
    private func sharePhoto() {
        self.interactor?.shareLink()
    }
    
    private func openLink() {
        interactor?.openLink()
    }
}

extension DetailSceneViewController {
    private func setupUI() {
        addTableView()
        setupMenu()
        configureNavigationBar()
    }
    
    private func addTableView() {
        addChild(tableView)
        tableViewContainer.addSubview(tableView.view)
        tableView.didMove(toParent: self)
        tableView.view.translatesAutoresizingMaskIntoConstraints = false
        tableView.view.equalConstraint(to: tableViewContainer)
        tableView.tableView.isScrollEnabled = false
    }
    
    private func setupMenu() {
        let share = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up")) { _ in
            self.sharePhoto()
        }
        let openLink = UIAction(title: "Open Link", image: UIImage(systemName: "link")) { _ in
            self.openLink()
        }
        let addToFavorites = UIAction(title: "Save to favorites", image: UIImage(systemName: "star")) { _ in
            self.saveToFavorites()
        }
        
        let menu = UIMenu(children: [share, openLink, addToFavorites])
        menuButton.menu = menu
        menuButton.showsMenuAsPrimaryAction = true
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
    }
}
