//
//  CardCell.swift
//  HurbChallenge
//
//  Created by Nathalia Inacio on 05/09/19.
//  Copyright © 2019 Nathalia Inacio. All rights reserved.
//

import Foundation
import UIKit
import Firebase


class CardCell: UICollectionViewCell {
    
    
    // MARK: Outlets
    @IBOutlet weak var view: UIView!
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var photo: UIImageView!
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var priceMoney: UILabel!
    
    @IBOutlet weak var definition: UITextView!
    
    @IBOutlet weak var isAmenityOrAtribute: UILabel!
    @IBOutlet weak var amenity1: UILabel!
    @IBOutlet weak var amenity3: UILabel!
    @IBOutlet weak var amenity2: UILabel!
    
    @IBOutlet weak var category1: UIImageView!
    @IBOutlet weak var category2: UIImageView!
    @IBOutlet weak var category3: UIImageView!
    @IBOutlet weak var category4: UIImageView!
    @IBOutlet weak var category5: UIImageView!
    
    
    // MARK: Declared
    
    // MARK: - Variables
    
    var isFlagged: Bool = false
    var starsCount = 0
    var id = ""
    var isHotel = true
    
    
    // MARK: - Methods
    
    // MARK: View content
    
    override func layoutSubviews() {
        
        ///Shadows
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.23
        view.layer.shadowRadius = 4
        view.layer.cornerRadius = 12
        
        ///Rounded Image
        photo.layer.cornerRadius = photo.frame.height/2
        photo.clipsToBounds = true
        
        
        /// Favorite image
        let imageSelected = UIImage(named: "favoriteSelected")
        favoriteButton.setImage(imageSelected, for: .selected)
        
        let imageNormal = UIImage(named: "favoriteNotSelected")
        favoriteButton.setImage(imageNormal, for: .normal)
        
        /// Disenable all iteractions
        for item in view.subviews {
            item.isUserInteractionEnabled = false
        }
        
        /// Enable flag and view iteractions
        favoriteButton.isUserInteractionEnabled = true
        view.isUserInteractionEnabled = true
        
        ///Ameneties rounded corners
        amenity1.layer.cornerRadius = 10
        amenity1.clipsToBounds = true
        amenity1.layer.masksToBounds = true
        
        amenity2.layer.cornerRadius = 10
        amenity2.clipsToBounds = true
        amenity2.layer.masksToBounds = true
        
        amenity3.layer.cornerRadius = 10
        amenity3.clipsToBounds = true
        amenity3.layer.masksToBounds = true
        
    }
    
    // MARK: Cell Population
    
    func populate(from result: Result, for dataType: DataType) {
        switch dataType {
        case .hotel:
            populateHotel(from: result)
        case .package:
            populatePackage(from: result)
        }
    }
    
    private func populateHotel(from result:Result) {
        
        if result.isHotel == true {
            
            ///ID
            id = result.id
            isHotel = true
            
            /// Description
            definition.text = result.smallDescription
            
            /// Amenities
            isAmenityOrAtribute.text = "Amenidades:"
            if result.amenities.count >= 3{
                amenity1.text = result.amenities[0].name
                amenity2.text = result.amenities[1].name
                amenity3.text = result.amenities[2].name
                
            } else if result.amenities.count == 2{
                //amenity1.text = result.amenities[0].name
                amenity2.text = result.amenities[0].name
                amenity3.text = result.amenities[1].name
            } else if result.amenities.count == 1{
                //amenity1.text = result.amenities[0].name
                amenity2.text = result.amenities[0].name
                //amenity3.text = result.amenities[2].name
            }
            
            
            ///Name
            title.text = result.name
            
            ///Local
            cityLabel.text = result.address.city
            stateLabel.text = "| " + result.address.state + " |"
            
            ///Price
            let price = result.price.amountPerDay
            let stringValue = "\(price)"
            priceMoney.text = "BRL " + stringValue
            
            ///Category
            if result.stars == 5 {
                self.category1.alpha = 1
                self.category2.alpha = 1
                self.category3.alpha = 1
                self.category4.alpha = 1
                self.category5.alpha = 1
            }else if result.stars == 4 {
                self.category1.alpha = 1
                self.category2.alpha = 1
                self.category3.alpha = 1
                self.category4.alpha = 1
                self.category5.alpha = 0
            }else if result.stars == 3 {
                self.category1.alpha = 1
                self.category2.alpha = 1
                self.category3.alpha = 1
                self.category4.alpha = 0
                self.category5.alpha = 0
            }else if result.stars == 2 {
                self.category1.alpha = 1
                self.category2.alpha = 1
                self.category3.alpha = 0
                self.category4.alpha = 0
                self.category5.alpha = 0
            }else if result.stars == 1 {
                self.category1.alpha = 1
                self.category2.alpha = 0
                self.category3.alpha = 0
                self.category4.alpha = 0
                self.category5.alpha = 0
            }else{
                self.category1.alpha = 0
                self.category2.alpha = 0
                self.category3.alpha = 0
                self.category4.alpha = 0
                self.category5.alpha = 0
            }
            
            /// Image
            addImageToView(from: result.gallery[0].url, imageView: photo)
            
            
            /// Checking if the flag is selected or not
            let array = UserManager.instance.favoritesHotels
            let indexOf = find(value: id, in: array)
            if indexOf != nil {
                self.favoriteButton.imageView?.image = UIImage(named: "favoriteSelected")
                self.isFlagged = true
                self.favoriteButton.isSelected = true
            }else{
                self.favoriteButton.imageView?.image = UIImage(named: "favoriteNotSelected")
                self.isFlagged = false
                self.favoriteButton.isSelected = false
            }
        }
        
    }
    
