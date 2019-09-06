//
//  Filter.swift
//  HurbChallenge
//
//  Created by Nathalia Inacio on 06/09/19.
//  Copyright © 2019 Nathalia Inacio. All rights reserved.
//

import UIKit

class Filter: UIViewController{
    
    // MARK: - Variables
    var isMarked: Bool = false

    @IBOutlet weak var valueButton1: UIButton!
    @IBOutlet weak var valueButton2: UIButton!
    @IBOutlet weak var valueButton3: UIButton!
    @IBOutlet weak var valueButton4: UIButton!
    @IBOutlet weak var valueButton5: UIButton!
    
    
    override func viewDidLoad() {
        
        showFilterButton(filterButton: valueButton1)
        showFilterButton(filterButton: valueButton2)
        showFilterButton(filterButton: valueButton3)
        showFilterButton(filterButton: valueButton4)
        showFilterButton(filterButton: valueButton5)

    }
    
    
    // MARK: Auxiliar
    func showFilterButton(filterButton: UIButton) {
        
            filterButton.layer.cornerRadius = 15
            filterButton.clipsToBounds = true
            filterButton.layer.masksToBounds = true
            filterButton.layer.borderWidth = 1
            filterButton.layer.borderColor = UIColor.paletteDarkGray.cgColor
            
            if isMarked == false{
                filterButton.backgroundColor = .clear
            } else{
                filterButton.backgroundColor = UIColor.paletteBlue.withAlphaComponent(0.7)
            }
        }
    
    func showSquareButton(squareButton: UIButton) {
    
            if isMarked == false{
                squareButton.backgroundColor = .clear
            } else{
                squareButton.backgroundColor = UIColor.paletteBlue.withAlphaComponent(0.7)
            }
        }
    
    @objc private func dismiss() {
        self.dismiss(animated: true, completion: nil)
        
    }
    
     // MARK: Actions

    @IBAction func closeButton(_ sender: Any) {
        dismiss()
    }
    
    
    @IBAction func category1Button(_ sender: Any) {
    }
    
    
    @IBAction func category2Button(_ sender: Any) {
    }
    
    
    @IBAction func category3Button(_ sender: Any) {
    }
    
    
    @IBAction func category4Button(_ sender: Any) {
    }
    
    
    @IBAction func category5Button(_ sender: Any) {
    }
    
}
