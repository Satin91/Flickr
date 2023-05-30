//
//  PhotoCollectionViewController.swift
//  Flickr
//
//  Created by Артур Кулик on 30.05.2023.
//

import UIKit

private let reuseIdentifier = "photosCollectionViewCell"

class PhotoCollectionViewController: UICollectionViewController {
    private let itemCount: CGFloat = 3
    private let horizontalSpacing: CGFloat = 12
    private let verticalSpacing: CGFloat = 12
    var photoArray: [UIImage] = [] {
        didSet {
            print("Set new photo")
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adjustCollectionView()
        print("Collection View init")
    }
    
    private func adjustCollectionView() {
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let layout = UICollectionViewFlowLayout()
        let itemSide = (self.collectionView.bounds.width - horizontalSpacing * 4) / itemCount
        layout.itemSize = CGSize(width: itemSide, height: itemSide)
        layout.sectionInset = UIEdgeInsets(top: verticalSpacing, left: horizontalSpacing, bottom: verticalSpacing, right: horizontalSpacing)
        collectionView.collectionViewLayout = layout
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("Photo array \(photoArray.count)")
        return photoArray.count
    }
   
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotosCollectionViewCell
        let image = photoArray[indexPath.row]
        cell.imageView.image = image
        return cell
    }
}
