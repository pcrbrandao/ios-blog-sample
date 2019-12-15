//
//  HomeViewModel.swift
//  ios-blog-sample
//
//  Created by Pedro Brandão on 14/12/19.
//  Copyright © 2019 Pedro Brandão. All rights reserved.
//

import UIKit
import Siesta

protocol HomeViewModelProtocol { }

class HomeViewModel: HomeViewModelProtocol, ResourceObserver {
    
    private let tableViewSource: TableViewSource
    private let localStorage: LocalStorageProtocol
    
    init(for homeView: HomeViewProtocol, posts: Resource,
         errorHandler: LoadLocalHomeOnErrorProtocol, localStorage: LocalStorageProtocol) {
        self.tableViewSource = HomeTableViewSource(for: homeView.tableView, list: [])
        self.localStorage = localStorage
        
        posts.addObserver(self)
            .loadIfNeeded()?
            .onFailure( { error in
                errorHandler.handle(error, tableViewSource: self.tableViewSource, homeView: homeView)
            })
        posts.addObserver(homeView.statusOverlay)
    }
    
    // MARK: - ResourceObserver protocol
    func resourceChanged(_ resource: Resource, event: ResourceEvent) {
        tableViewSource.list = resource.typedContent() ?? []
        localStorage.save(tableViewSource.list)
    }
}
