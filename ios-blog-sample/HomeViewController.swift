//
//  HomeViewController.swift
//  ios-blog-sample
//
//  Created by Pedro Brandão on 14/12/19.
//  Copyright © 2019 Pedro Brandão. All rights reserved.
//

import UIKit

protocol HomeViewProtocol {
    var tableView: UITableView! { get }
}

class HomeViewController: UIViewController, HomeViewProtocol {

    @IBOutlet weak var tableView: UITableView!
    
    var homeViewModel: HomeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeViewModel = HomeViewModel(for: self)
    }
}
