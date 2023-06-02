//
//  UIViewControllerInstantiate.swift
//  Flickr
//
//  Created by Артур Кулик on 01.06.2023.
//

import UIKit

extension UIViewController {
    func instantiate() -> UIViewController {
        let id = String(describing: type(of: self))
        let vc = UIStoryboard(name: Constants.Navigation.StoryboardsNames.main, bundle: nil).instantiateViewController(withIdentifier: id)
        return vc
    }
}
