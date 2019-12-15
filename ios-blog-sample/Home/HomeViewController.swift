//
//  HomeViewController.swift
//  ios-blog-sample
//
//  Created by Pedro Brandão on 14/12/19.
//  Copyright © 2019 Pedro Brandão. All rights reserved.
//

import UIKit
import Siesta

protocol HomeViewProtocol {
    var tableView: UITableView! { get }
    var statusOverlay: ResourceStatusOverlay { get }
}

class HomeViewController: UIViewController, HomeViewProtocol {
    
    private var homeViewModel: HomeViewModel!
    
    // MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        statusOverlay.embed(in: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let errorHandler = OnloadError()
        let localStorage = CoreDataStorage(errorHandler: errorHandler)
        homeViewModel = HomeViewModel(for: self, posts: apiService.posts,
                                      errorHandler: LoadLocalHomeOnError(localStorage: localStorage), localStorage: localStorage)
    }
    
    override func viewDidLayoutSubviews() {
        statusOverlay.positionToCoverParent()
    }
    
    // MARK: - HomeViewProtocol
    @IBOutlet weak var tableView: UITableView!
    var statusOverlay = ResourceStatusOverlay()
}
