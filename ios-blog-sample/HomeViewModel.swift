//
//  HomeViewModel.swift
//  ios-blog-sample
//
//  Created by Pedro Brandão on 14/12/19.
//  Copyright © 2019 Pedro Brandão. All rights reserved.
//

import UIKit
import Siesta

protocol HomeViewModelProtocol {
    
}

class HomeViewModel: HomeViewModelProtocol, ResourceObserver {
    
    private let tableViewSource: TableViewSource
    
    init(for homeView: HomeViewProtocol, posts: Resource, errorHandler: ErrorProtocol) {
        self.tableViewSource = HomeTableViewSource(for: homeView.tableView, list: [])
        
        posts.addObserver(self)
            .loadIfNeeded()?
            .onFailure( { error in
                errorHandler.handle(error)
            })
        posts.addObserver(homeView.statusOverlay)
    }
    
    // MARK: - ResourceObserver protocol
    func resourceChanged(_ resource: Resource, event: ResourceEvent) {
        tableViewSource.list = resource.typedContent() ?? []
    }
}
