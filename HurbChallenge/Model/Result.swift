//
//  Result.swift
//  HurbChallenge
//
//  Created by Nathalia Inacio on 01/09/19.
//  Copyright © 2019 Nathalia Inacio. All rights reserved.

import Foundation

// MARK: - Result
struct Result: Codable {
    let sku: String
    let isPackage: Bool?
    let isHotel:Bool?
    let name: String
    let url: String
    let smallDescription, resultDescription: String?
    let gallery: [Gallery]
    let address: Address
    let tags: [String]?
    let price: ResultPrice
    let featuredItem: FeaturedItem
    let category: String
    let quantityDescriptors: QuantityDescriptors
    let id: String
    let amenities: [Amenity]
    
    enum CodingKeys: String, CodingKey {
        case sku, isHotel, name, url, smallDescription, isPackage
        case resultDescription
        case gallery, address, tags, price, featuredItem, category, quantityDescriptors, id, amenities
    }

}
