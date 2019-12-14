//
//  HomeViewController.swift
//  ios-blog-sample
//
//  Created by Pedro Brandão on 14/12/19.
//  Copyright © 2019 Pedro Brandão. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var tableViewDelegate: HomeTableViewSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        tableViewDelegate = HomeTableViewSource()
        tableView.delegate = tableViewDelegate
        tableView.dataSource = tableViewDelegate
    }
}
