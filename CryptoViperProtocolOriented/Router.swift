//
//  Router.swift
//  CryptoViperProtocolOriented
//
//  Created by Nahit Çalışır on 3.11.2023.
//

import Foundation
import UIKit


// calss, prptocol
// Entry point

typealias EntryPoint = AnyView & UIViewController

protocol AnyRouter {
    var entry: EntryPoint? { get }
    static func startExecution() -> AnyRouter
}


class CryptoRouter: AnyRouter {
    
    var entry: EntryPoint?
    
    static func startExecution() -> AnyRouter {
        
        let router = CryptoRouter()
        
        var view: AnyView = CryptoViewController()
        var interactor: AnyInteractor = CryptoInteractor()
        var presenter: AnyPresener = CryptoPresenter()
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = view
        
        router.entry = view as? EntryPoint
        
        return router
    }
  
}
