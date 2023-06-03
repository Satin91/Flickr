//
//  PhotosCollectionViewCell.swift
//  Flickr
//
//  Created by Артур Кулик on 30.05.2023.
//

import UIKit

class PhotoCollectionViewItem: UICollectionViewCell {
    var imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createImageView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createImageView()
    }
    
    func configure(image: UIImage, radius: CGFloat) {
        imageView.image = image
        imageView.layer.cornerCurve = .continuous
        imageView.layer.cornerRadius = radius
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.equalConstraint(to: self)
    }

    private func createImageView() {
        self.addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
    }
}
