//
//  TabBarController.swift
//  Flickr
//
//  Created by Артур Кулик on 02.06.2023.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupItems()
    }
    
    func setupItems() {
        guard let items = tabBar.items else { return }
        items[0].setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for: .normal)
        items[1].setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], for: .normal)
    }
}
