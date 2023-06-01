//
//  PhotoCollectionViewController.swift
//  Flickr
//
//  Created by Артур Кулик on 30.05.2023.
//

import UIKit

class PhotoCollectionViewController: UICollectionViewController {
    private let itemCount: CGFloat = 3
    private let horizontalSpacing: CGFloat = 12
    private let verticalSpacing: CGFloat = 12
    private let reuseIdentifier = "photosCollectionViewCell"
    private var spacingCount: CGFloat {
        itemCount + 1
    }
    
    var photoArray: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupLayout()
        collectionView.backgroundColor = .clear
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photoArray.count
    }
   
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotosCollectionViewItem
        let image = photoArray[indexPath.row]
        cell.imageView.image = image
        return cell
    }
    
    private func registerItem() {
        collectionView.register(PhotosCollectionViewItem.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    private func setupLayout() {
        let layout = UICollectionViewFlowLayout()
        let itemSide = (self.collectionView.bounds.width - horizontalSpacing * spacingCount) / itemCount
        layout.itemSize = CGSize(width: itemSide, height: itemSide)
        layout.sectionInset = UIEdgeInsets(top: verticalSpacing, left: horizontalSpacing, bottom: verticalSpacing, right: horizontalSpacing)
        collectionView.collectionViewLayout = layout
    }
}
