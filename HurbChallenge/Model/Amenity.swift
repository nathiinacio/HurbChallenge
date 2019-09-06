//
//  Amenity.swift
//  HurbChallenge
//
//  Created by Nathalia Inacio on 01/09/19.
//  Copyright © 2019 Nathalia Inacio. All rights reserved.

import Foundation

// MARK: - Amenity
struct Amenity: Codable {
    let name: String?
    let category: String?
}

// MARK: - AmenityElement
struct AmenityElement: Codable {
    let name: String
    let category: String
    
}

// MARK: - PurpleAmenity
class PurpleAmenity: Codable {
    let term, filter: String
    let count: Int
}
