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
    
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var price: UILabel!
    
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
    
    func populateHotel(index:Int) {
        
            let hotel = place
   
            let currentHotel = hotel?.results[index]
        
            if currentHotel?.isHotel == true {
                
                allHotels.append(hotel!)
            
                // Description
                definition.text = currentHotel?.smallDescription
                
                // Amenities
                
                isAmenityOrAtribute.text = "Amenidades"
                amenity1.text = currentHotel?.amenities[0].name
                amenity2.text = currentHotel?.amenities[1].name
                amenity3.text = currentHotel?.amenities[2].name
                
                
                // Name
                 title.text = currentHotel?.name
                
                //Local
                
                placeLabel.text = currentHotel?.address.city
            
                //Price
                 price.text = currentHotel?.price.currency
    
                //Category
                
                if currentHotel?.category == "5 estrelas"{
                    category1.alpha = 1
                    category2.alpha = 1
                    category3.alpha = 1
                    category4.alpha = 1
                    category5.alpha = 1
                }else if currentHotel?.category == "4 estrelas"{
                    category1.alpha = 1
                    category2.alpha = 1
                    category3.alpha = 1
                    category4.alpha = 1
                    category5.alpha = 0
                }else if currentHotel?.category == "3 estrelas"{
                    category1.alpha = 1
                    category2.alpha = 1
                    category3.alpha = 1
                    category4.alpha = 0
                    category5.alpha = 0
                }else if currentHotel?.category == "2 estrelas"{
                    category1.alpha = 1
                    category2.alpha = 1
                    category3.alpha = 0
                    category4.alpha = 0
                    category5.alpha = 0
                }else if currentHotel?.category == "1 estrela"{
                    category1.alpha = 1
                    category2.alpha = 0
                    category3.alpha = 0
                    category4.alpha = 0
                    category5.alpha = 0
                }else{
                    category1.alpha = 0
                    category2.alpha = 0
                    category3.alpha = 0
                    category4.alpha = 0
                    category5.alpha = 0
                }
                
//            // Image
//            if let path = user.fields.image?.first?.url {
//                if let url = URL(string: path) {
//                    addImageToView(imageURL: url, imageView: photo)
//                }
//            }

            }
    }
    
    func populatePackage(index:Int) {
        
        let hotel = place
        
        let currentHotel = hotel?.results[index]
        
        if currentHotel?.isPackage == true {
        
            allPackages.append(hotel!)
            
            // Description
            definition.text = currentHotel?.smallDescription
            
            // Atributes
            isAmenityOrAtribute.text = "Atributos"
            amenity1.text = currentHotel?.amenities[0].name
            amenity2.text = currentHotel?.amenities[1].name
            amenity3.text = currentHotel?.amenities[2].name
            
            
            // Name
            title.text = currentHotel?.name
            
            //Local
            
            placeLabel.text = currentHotel?.address.city
            
            //Price
            price.text = currentHotel?.price.currency
            
            //Category
            category1.alpha = 0
            category2.alpha = 0
            category3.alpha = 0
            category4.alpha = 0
            category5.alpha = 0
            
            //            // Image
            //            if let path = user.fields.image?.first?.url {
            //                if let url = URL(string: path) {
            //                    addImageToView(imageURL: url, imageView: photo)
            //                }
            //            }
            
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
    
    func addImageToView(imageURL: URL, imageView: UIImageView) {

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
