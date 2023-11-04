//
//  Presenter.swift
//  CryptoViperProtocolOriented
//
//  Created by Nahit Çalışır on 3.11.2023.
//

import Foundation

//talks to interactor, router, view
//class, prptocol

enum ApiError: Error {
    case NetworkFailed
    case NoData
    case ParsingFailed
}

protocol AnyPresener {
    
    var router:AnyRouter? {get set}
    var interactor:AnyInteractor? {get set}
    var view: AnyView? {get set}
    
    func interactorDidDownloadCrypto(result: Result<[Crypto],ApiError>)
}

class CryptoPresenter: AnyPresener {
    
    var router: AnyRouter?
    
    var interactor: AnyInteractor? {
        didSet {
            interactor?.downloadCryptos()
        }
    }
    
    var view: AnyView?
    
    func interactorDidDownloadCrypto(result: Result<[Crypto],ApiError>) {
        
        switch result {
        case .success(let cryptos):
            view?.update(with: cryptos)
        case .failure(let error):
            view?.update(with: error.localizedDescription)
            print(error.localizedDescription)
        }
    }
   
}
