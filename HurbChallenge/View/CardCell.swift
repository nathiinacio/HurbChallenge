//
//  CardCell.swift
//  HurbChallenge
//
//  Created by Nathalia Inacio on 05/09/19.
//  Copyright © 2019 Nathalia Inacio. All rights reserved.
//

import Foundation
import UIKit
//import Firebase


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
    
    //var user: Auth.auth().currentUser? = nil
    var place: Hotel? = nil
    var allHotels: [Hotel] = []
    var allPackages: [Hotel] = []

    var isFlagged: Bool = false
    
    var starsCount = 0
    
    // MARK: - Methods
    
    // MARK: View content
    
    override func layoutSubviews() {
        //Shadows
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.23
        view.layer.shadowRadius = 4
        view.layer.cornerRadius = 12
        
        //Rounded Image
        photo.layer.cornerRadius = photo.frame.height/2
        photo.clipsToBounds = true

        
        // Favorite image
        let imageSelected = UIImage(named: "favoriteSelected")
        favoriteButton.setImage(imageSelected, for: .selected)

        let imageNormal = UIImage(named: "favoriteNotSelected")
        favoriteButton.setImage(imageNormal, for: .normal)
        
        // Disenable all iteractions
        for item in view.subviews {
            item.isUserInteractionEnabled = false
        }
        
        // Enable flag and view iteractions
        favoriteButton.isUserInteractionEnabled = true
        view.isUserInteractionEnabled = true
        
        //Ameneties rounded corners
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photo.image = nil
    }
    
    // MARK: Cell population
    
    func populateHotel(from result:Result) {
        
        
            if result.isHotel == true {
      
                // Description
                definition.text = result.smallDescription
                
                // Amenities
                
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
     
                
                // Name
                 title.text = result.name
                
                //Local
                
                cityLabel.text = result.address.city
                stateLabel.text = "| " + result.address.state + " |"
            
                //Price
                 let price = result.price.amountPerDay
                 let stringValue = "\(price)"
                priceMoney.text = "BRL " + stringValue

                //Category
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
                
            // Image
                addImageToView(from: result.url, imageView: photo)

            }
    }
    
    func populatePackage(from result:Result) {
        
    
        if result.isPackage == true {
        
            
            
            // Description
            definition.text = result.smallDescription
            
            // Atributes
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
            
            // Name
            title.text = result.name
        
            //Local
            cityLabel.text = result.address.city
            stateLabel.text = "| " + result.address.state + " |"
        
            //Price
            let price = result.price.amountPerDay
            let stringValue = "\(price)"
            priceMoney.text = "BRL " + stringValue
            
            //Category
            category1.alpha = 0
            category2.alpha = 0
            category3.alpha = 0
            category4.alpha = 0
            category5.alpha = 0
            
            //Image
            addImageToView(from: result.url, imageView: photo)
            
        }
        
        //            // Checking if the flag is selected or not
        //            if let favorites = MyUser.instance.fields.favoritesUsers,
        //                favorites.contains(where: { u in if u.id == user.id { return true } else { return false } }) {
        //                flagButton.imageView?.image = UIImage(named: "SaveFlagSelected")
        //                isFlagged = true
        //                flagButton.isSelected = true
        //            } else {
        //                flagButton.imageView?.image = UIImage(named: "SaveFlag")
        //                isFlagged = false
        //                flagButton.isSelected = false
        //            }
        
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
        }

    }
    
    // MARK: - Actions

    @IBAction func saveButton(_ sender: Any) {
        
            isFlagged = !isFlagged
        
            switch isFlagged {
                case true:
                    //coloca nos fav
                   favoriteButton.isSelected = true
                case false:
                    //tira dos fav
                    favoriteButton.isSelected = false
                }

        }
    

}
