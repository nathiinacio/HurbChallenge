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
    var isHotelFilter: Bool = true

    var category1isSelected: Bool = false
    var category2isSelected: Bool = false
    var category3isSelected: Bool = false
    var category4isSelected: Bool = false
    var category5isSelected: Bool = false
    
    var value1isSelected: Bool = false
    var value2isSelected: Bool = false
    var value3isSelected: Bool = false
    var value4isSelected: Bool = false
    var value5isSelected: Bool = false

    var amenity1isSelected: Bool = false
    var amenity2isSelected: Bool = false
    var amenity3isSelected: Bool = false
    var amenity4isSelected: Bool = false
    var amenity5isSelected: Bool = false
    
    @IBOutlet weak var search: UIButton!
    
    // MARK: - Outlets
    @IBOutlet weak var viewCategoryEnable: UIView!
    
    @IBOutlet weak var labelCategoryEnable: UILabel!
    
    @IBOutlet weak var categoryButton1: UIButton!
    @IBOutlet weak var categoryButton2: UIButton!
    @IBOutlet weak var categoryButton3: UIButton!
    @IBOutlet weak var categoryButton4: UIButton!
    @IBOutlet weak var categoryButton5: UIButton!
    
    @IBOutlet weak var valueButton1: UIButton!
    @IBOutlet weak var valueButton2: UIButton!
    @IBOutlet weak var valueButton3: UIButton!
    @IBOutlet weak var valueButton4: UIButton!
    @IBOutlet weak var valueButton5: UIButton!
    
    @IBOutlet weak var amenityButton1: UIButton!
    @IBOutlet weak var amenityButton2: UIButton!
    @IBOutlet weak var amenityButton3: UIButton!
    @IBOutlet weak var amenityButton4: UIButton!
    @IBOutlet weak var amenityButton5: UIButton!
    
    override func viewDidLoad() {
        
        showFilterButton(filterButton: valueButton1)
        showFilterButton(filterButton: valueButton2)
        showFilterButton(filterButton: valueButton3)
        showFilterButton(filterButton: valueButton4)
        showFilterButton(filterButton: valueButton5)
        showFilterButton(filterButton: amenityButton1)
        showFilterButton(filterButton: amenityButton2)
        showFilterButton(filterButton: amenityButton3)
        showFilterButton(filterButton: amenityButton4)
        showFilterButton(filterButton: amenityButton5)
        checkSearchButtonStatus()
        showCategoryButtons(currentSegment: isHotelFilter)
    }
    
    
    // MARK: Auxiliar
    
    
    
    func showCategoryButtons(currentSegment: Bool){
        
        if isHotelFilter == true{
            viewCategoryEnable.alpha = 0
            labelCategoryEnable.alpha = 0
            categoryButton1.isEnabled = true
            categoryButton2.isEnabled = true
            categoryButton3.isEnabled = true
            categoryButton4.isEnabled = true
            categoryButton5.isEnabled = true
        }else{
            viewCategoryEnable.alpha = 0.8
            labelCategoryEnable.alpha = 1
            categoryButton1.isEnabled = false
            categoryButton2.isEnabled = false
            categoryButton3.isEnabled = false
            categoryButton4.isEnabled = false
            categoryButton5.isEnabled = false
        }
        
    }
    
    func showFilterButton(filterButton: UIButton) {
        
            filterButton.layer.cornerRadius = 15
            filterButton.clipsToBounds = true
            filterButton.layer.masksToBounds = true
            filterButton.layer.borderWidth = 1
            filterButton.layer.borderColor = UIColor.paletteDarkGray.cgColor
            filterButton.backgroundColor = .clear
        }
    
    
    func checkSearchButtonStatus() {
        if category1isSelected == true || category2isSelected == true || category3isSelected == true || category4isSelected == true || category5isSelected == true || value1isSelected == true || value2isSelected == true || value3isSelected == true || value4isSelected == true || value5isSelected == true || amenity1isSelected == true || amenity2isSelected == true || amenity3isSelected == true || amenity4isSelected == true || amenity5isSelected == true{
            
            search.isEnabled = true
            search.alpha = 1
            
        }else{
            search.isEnabled = false
            search.alpha = 0.5
            
        }
   
    }
    
    @objc private func dismiss() {
        self.dismiss(animated: true, completion: nil)
        
    }
    
     // MARK: Actions

    @IBAction func closeButton(_ sender: Any) {
        dismiss()
    }
    
    
    
    @IBAction func category1Taped(_ sender: Any) {
        
        if category1isSelected == false{
            category1isSelected = true
        }else{
             category1isSelected = false
        }
        
        if category1isSelected == false{
            categoryButton1.backgroundColor = .clear
        } else{
            categoryButton1.backgroundColor = UIColor.paletteBlue.withAlphaComponent(0.7)
        }
        checkSearchButtonStatus()
    }
    
    @IBAction func category2Taped(_ sender: Any) {
        
        if category2isSelected == false{
            category2isSelected = true
        }else{
            category2isSelected = false
        }
        
        if category2isSelected == false{
            categoryButton2.backgroundColor = .clear
        } else{
            categoryButton2.backgroundColor = UIColor.paletteBlue.withAlphaComponent(0.7)
        }
        checkSearchButtonStatus()
    }

    @IBAction func category3Taped(_ sender: Any) {
        
        
        if category3isSelected == false{
            category3isSelected = true
        }else{
            category3isSelected = false
        }
        
        if category3isSelected == false{
            categoryButton3.backgroundColor = .clear
        } else{
            categoryButton3.backgroundColor = UIColor.paletteBlue.withAlphaComponent(0.7)
        }
        checkSearchButtonStatus()
        
    }
 
    @IBAction func category4Taped(_ sender: Any) {
        
        if category4isSelected == false{
            category4isSelected = true
        }else{
            category4isSelected = false
        }
        
        if category4isSelected == false{
            categoryButton4.backgroundColor = .clear
        } else{
            categoryButton4.backgroundColor = UIColor.paletteBlue.withAlphaComponent(0.7)
        }
        checkSearchButtonStatus()
    }
    
    @IBAction func category5Taped(_ sender: Any) {
        
        if category5isSelected == false{
            category5isSelected = true
        }else{
            category5isSelected = false
        }
        
        if category5isSelected == false{
            categoryButton5.backgroundColor = .clear
        } else{
            categoryButton5.backgroundColor = UIColor.paletteBlue.withAlphaComponent(0.7)
        }
        checkSearchButtonStatus()
    }
    
    
    @IBAction func value1Taped(_ sender: Any) {
   
        if value1isSelected == false{
            value1isSelected = true
        }else{
            value1isSelected = false
        }
        
        if value1isSelected == false{
            valueButton1.backgroundColor = .clear
        } else{
            valueButton1.backgroundColor = UIColor.paletteBlue.withAlphaComponent(0.7)
        }
        checkSearchButtonStatus()
    }
    
    @IBAction func value2Taped(_ sender: Any) {
        
        if value2isSelected == false{
            value2isSelected = true
        }else{
            value2isSelected = false
        }
        
        if value2isSelected == false{
            valueButton2.backgroundColor = .clear
        } else{
            valueButton2.backgroundColor = UIColor.paletteBlue.withAlphaComponent(0.7)
        }
        checkSearchButtonStatus()
    }
    
    @IBAction func value3Taped(_ sender: Any) {
        
        if value3isSelected == false{
            value3isSelected = true
        }else{
            value3isSelected = false
        }
        
        if value3isSelected == false{
            valueButton3.backgroundColor = .clear
        } else{
            valueButton3.backgroundColor = UIColor.paletteBlue.withAlphaComponent(0.7)
        }
        checkSearchButtonStatus()
    }
    
    @IBAction func value4Taped(_ sender: Any) {
        
        if value4isSelected == false{
            value4isSelected = true
        }else{
            value4isSelected = false
        }
        
        if value4isSelected == false{
            valueButton4.backgroundColor = .clear
        } else{
            valueButton4.backgroundColor = UIColor.paletteBlue.withAlphaComponent(0.7)
        }
        checkSearchButtonStatus()
    }
    
    @IBAction func value5Taped(_ sender: Any) {
        
        if value5isSelected == false{
            value5isSelected = true
        }else{
            value5isSelected = false
        }
        
        if value5isSelected == false{
            valueButton5.backgroundColor = .clear
        } else{
            valueButton5.backgroundColor = UIColor.paletteBlue.withAlphaComponent(0.7)
        }
        checkSearchButtonStatus()
    }

    @IBAction func amenity1Taped(_ sender: Any) {
        
        if amenity1isSelected == false{
            amenity1isSelected = true
        }else{
            amenity1isSelected = false
        }
        
        if amenity1isSelected == false{
            amenityButton1.backgroundColor = .clear
        } else{
            amenityButton1.backgroundColor = UIColor.paletteBlue.withAlphaComponent(0.7)
        }
        checkSearchButtonStatus()
    }
    
    @IBAction func amenity2Taped(_ sender: Any) {
        
        if amenity2isSelected == false{
            amenity2isSelected = true
        }else{
            amenity2isSelected = false
        }
        
        if amenity2isSelected == false{
            amenityButton2.backgroundColor = .clear
        } else{
            amenityButton2.backgroundColor = UIColor.paletteBlue.withAlphaComponent(0.7)
        }
        checkSearchButtonStatus()
    }
    
    @IBAction func amenity3Taped(_ sender: Any) {
        
        if amenity3isSelected == false{
            amenity3isSelected = true
        }else{
            amenity3isSelected = false
        }
        
        if amenity3isSelected == false{
            amenityButton3.backgroundColor = .clear
        } else{
            amenityButton3.backgroundColor = UIColor.paletteBlue.withAlphaComponent(0.7)
        }
        checkSearchButtonStatus()
    }
    
    @IBAction func amenity4Taped(_ sender: Any) {
        
        if amenity4isSelected == false{
            amenity4isSelected = true
        }else{
            amenity4isSelected = false
        }
        
        if amenity4isSelected == false{
            amenityButton4.backgroundColor = .clear
        } else{
            amenityButton4.backgroundColor = UIColor.paletteBlue.withAlphaComponent(0.7)
        }
        checkSearchButtonStatus()
    }
    
    @IBAction func amenity5Taped(_ sender: Any) {
        
        if amenity5isSelected == false{
            amenity5isSelected = true
        }else{
            amenity5isSelected = false
        }
        
        if amenity5isSelected == false{
            amenityButton5.backgroundColor = .clear
        } else{
            amenityButton5.backgroundColor = UIColor.paletteBlue.withAlphaComponent(0.7)
        }
        checkSearchButtonStatus()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "feedScreen" {
            debugPrint("go to Filter")
            if let destinationVC = segue.destination as? Feed {
                destinationVC.isFiltering = true
            }
        }
    }
    
    
    @IBAction func searchButton(_ sender: Any) {
        
         self.performSegue(withIdentifier: "feedScreen", sender: nil)
        
    }
    
    
}
