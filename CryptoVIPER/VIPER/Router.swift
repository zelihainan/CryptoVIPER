//
//  Router.swift
//  CryptoVIPER
//
//  Created by Zeliha İnan on 27.08.2025.
//

import Foundation

protocol AnyRouter {
    static func startExecution() -> AnyRouter
}

class CryptoRouter: AnyRouter {
    static func startExecution() -> AnyRouter {
        let router = CryptoRouter()
        return router
    }
    
}
