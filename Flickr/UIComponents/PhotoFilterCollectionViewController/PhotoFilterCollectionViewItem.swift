//
//  PhotoFilterCollectionViewItem.swift
//  Flickr
//
//  Created by Артур Кулик on 04.06.2023.
//

import UIKit

class PhotoFilterCollectionViewItem: UICollectionViewCell {
    var imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createImageView()
        putLightShadow()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func makeSelected(condition: Bool) {
        if condition {
            UIView.animate(withDuration: 0.1, delay: .zero) {
                self.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
            }
        } else {
            UIView.animate(withDuration: 0.1, delay: .zero) {
                self.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        }
    }
    
    func createImageView() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.equalConstraint(to: self)
    }
    
    func configure(image: UIImage, radius: CGFloat) {
        imageView.image = image
        imageView.layer.cornerCurve = .continuous
        imageView.layer.cornerRadius = radius
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
    }
    
    func putLightShadow() {
        let shadowLayer = CAShapeLayer()
        shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 12).cgPath
        shadowLayer.fillColor = UIColor.white.cgColor
        shadowLayer.shadowColor = UIColor.darkGray.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = CGSize(width: 2, height: 2)
        shadowLayer.shadowOpacity = 0.2
        shadowLayer.shadowRadius = 14
        layer.insertSublayer(shadowLayer, at: 0)
    }
}
