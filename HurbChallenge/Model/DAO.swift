//
//  ViewController.swift
//  HurbChallenge
//
//  Created by Nathalia Inacio on 01/09/19.
//  Copyright © 2019 Nathalia Inacio. All rights reserved.

import Foundation
import UIKit

protocol Requester {
    func readedData(result:Hotel)
}

class DAO {
    
    static let instance = DAO()
    private init() {}
    
    func jsonReader(page:Int, requester: Requester, on view: UIViewController) {
        let url = "https://www.hurb.com/search/api?q=gramado&page=\(String(page))"
        let urlObj = URL(string: url)
        URLSession.shared.dataTask(with: urlObj!) { (data, response, error) in
            do {
                if data == nil {
                    let alert = UIAlertController(title: "Sem conexão com a internet", message: "Você precisa estar conectado para carregar conteúdo remoto.", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                    view.present(alert, animated: true, completion: nil)
                    return
                }
                let result = try JSONDecoder().decode(Hotel.self, from: data!)
                
                // Logic after response has arrived
                DispatchQueue.main.async {
                    requester.readedData(result: result)
                }
            } catch {
                debugPrint(error)
            }
            }.resume()
    }
}
