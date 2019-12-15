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

protocol TableViewSource: UITableViewDataSource, UITableViewDelegate {
    var list: [Post] { get set }
}

class HomeTableViewSource: NSObject, TableViewSource {
    
    private var tableView: UITableView
    
    init(for tableView: UITableView, list: [Post]) {
        self.list = list
        self.tableView = tableView
        
        super.init()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    // MARK: TableViewSource
    var list: [Post] {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - Table view delegate
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeCellIdentifier.defaultCell) else {
            return UITableViewCell()
        }
        cell.textLabel?.text = self.list[indexPath.row].title
        return cell
    }
    
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
}
