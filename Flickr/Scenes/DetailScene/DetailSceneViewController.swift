//
//  DetailSceneViewController.swift
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

protocol DetailSceneDisplayLogic: AnyObject {
    func initialSetup(viewModel: DetailScene.InitialSetup.ViewModel)
    func showActivityView(viewModel: DetailScene.Share.ViewModel)
    func savingToDBCompleted(viewModel: DetailScene.SaveToDB.ViewModel)
}

class DetailSceneViewController: UIViewController, DetailSceneDisplayLogic {
    @IBOutlet private var tableViewContainer: UIView!
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var menuButton: UIButton!
    var interactor: DetailSceneBusinessLogic?
    var router: (DetailSceneRoutingLogic & DetailSceneDataPassing)?
    var menu = UIMenu()
    
    let tableView = PhotoDescriptionTableView(style: .insetGrouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillData()
        setupUI()
    }
    
    func fillData() {
        let request = DetailScene.InitialSetup.Request()
        interactor?.initialSetup(request: request)
    }
    
    func saveToFavorites() {
        interactor?.saveObjectToDatabase()
    }
    
    func sharePhoto() {
        self.interactor?.shareLink()
    }
    
    func openLink() {
        interactor?.openLink()
    }
    
    func initialSetup(viewModel: DetailScene.InitialSetup.ViewModel) {
        imageView.image = viewModel.photoModel.image
        tableView.display(
            text: [
                PhotoDescriptionTableView.TextPairs(title: "Title", body: viewModel.photoModel.title),
                PhotoDescriptionTableView.TextPairs(title: "Author", body: viewModel.photoModel.owner)
            ]
        )
    }
    
    func showActivityView(viewModel: DetailScene.Share.ViewModel) {
        viewModel.activityView.showOn(self)
    }
    
    func savingToDBCompleted(viewModel: DetailScene.SaveToDB.ViewModel) {
        print("Save to database completed ? \(viewModel.isSaved)")
    }
}

extension DetailSceneViewController {
    private func setupUI() {
        addTableView()
        setupMenu()
    }
    
    private func addTableView() {
        addChild(tableView)
        tableViewContainer.addSubview(tableView.view)
        tableView.didMove(toParent: self)
        tableView.view.translatesAutoresizingMaskIntoConstraints = false
        tableView.view.equalConstraint(to: tableViewContainer)
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
        
        self.menu = UIMenu(children: [share, openLink, addToFavorites])
        menuButton.menu = menu
        menuButton.showsMenuAsPrimaryAction = true
    }
}
