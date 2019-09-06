//
//  ViewController.swift
//  HurbChallenge
//
//  Created by Nathalia Inacio on 01/09/19.
//  Copyright © 2019 Nathalia Inacio. All rights reserved.

import UIKit
//import FirebaseAuth
//import Firebase


class Start: UIViewController {
    
    
    
    // MARK: - Initialization
    // MARK: Outlets
    
    @IBOutlet weak var createNewAccountButton: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    // MARK: View Cicle
    override func viewDidLoad() {

        super.viewDidLoad()
        showButtons(button: loginButton)
        showButtons(button: createNewAccountButton)

    }

    override func viewWillAppear(_ animated: Bool) {
    
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        createNewAccountButtonAnimation()
        loginButtonAnimation ()
    }
    

     // MARK: Auxiliar

    // Buttons rounded corners
    func showButtons(button: UIButton) {
        button.layer.cornerRadius = 30
        button.clipsToBounds = true
        button.layer.masksToBounds = true
    }
    

    // Create new account button animation
    func createNewAccountButtonAnimation () {
        createNewAccountButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: 3.0,
                       delay: 0,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 6.0,
                       options: .allowUserInteraction,
                       animations: { [weak self] in
                        self?.createNewAccountButton.transform = .identity
        })
    }
    
    // Login button animation
    func loginButtonAnimation () {
        loginButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: 3.0,
                       delay: 0,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 6.0,
                       options: .allowUserInteraction,
                       animations: { [weak self] in
                        self?.loginButton.transform = .identity
        })
    }

}

