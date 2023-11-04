//
//  View.swift
//  CryptoViperProtocolOriented
//
//  Created by Nahit Çalışır on 3.11.2023.
//

import Foundation
import UIKit

//talks to presenter
//class, prptocol
//viewController

protocol AnyView {
    
    var presenter:AnyPresener? {get set}
    
    func update(with cryptos:[Crypto])
    func update(with error: String)
}

class CryptoViewController: UIViewController, AnyView {
    
    var cryptoList = [Crypto]()
    
    
    //MARK: - Add Tableview
    private let cryptoTableView :UITableView = {
        let tableview = UITableView()
        //tableview.register(UITableView.self, forCellReuseIdentifier: "cell")
        tableview.isHidden = true
        tableview.translatesAutoresizingMaskIntoConstraints = false
        return tableview
    }()
    
    //MARK: - Add Label
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.isHidden = false
        label.text = "Downloading ..."
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.red
        label.textAlignment = .center
        return label
    }()
    
    //MARK: - Protocol Needed
    var presenter: AnyPresener?
    
    
    //MARK: - Update View
    func update(with cryptos: [Crypto]) {
        
        DispatchQueue.main.async {
            self.cryptoList = cryptos
            self.messageLabel.isHidden = true
            self.cryptoTableView.reloadData()
            self.cryptoTableView.isHidden = false
        }
    }
    
    func update(with error: String) {
        DispatchQueue.main.async {
            self.cryptoList = []
            self.cryptoTableView.isEditing = true
            self.messageLabel.text = error
            self.messageLabel.isHidden = false
        }
    }
    
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    
    //MARK: - Setup View Func
    func setupView() {
        
        cryptoTableView.delegate = self
        cryptoTableView.dataSource = self
        
        view.backgroundColor = .systemYellow
        view.addSubview(cryptoTableView)
        view.addSubview(messageLabel)
   
        //MARK: - Constraits
        // Bu yöntemle itemları birbirine hizalayabiliriz
//        NSLayoutConstraint.activate([
//            cryptoTableView.topAnchor.constraint(equalTo: view.topAnchor),
//            cryptoTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            cryptoTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            cryptoTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
        
        // Ekrana kople sağdıracak isek aşağıdaki gibi tek satırda yapabiliriz
        cryptoTableView.frame = view.bounds
        
        // MessageLable yi ekrana ortaladık
        messageLabel.frame = CGRect(x: view.frame.width / 2 - 100, y: view.frame.height / 2 - 25, width: 200, height: 50)
    }
    
}

//MARK: - Tableview Extention
extension CryptoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = cryptoList[indexPath.row].currency
        content.secondaryText = cryptoList[indexPath.row].price
        cell.contentConfiguration = content
        return cell
    }
    
    
}
