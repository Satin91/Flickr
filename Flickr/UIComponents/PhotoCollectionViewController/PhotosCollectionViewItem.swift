//
//  PhotosCollectionViewCell.swift
//  Flickr
//
//  Created by Артур Кулик on 30.05.2023.
//

import UIKit

class PhotosCollectionViewItem: UICollectionViewCell {
    var imageView = UIImageView()
    let imageRadius: CGFloat = 12
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createImageView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func createImageView() {
        self.addSubview(imageView)
        addImageConstraints()
        self.layer.cornerCurve = .continuous
        self.layer.cornerRadius = self.bounds.height * 0.07
        self.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
    }
    
    func addImageConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
