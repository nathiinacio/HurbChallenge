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
    
    // MARK: - Enum
    enum CardType {
        case package
        case hotel
    }
    
   
    // MARK: Outlets
    
    @IBOutlet weak var view: UIView!
    
    @IBOutlet weak var title: UILabel!
 
    @IBOutlet weak var photo: UIImageView!
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBOutlet weak var maxValue: UILabel!
    @IBOutlet weak var minValue: UILabel!
    
    @IBOutlet weak var definition: UITextView!
    
    @IBOutlet weak var amenity1: UILabel!
    @IBOutlet weak var amenity3: UILabel!
    @IBOutlet weak var amenity2: UILabel!
    
    @IBOutlet weak var category1: UIImageView!
    @IBOutlet weak var category2: UIImageView!
    @IBOutlet weak var category3: NSLayoutConstraint!
    @IBOutlet weak var category4: UIImageView!
    @IBOutlet weak var category5: UIImageView!
    
    
    // MARK: Declared
    
    // MARK: - Variables
    
    //var user: Auth.auth().currentUser? = nil
    var place: Hotel? = nil
    
    var type: CardType = .package
    var isFlagged: Bool = false
    
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
        
        
        // Flag image
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
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photo.image = nil
    }
    
    // MARK: Cell configuration
    
    /**
     It configures the card with the `Hotel`.
     
     Before calling this funcion you have to set the enum and the hotel.
     
     # Example #
     ```
     cell.type = .hotel
     cell.hotel = hotels[indexPath.item]
     
     cell.showHotel()
     ```
     */
    func showHotel() {
        if let hotel = place,
            type == .hotel {

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

            // Description
            definition.text = hotel.results.description

            // Amenities
//            amenity1.text = hotel.filters
//            amenity2.text = hotel.filters.amenities[1]
//            amenity3.text = hotel.filters.amenities[2]
            
            
            // Name
           // title.text = hotel.filters.

            
            //Local
            
            
            
            //Price
            // title.text = hotel.results.
            
//            // Image
//            if let path = user.fields.image?.first?.url {
//                if let url = URL(string: path) {
//                    addImageToView(imageURL: url, imageView: photo)
//                }
//            }
        }
    }
    
    /**
     It configures the card with the `Project`.
     
     Before calling this funcion you have to set the enum and the project.
     
     # Example #
     ```
     cell.type = .project
     cell.project = projects[indexPath.item]
     
     cell.showInfoProject()
     ```
     */
    
    
//    func showPackage() {
//}
    
    // MARK: Auxiliar
    
    func addImageToView(imageURL: URL, imageView: UIImageView) {

    }
    
    // MARK: - Actions

    @IBAction func saveButton(_ sender: Any) {
        
            isFlagged = !isFlagged
            
            switch type {
            case .package:
                switch isFlagged {
                case true:
                    //coloca nos fav
                   favoriteButton.isSelected = true
                case false:
                    //tira dos fav
                    favoriteButton.isSelected = false
                }
                
            case .hotel:
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

}
