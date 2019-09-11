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
    var categories:[Int] = []
    
    // MARK: - Outlets
    @IBOutlet weak var search: UIButton!
    @IBOutlet weak var viewCategoryEnable: UIView!
    @IBOutlet weak var labelCategoryEnable: UILabel!
    @IBOutlet weak var categoryButton1: UIButton!
    @IBOutlet weak var categoryButton2: UIButton!
    @IBOutlet weak var categoryButton3: UIButton!
    @IBOutlet weak var categoryButton4: UIButton!
    @IBOutlet weak var categoryButton5: UIButton!
    
    
    
    override func viewDidLoad() {
        
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
    
    func checkSearchButtonStatus() {
        if category1isSelected == true || category2isSelected == true || category3isSelected == true || category4isSelected == true || category5isSelected == true {
            
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
        
        category1isSelected.toggle()
        let number = 1
        
        if !category1isSelected {
            categoryButton1.backgroundColor = .clear
            categories.append(number)
        } else{
            categoryButton1.backgroundColor = UIColor.paletteBlue.withAlphaComponent(0.7)
            if let index = categories.firstIndex(of: number) {
                categories.remove(at: index)
            }
    }
       checkSearchButtonStatus()
}
    
    @IBAction func category2Taped(_ sender: Any) {
        
        category2isSelected.toggle()
        let number = 2
        
        if !category2isSelected {
            categoryButton2.backgroundColor = .clear
            categories.append(number)
        } else{
            categoryButton2.backgroundColor = UIColor.paletteBlue.withAlphaComponent(0.7)
            if let index = categories.firstIndex(of: number) {
                categories.remove(at: index)
            }
        }
        checkSearchButtonStatus()

    }

    @IBAction func category3Taped(_ sender: Any) {

        category3isSelected.toggle()
        let number = 3
        
        if !category3isSelected {
            categoryButton3.backgroundColor = .clear
            categories.append(number)
        } else{
            categoryButton3.backgroundColor = UIColor.paletteBlue.withAlphaComponent(0.7)
            if let index = categories.firstIndex(of: number) {
                categories.remove(at: index)
            }
        }
        checkSearchButtonStatus()

        
    }
 
    @IBAction func category4Taped(_ sender: Any) {
        
        category4isSelected.toggle()
        let number = 4
        
        if !category4isSelected {
            categoryButton4.backgroundColor = .clear
            categories.append(number)
        } else{
            categoryButton4.backgroundColor = UIColor.paletteBlue.withAlphaComponent(0.7)
            if let index = categories.firstIndex(of: number) {
                categories.remove(at: index)
            }
        }
        checkSearchButtonStatus()

    }
    
    @IBAction func category5Taped(_ sender: Any) {
        
        category5isSelected.toggle()
        let number = 5
        
        if !category5isSelected {
            categoryButton5.backgroundColor = .clear
            categories.append(number)
        } else{
            categoryButton5.backgroundColor = UIColor.paletteBlue.withAlphaComponent(0.7)
            if let index = categories.firstIndex(of: number) {
                categories.remove(at: index)
            }
        }
        checkSearchButtonStatus()

    }
    
    

    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "feedScreen" {
//            debugPrint("go to Filter")
//            if let destinationVC = segue.destination as? Feed {
//                destinationVC.categoriesToFilter = categories
//                destinationVC.filterByCategory.toggle()
//            }
//        }
//    }
    
    
    @IBAction func searchButton(_ sender: Any) {
//        self.performSegue(withIdentifier: "feedScreen", sender: self) ///Not repopulating the feed correctly
         dismiss()
        
    }
    
    
}
