//
//  FeaturedItem.swift
//  HurbChallenge
//
//  Created by Nathalia Inacio on 01/09/19.
//  Copyright © 2019 Nathalia Inacio. All rights reserved.

import Foundation

// MARK: - FeaturedItem
struct FeaturedItem: Codable {
    let amenities: [String]?
    let name: String?
    let image: String?
    let featuredItemDescription: String?
    let hasInternet, hasParking: Bool?
    
    enum CodingKeys: String, CodingKey {
        case amenities, name, image
        case featuredItemDescription
        case hasInternet, hasParking
    }
  
}
