//
//  PhotoDescriptionTableTableViewController.swift
//  Flickr
//
//  Created by Артур Кулик on 03.06.2023.
//

import UIKit

class PhotoDescriptionTableView: UITableViewController {
    struct TextPairs {
        var title: String
        var body: String
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private var textPairs: [TextPairs] = []
    
    func display(text: [TextPairs]) {
        textPairs = text
        tableView.reloadData()
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: "PhotoDescriptionCell", bundle: nil), forCellReuseIdentifier: Constants.ViewIdentifiers.photoDescriptionCell)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        textPairs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.ViewIdentifiers.photoDescriptionCell, for: indexPath) as! PhotoDescriptionCell
        let pair = textPairs[indexPath.row]
        cell.configure(title: pair.title, text: pair.body)
        cell.selectionStyle = .none
        return cell
    }
}
