//
//  AlertController.swift
//  Flickr
//
//  Created by Артур Кулик on 02.06.2023.
//

import UIKit

class AlertController: UIAlertController {
    enum AlertStyle {
        case alert
        case interactive
    }

    static func show(title: String, message: String, style: AlertStyle, showOn controller: UIViewController) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        switch style {
        case .alert:
            alert.addAction(
                UIAlertAction(
                    title: "Okay",
                    style: .cancel,
                    handler: { _ in }
                )
            )
        case .interactive:
            alert.addAction(
                UIAlertAction(
                    title: "TODO: create parameter in this title",
                    style: .default,
                    handler: { _ in }
                )
            )
        }
        controller.present(alert, animated: true, completion: nil)
    }
}
