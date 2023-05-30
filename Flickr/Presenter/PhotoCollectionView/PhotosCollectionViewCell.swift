//
//  PhotosCollectionViewCell.swift
//  Flickr
//
//  Created by Артур Кулик on 30.05.2023.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    var imageView = UIImageView()
    
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
        self.layer.cornerRadius = 12
        self.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
    }
    
    func addImageConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}