    func populatePackage(from result:Result) {
        
        if result.isPackage == true {
            
            /// ID
            id = result.id
            isHotel = false
            
            /// Description
            definition.text = result.smallDescription
            
            /// Atributes
            isAmenityOrAtribute.text = "Atributos:"
            if result.amenities.count >= 3{
                amenity1.text = result.amenities[0].name
                amenity2.text = result.amenities[1].name
                amenity3.text = result.amenities[2].name
                
            } else if result.amenities.count == 2{
                //amenity1.text = result.amenities[0].name
                amenity2.text = result.amenities[0].name
                amenity3.text = result.amenities[1].name
            } else if result.amenities.count == 1{
                //amenity1.text = result.amenities[0].name
                amenity2.text = result.amenities[0].name
                //amenity3.text = result.amenities[2].name
            }
            
            /// Name
            title.text = result.name
            
            /// Local
            cityLabel.text = result.address.city
            stateLabel.text = "| " + result.address.state + " |"
            
            /// Price
            let price = result.price.amountPerDay
            let stringValue = "\(price)"
            priceMoney.text = "BRL " + stringValue
            
            /// Category
            category1.alpha = 0
            category2.alpha = 0
            category3.alpha = 0
            category4.alpha = 0
            category5.alpha = 0
            
            /// Image
            addImageToView(from: result.gallery[0].url, imageView: photo)
            
            /// Checking if the flag is selected or not
            let array = UserManager.instance.favoritesHotels
            let indexOf = find(value: id, in: array)
            if indexOf != nil {
                self.favoriteButton.imageView?.image = UIImage(named: "favoriteSelected")
                self.isFlagged = true
                self.favoriteButton.isSelected = true
            }else{
                self.favoriteButton.imageView?.image = UIImage(named: "favoriteNotSelected")
                self.isFlagged = false
                self.favoriteButton.isSelected = false
            }
        }
    }
    
    
    func populateFavoritesPackages(from result:Result) {
        
        id = result.id
        
        let array = UserManager.instance.favoritesPackages
        let indexOf = find(value: id, in: array)
        
        if result.isPackage == true &&  indexOf != nil {
            
            /// ID
            id = result.id
            isHotel = false
            
            /// Description
            definition.text = result.smallDescription
            
            /// Atributes
            isAmenityOrAtribute.text = "Atributos:"
            if result.amenities.count >= 3{
                amenity1.text = result.amenities[0].name
                amenity2.text = result.amenities[1].name
                amenity3.text = result.amenities[2].name
                
            } else if result.amenities.count == 2{
                //amenity1.text = result.amenities[0].name
                amenity2.text = result.amenities[0].name
                amenity3.text = result.amenities[1].name
            } else if result.amenities.count == 1{
                //amenity1.text = result.amenities[0].name
                amenity2.text = result.amenities[0].name
                //amenity3.text = result.amenities[2].name
            }
            
            /// Name
            title.text = result.name
            
            /// Local
            cityLabel.text = result.address.city
            stateLabel.text = "| " + result.address.state + " |"
            
            /// Price
            let price = result.price.amountPerDay
            let stringValue = "\(price)"
            priceMoney.text = "BRL " + stringValue
            
            /// Category
            category1.alpha = 0
            category2.alpha = 0
            category3.alpha = 0
            category4.alpha = 0
            category5.alpha = 0
            
            /// Image
            addImageToView(from: result.gallery[0].url, imageView: photo)
            
            /// Checking if the flag is selected or not
            let array = UserManager.instance.favoritesHotels
            let indexOf = find(value: id, in: array)
            if indexOf != nil {
                self.favoriteButton.imageView?.image = UIImage(named: "favoriteSelected")
                self.isFlagged = true
                self.favoriteButton.isSelected = true
            }else{
                self.favoriteButton.imageView?.image = UIImage(named: "favoriteNotSelected")
                self.isFlagged = false
                self.favoriteButton.isSelected = false
            }
        }
        
    }
    
    
    func populateFavoritesHotels(from result:Result) {
        
        id = result.id
        
        let array = UserManager.instance.favoritesHotels
        let indexOf = find(value: id, in: array)
        
        if result.isHotel == true &&  indexOf != nil {
            
            ///ID
            id = result.id
            isHotel = true
            
            /// Description
            definition.text = result.smallDescription
            
            /// Amenities
            isAmenityOrAtribute.text = "Amenidades:"
            if result.amenities.count >= 3{
                amenity1.text = result.amenities[0].name
                amenity2.text = result.amenities[1].name
                amenity3.text = result.amenities[2].name
                
            } else if result.amenities.count == 2{
                //amenity1.text = result.amenities[0].name
                amenity2.text = result.amenities[0].name
                amenity3.text = result.amenities[1].name
            } else if result.amenities.count == 1{
                //amenity1.text = result.amenities[0].name
                amenity2.text = result.amenities[0].name
                //amenity3.text = result.amenities[2].name
            }
            
            
            ///Name
            title.text = result.name
            
            ///Local
            cityLabel.text = result.address.city
            stateLabel.text = "| " + result.address.state + " |"
            
            ///Price
            let price = result.price.amountPerDay
            let stringValue = "\(price)"
            priceMoney.text = "BRL " + stringValue
            
            ///Category
            if result.stars == 5 {
                self.category1.alpha = 1
                self.category2.alpha = 1
                self.category3.alpha = 1
                self.category4.alpha = 1
                self.category5.alpha = 1
            }else if result.stars == 4 {
                self.category1.alpha = 1
                self.category2.alpha = 1
                self.category3.alpha = 1
                self.category4.alpha = 1
                self.category5.alpha = 0
            }else if result.stars == 3 {
                self.category1.alpha = 1
                self.category2.alpha = 1
                self.category3.alpha = 1
                self.category4.alpha = 0
                self.category5.alpha = 0
            }else if result.stars == 2 {
                self.category1.alpha = 1
                self.category2.alpha = 1
                self.category3.alpha = 0
                self.category4.alpha = 0
                self.category5.alpha = 0
            }else if result.stars == 1 {
                self.category1.alpha = 1
                self.category2.alpha = 0
                self.category3.alpha = 0
                self.category4.alpha = 0
                self.category5.alpha = 0
            }else{
                self.category1.alpha = 0
                self.category2.alpha = 0
                self.category3.alpha = 0
                self.category4.alpha = 0
                self.category5.alpha = 0
            }
            
            /// Image
            addImageToView(from: result.gallery[0].url, imageView: photo)
            
            /// Checking if the flag is selected or not
            let array = UserManager.instance.favoritesHotels
            let indexOf = find(value: id, in: array)
            if indexOf != nil {
                self.favoriteButton.imageView?.image = UIImage(named: "favoriteSelected")
                self.isFlagged = true
                self.favoriteButton.isSelected = true
            }else{
                self.favoriteButton.imageView?.image = UIImage(named: "favoriteNotSelected")
                self.isFlagged = false
                self.favoriteButton.isSelected = false
            }
        }
        
    }
    
