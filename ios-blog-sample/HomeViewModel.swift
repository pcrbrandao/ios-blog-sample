//
//  HomeViewModel.swift
//  ios-blog-sample
//
//  Created by Pedro Brandão on 14/12/19.
//  Copyright © 2019 Pedro Brandão. All rights reserved.
//

import UIKit
import Siesta

class HomeViewModel {
    
    let tableViewSource: TableViewSource
    let homeView: HomeViewProtocol
    let baseAPI: Service
    
    let url = "https://jsonplaceholder.typicode.com"
    
    init(for homeView: HomeViewProtocol) {
        self.tableViewSource = HomeTableViewSource(for: homeView.tableView)
        self.homeView = homeView
        self.baseAPI = Service(baseURL: url)
        
        
    }
}
