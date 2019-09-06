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
//    func showHotel() {
//        if let hotel = place,
//            type == .hotel {
//
//            // Icon of Workplace
//            let imageIcon = UIImage(named: "WorkplaceIcon")
//            changedIcon.image = imageIcon
//
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
//
//            // Description
//            definition.text = user.fields.fieldsDescription ?? ""
//
//            // Type
//            identifier.text = user.fields.type?.fields.name ?? ""
//
//            // Occupation
//            informationLabel.text = "\(user.fields.occupation ?? "")"
//
//            // Lab
//            if let placeLabelText = user.fields.lab.first?.fields.name {
//                placeLabel.text = placeLabelText
//
//                switch placeLabelText {
//                case "Apple Developer Academy":
//                    placeLabel.textColor = .darkYellow
//                case "Globolab":
//                    placeLabel.textColor = .darkPink
//                case "Insurtech":
//                    placeLabel.textColor = .darkBlue
//                default:
//                    break
//                }
//            }
//
//            // Tags
//            if let tags = user.fields.tags {
//                switch tags.count {
//                case 0:
//                    tag1.isHidden = true
//                    tag2.isHidden = true
//                    tag3.isHidden = true
//                case 1:
//                    tag1.text = tags[0].fields.name
//                    tag2.isHidden = true
//                    tag3.isHidden = true
//                case 2:
//                    tag1.text = tags[0].fields.name
//                    tag2.text = tags[1].fields.name
//                    tag3.isHidden = true
//                case 3:
//                    tag1.text = tags[0].fields.name
//                    tag2.text = tags[1].fields.name
//                    tag3.text = tags[2].fields.name
//                default:
//                    tag1.text = tags[0].fields.name
//                    tag2.text = tags[1].fields.name
//                    tag3.text = tags[2].fields.name
//                }
//            } else {
//                tag1.isHidden = true
//                tag2.isHidden = true
//                tag3.isHidden = true
//            }
//
//            // Name
//            title.text = user.fields.name
//
//            // Image
//            if let path = user.fields.image?.first?.url {
//                if let url = URL(string: path) {
//                    addImageToView(imageURL: url, imageView: photo)
//                }
//            }
//        }
//    }
    
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
//        if let package = place,
//            type == .package {
//
//            // Icon of Profile
//            let imageIcon = UIImage(named: "ProfileIcon")
//            changedIcon.image = imageIcon
//
//            // Checking if the flag is selected or not
//            if let favorites = MyUser.instance.fields.favoriteProjects,
//                favorites.contains(where:
//                    { u in if u.id == project.id { return true } else { return false } }) {
//                flagButton.imageView?.image = UIImage(named: "SaveFlagSelected")
//                isFlagged = true
//                flagButton.isSelected = true
//            } else {
//                flagButton.imageView?.image = UIImage(named: "SaveFlag")
//                isFlagged = false
//                flagButton.isSelected = false
//            }
//
//            // Description
//            definition.text = project.fields.fieldsDescription ?? ""
//
//            // Platform
//            identifier.text = project.fields.platform?.first?.fields.name ?? ""
//
//            // Users names
//            let users = project.fields.users
//
//            if users.count > 0 {
//                informationLabel.text = "\(users[0].fields.name)"
//                if users.count >= 2 {
//                    for i in 1...users.count-1 {
//                        informationLabel.text = "\(informationLabel.text ?? ""), \(users[i].fields.name) "
//                    }
//                }
//            }
//
//            // Lab
//            if let placeLabelText = project.fields.lab?.fields.name {
//                placeLabel.text = placeLabelText
//
//                switch placeLabelText {
//                case "Apple Developer Academy":
//                    placeLabel.textColor = .darkYellow
//                case "Globolab":
//                    placeLabel.textColor = .darkPink
//                case "Insurtech":
//                    placeLabel.textColor = .darkBlue
//                default:
//                    break
//                }
//            }
//
//            // Tags
//            if let tags = project.fields.tags {
//                switch tags.count {
//                case 0:
//                    tag1.isHidden = true
//                    tag2.isHidden = true
//                    tag3.isHidden = true
//                case 1:
//                    tag1.text = tags[0].fields.name
//                    tag2.isHidden = true
//                    tag3.isHidden = true
//                case 2:
//                    tag1.text = tags[0].fields.name
//                    tag2.text = tags[1].fields.name
//                    tag3.isHidden = true
//                case 3:
//                    tag1.text = tags[0].fields.name
//                    tag2.text = tags[1].fields.name
//                    tag3.text = tags[2].fields.name
//                default:
//                    tag1.text = tags[0].fields.name
//                    tag2.text = tags[1].fields.name
//                    tag3.text = tags[2].fields.name
//                }
//            } else {
//                tag1.isHidden = true
//                tag2.isHidden = true
//                tag3.isHidden = true
//            }
//
//            // Title
//            title.text = project.fields.name
//
//            // Image
//            if let path = project.fields.image?.first?.url {
//                if let url = URL(string: path) {
//                    addImageToView(imageURL: url, imageView: photo)
//                }
//            }
//        }
//    }
    
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
