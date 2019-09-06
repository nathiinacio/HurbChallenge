//
//  CreateNewAccount.swift
//  HurbChallenge
//
//  Created by Nathalia Inacio on 05/09/19.
//  Copyright © 2019 Nathalia Inacio. All rights reserved.
//

import UIKit

class CreateNewAccount: UIViewController {
    
    // MARK: - Initialization
    
    // MARK: Outlets
    @IBOutlet weak var confirmButton: UIButton!
    
    
    // MARK: View Cicle
    override func viewDidLoad() {
        
        // Button rounded corners
        
        showNewAccountButton(button: confirmButton)
 
    }
    
     // MARK: Auxiliar
    
    // Button rounded corners
    func showNewAccountButton(button: UIButton) {
        button.layer.cornerRadius = 25
        button.clipsToBounds = true
        button.layer.masksToBounds = true
    }
    
    // MARK: Actions
    @IBAction func confirmButton(_ sender: Any) {
    }
    
    
}
