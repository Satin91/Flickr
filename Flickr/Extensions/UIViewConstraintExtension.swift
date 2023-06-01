//
//  UIViewConstraintExtension.swift
//  Flickr
//
//  Created by Артур Кулик on 01.06.2023.
//

import UIKit

extension UIView {
    func equalConstraint(to: UIView) {
        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(equalTo: to.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: to.trailingAnchor),
            self.bottomAnchor.constraint(equalTo: to.bottomAnchor),
            self.topAnchor.constraint(equalTo: to.topAnchor)
        ])
    }
}
