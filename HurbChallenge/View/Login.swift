//
//  Login.swift
//  HurbChallenge
//
//  Created by Nathalia Inacio on 01/09/19.
//  Copyright © 2019 Nathalia Inacio. All rights reserved.
//

import UIKit

class Login: UIViewController {
    
    // MARK: - Initialization
    
    // MARK: Outlets
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    // MARK: View Cicle
    override func viewDidLoad() {
        
        super.viewDidLoad()

        
        showLoginButton(button: loginButton)
        
    }
    
    
    // MARK: Auxiliar
    
    // Button rounded corners
    func showLoginButton(button: UIButton) {
        button.layer.cornerRadius = 25
        button.clipsToBounds = true
        button.layer.masksToBounds = true
    }
    

}