    func populateFavorites(from result: Result, for dataType: DataType) {
        switch dataType {
        case .hotel:
            populateFavoritesHotels(from: result)
        case .package:
            populateFavoritesPackages(from: result)
        
        }
        
    }
    
    
    
    // MARK: Auxiliar
    func addImageToView(from imageURL: String, imageView: UIImageView) {
        
        DispatchQueue.main.async {
            guard let url = URL(string: imageURL) else {
                debugPrint("error in image url", #function)
                return
            }
            guard let data = try? Data(contentsOf: url) else {
                debugPrint("error getting data", #function, url)
                return
            }
            guard let img = UIImage(data: data) else {
                debugPrint("error in uiimage", #function)
                return
            }
            
            imageView.image = img
            imageView.contentMode = .scaleAspectFill
        }
        
    }
    
    
    func find(value searchValue: String, in array: [String]) -> Int?
    {
        for (index, value) in array.enumerated()
        {
            if value == searchValue {
                return index
            }
        }
        
        return nil
    }
    
    
    // MARK: - Actions
    @IBAction func saveButton(_ sender: Any) {
        
        isFlagged.toggle()
        favoriteButton.isSelected = isFlagged
        
        switch isFlagged {
        case true:
            if isHotel {
                UserManager.instance.favoritesHotels.append(id)
            }else{
                UserManager.instance.favoritesPackages.append(id)
            }
            
        case false:
            if isHotel {
                if let index = UserManager.instance.favoritesHotels.firstIndex(of: id) {
                    UserManager.instance.favoritesHotels.remove(at: index)
                }
            }else{
                if let index = UserManager.instance.favoritesPackages.firstIndex(of: id) {
                    UserManager.instance.favoritesPackages.remove(at: index)
                }
                
            }
            
        }

    }
}

