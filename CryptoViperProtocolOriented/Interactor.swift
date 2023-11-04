//
//  Interactor.swift
//  CryptoViperProtocolOriented
//
//  Created by Nahit Çalışır on 3.11.2023.
//


// https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json
import Foundation

//talks to presenter
//class, prptocol

protocol AnyInteractor {
    var presenter:AnyPresener? {get set}
    
    func downloadCryptos()
}

class CryptoInteractor:AnyInteractor {
    
    var presenter: AnyPresener?
    
    func downloadCryptos() {
        
        guard let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json") else {return}
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                self?.presenter?.interactorDidDownloadCrypto(result: .failure(.NetworkFailed))
                print(error.localizedDescription)
            }
            
            guard let data = data, error == nil else {
                self?.presenter?.interactorDidDownloadCrypto(result: .failure(.NoData))
                return
            }
            
            do {
                let cryptos = try JSONDecoder().decode([Crypto].self, from: data)
                self?.presenter?.interactorDidDownloadCrypto(result: .success(cryptos))
            } catch {
                self?.presenter?.interactorDidDownloadCrypto(result: .failure(.ParsingFailed))
                print(error.localizedDescription)
            }
        }
        task.resume()
        
    }
    
    
}
