//
//  ErrorProtocol.swift
//  ios-blog-sample
//
//  Created by Pedro Brandão on 15/12/19.
//  Copyright © 2019 Pedro Brandão. All rights reserved.
//

import UIKit
import Siesta

protocol ErrorProtocol {
    func handle(_ error: Error)
}

protocol LoadLocalHomeOnErrorProtocol {
    func handle(_ error: Error, tableViewSource: TableViewSource, homeView: HomeViewProtocol)
}

class LoadLocalHomeOnError: LoadLocalHomeOnErrorProtocol {
    private let localStorage: LocalStorageProtocol
    
    init(localStorage: LocalStorageProtocol) {
        self.localStorage = localStorage
    }
    
    func handle(_ error: Error, tableViewSource: TableViewSource, homeView: HomeViewProtocol) {
        homeView.statusOverlay.isHidden = true
        tableViewSource.list = localStorage.posts()
    }
}

class OnloadError: ErrorProtocol {
    func handle(_ error: Error) {
        if let reqError = error as? RequestError {
            print("Erro tentando carregar os dados...\n\(reqError.userMessage)\n\(String(describing: reqError.cause))")
            return
        }
        
        print("Erro desconhecido: \(error)")
    }
}
