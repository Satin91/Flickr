//
//  ActivityView.swift
//  Flickr
//
//  Created by Артур Кулик on 02.06.2023.
//

import UIKit

class ActivityView: UIActivityViewController {
    override init(activityItems: [Any], applicationActivities: [UIActivity]?) {
        super.init(activityItems: activityItems, applicationActivities: applicationActivities)
    }
    
    func showOn(_ controller: UIViewController) {
        controller.present(self, animated: true)
    }
}
