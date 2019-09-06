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
    
    @IBOutlet weak var login: UIView!
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    // MARK: View Cicle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // View shadows and colors
        login.backgroundColor = UIColor.paletteLightGray
        login.layer.shadowOffset = CGSize(width: 0, height: 0)
        login.layer.shadowColor = UIColor.black.cgColor
        login.layer.shadowOpacity = 0.5
        login.layer.shadowRadius = 8
        login.layer.cornerRadius = 12
        
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
