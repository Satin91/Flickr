//
//  PhotoFilterCollectionView.swift
//  Flickr
//
//  Created by Артур Кулик on 04.06.2023.
//

import UIKit

private struct PhotoCollectionViewConfig {
    let reuseIdentifier = "photosCollectionViewCell"
    var horizontalSpacing: CGFloat = 24
    var verticalSpacing: CGFloat = 24
    var itemSize: CGSize = .zero
    var radius: CGFloat = 12
}

class PhotoFilterCollectionViewController: UICollectionViewController {
    private var config = PhotoCollectionViewConfig()
    
    var imageArray: [UIImage] = []
    var didSelectFilter: ((Int) -> Void)?
    var selectedIndexPath: IndexPath! {
        didSet {
            collectionView.reloadData()
        }
    }
    
    convenience init(collectionViewLayout layout: UICollectionViewLayout, frame: CGRect) {
        self.init(collectionViewLayout: UICollectionViewLayout())
        setupConfig(frame: frame)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(PhotoFilterCollectionViewItem.self, forCellWithReuseIdentifier: config.reuseIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
    }
    
    func setupUI() {
        applyLayout()
        collectionView.backgroundColor = .systemGray5
        collectionView.allowsMultipleSelection = false
    }
    
    func display(filters: [UIImage]) {
        self.imageArray = filters
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    private func removeSelection() {
        for index in 0...imageArray.count {
            guard let cell = collectionView.cellForItem(at: IndexPath(item: index, section: 0)) as? PhotoFilterCollectionViewItem else { return }
            print("index \(index)")
        }
    }
    
    private func applyLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = config.itemSize
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = config.horizontalSpacing
        layout.sectionInset = UIEdgeInsets(
            top: config.verticalSpacing,
            left: config.horizontalSpacing,
            bottom: config.verticalSpacing,
            right: config.horizontalSpacing
        )
        collectionView.collectionViewLayout = layout
    }
    
    func setupConfig(frame: CGRect) {
        config = PhotoCollectionViewConfig(
            itemSize: .init(
                width: frame.height - config.verticalSpacing,
                height: frame.height - config.verticalSpacing
            )
        )
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imageArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: config.reuseIdentifier, for: indexPath) as! PhotoFilterCollectionViewItem
        cell.configure(image: imageArray[indexPath.row], radius: config.radius)
        cell.makeSelected(condition: selectedIndexPath == indexPath)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        didSelectFilter?(indexPath.item)
    }
}
