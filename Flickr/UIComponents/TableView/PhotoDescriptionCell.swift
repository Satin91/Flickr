//
//  PhotoDescriptionTableViewCell.swift
//  Flickr
//
//  Created by Артур Кулик on 03.06.2023.
//

import UIKit

class PhotoDescriptionCell: UITableViewCell {
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var bodyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(title: String, text: String) {
        titleLabel.text = title
        bodyLabel.text = text
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
