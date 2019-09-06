//
//  SplashScreen.swift
//  HurbChallenge
//
//  Created by Nathalia Inacio on 01/09/19.
//  Copyright © 2019 Nathalia Inacio. All rights reserved.
//

import UIKit
//import Firebase

class SplashScreen: UIViewController {
    
    // MARK: - Initialization
    
    // MARK: Outlets
    @IBOutlet weak var splashView: UIView!
    @IBOutlet weak var splashImage: UIImageView!
    
    override func viewDidLoad() {

        
    }
    
    // MARK: View Cicle
    override func viewDidAppear(_ animated: Bool) {
        
        self.animate()
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(SplashScreen.passScreen)), userInfo: nil, repeats: false)
        
        
       // Auth.auth().addStateDidChangeListener { auth, user in
          //  if user != nil {
          //      self.performSegue(withIdentifier: "profile", sender: self)
          //  } else {
           //     self.animate()
           //     Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(SplashScreen.passScreen)), userInfo: nil, repeats: false)
          //  }
        //}
    }
    
    
    // MARK: Auxiliar
    func animate() {
        UIView.animate(withDuration: 1, animations: {
        
        self.splashView.frame.size.height = 434
            self.splashImage.frame.origin.y = 117
        
        
        }, completion: nil)
    }
    
    @objc func passScreen() {
        self.performSegue(withIdentifier: "goToStart", sender: self)
    }
    
    
}
