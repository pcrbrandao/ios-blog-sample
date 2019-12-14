//
//  HomeTableViewController.swift
//  ios-blog-sample
//
//  Created by Pedro Brandão on 14/12/19.
//  Copyright © 2019 Pedro Brandão. All rights reserved.
//

import UIKit

enum HomeCellIdentifier {
    static let defaultCell = "defaultCell"
}

class HomeTableViewSource: NSObject, UITableViewDelegate, UITableViewDataSource {
    override init() {
        // TODO: Setup sources
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeCellIdentifier.defaultCell) else {
            return UITableViewCell()
        }
        cell.textLabel?.text = "cell \(indexPath.item)"
        return cell
    }
    
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    
}
