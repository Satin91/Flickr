//
//  ViewController.swift
//  Flickr
//
//  Created by Артур Кулик on 30.05.2023.
//

import UIKit
import Alamofire
import AlamofireImage

class MainViewController: UIViewController {
    var viewModel: MainViewModel = DIContainer.shared.createMainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "photoCollectionView" {
            let collectionView = segue.destination as! PhotoCollectionViewController
            fill(collectionView: collectionView)
        }
    }
    
    private func fill(collectionView: PhotoCollectionViewController) {
        Task {
            try await viewModel.parse()
            collectionView.photoArray = viewModel.photos
            collectionView.collectionView.reloadData()
        }
    }
}
