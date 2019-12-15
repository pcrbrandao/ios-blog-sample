//
//  ConnectivityProtocol.swift
//  ios-blog-sample
//
//  Created by Pedro Brandão on 15/12/19.
//  Copyright © 2019 Pedro Brandão. All rights reserved.
//

import Foundation
import Alamofire

protocol ConnectivityProtocol {
    static var isConnectedToInternet:Bool { get }
}

class Connectivity: ConnectivityProtocol {
    static var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
