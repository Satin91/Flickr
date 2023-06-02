//
//  PhotoCollectionViewController.swift
//  Flickr
//
//  Created by Артур Кулик on 30.05.2023.
//

import UIKit

class PhotoCollectionViewController: UICollectionViewController {
    private let reuseIdentifier = "photosCollectionViewCell"
    var horizontalSpacing: CGFloat = 12
    var verticalSpacing: CGFloat = 12
    var itemsPerLine: CGFloat = 3
    private var spacingCount: CGFloat {
        itemsPerLine + 1
    }
    var didSelectPhoto: ((PhotoModel) -> Void)?
    
    var photoArray: [PhotoModel] = []
    
    convenience init(itemsPerLine: CGFloat) {
        self.init(collectionViewLayout: UICollectionViewLayout())
        self.itemsPerLine = itemsPerLine
    }
    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//    }
    
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotosCollectionViewItem
        let image = photoArray[indexPath.row].image
        cell.imageView.image = image
        return cell
    }
    
    private func registerCollectionViewItem() {
        collectionView.register(PhotosCollectionViewItem.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    private func setupLayout() {
        let layout = UICollectionViewFlowLayout()
        let itemSide = (self.collectionView.bounds.width - horizontalSpacing * spacingCount) / itemsPerLine
        layout.itemSize = CGSize(width: itemSide, height: itemSide)
        layout.sectionInset = UIEdgeInsets(top: verticalSpacing, left: horizontalSpacing, bottom: verticalSpacing, right: horizontalSpacing)
        collectionView.collectionViewLayout = layout
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectPhoto?(photoArray[indexPath.row])
    }
}
