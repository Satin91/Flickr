//
//  PhotoCollectionViewController.swift
//  Flickr
//
//  Created by Артур Кулик on 30.05.2023.
//

import UIKit

private struct PhotoCollectionViewConfig {
    let reuseIdentifier = "photosCollectionViewCell"
    var horizontalSpacing: CGFloat
    var verticalSpacing: CGFloat
    var itemsPerLine: CGFloat
    var minimumLineSpacing: CGFloat = 12
    var spacingCount: CGFloat {
        itemsPerLine + 1
    }
}

class PhotoCollectionViewController: UICollectionViewController {
    enum LayoutSize {
        case small
        case medium
        case large
    }
    
    private var config: PhotoCollectionViewConfig!
    private var photoArray: [PhotoModel] = []
    var didSelectPhoto: ((PhotoModel) -> Void)?
    
    convenience init(collectionViewLayout layout: UICollectionViewLayout, layoutSize: LayoutSize) {
        self.init(collectionViewLayout: UICollectionViewLayout())
        switch layoutSize {
        case .small:
            self.config = .init(horizontalSpacing: 12, verticalSpacing: 12, itemsPerLine: 5)
        case .medium:
            self.config = .init(horizontalSpacing: 12, verticalSpacing: 12, itemsPerLine: 3)
        case .large:
            self.config = .init(horizontalSpacing: 12, verticalSpacing: 12, itemsPerLine: 1, minimumLineSpacing: 40)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCollectionViewItem()
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: config.reuseIdentifier, for: indexPath) as! PhotosCollectionViewItem
        let image = photoArray[indexPath.row].image
        cell.imageView.image = image
        return cell
    }
    
    func display(photos: [PhotoModel]) {
        photoArray = photos
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    private func registerCollectionViewItem() {
        collectionView.register(PhotosCollectionViewItem.self, forCellWithReuseIdentifier: config.reuseIdentifier)
    }
    
    private func setupLayout() {
        let layout = UICollectionViewFlowLayout()
        let itemSide = (self.collectionView.bounds.width - config.horizontalSpacing * config.spacingCount) / config.itemsPerLine
        layout.itemSize = CGSize(width: itemSide, height: itemSide)
        layout.minimumLineSpacing = config.minimumLineSpacing
        layout.sectionInset = UIEdgeInsets(
            top: config.verticalSpacing,
            left: config.horizontalSpacing,
            bottom: config.verticalSpacing,
            right: config.horizontalSpacing
        )
        collectionView.collectionViewLayout = layout
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectPhoto?(photoArray[indexPath.row])
    }
}
