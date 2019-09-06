//
//  Address.swift
//  HurbChallenge
//
//  Created by Nathalia Inacio on 01/09/19.
//  Copyright © 2019 Nathalia Inacio. All rights reserved.

import Foundation

// MARK: - Address
struct Address: Codable {
    let city: String
    let country: String
    let idAtlasCity, idAtlasCountry, idAtlasNeighborhood, idAtlasState: String?
    let idCity, idCountry, idState: Int?
    let state: String
    let street, zipcode: String?
    let geoLocation: GeoLocation
    
    enum CodingKeys: String, CodingKey {
        case city, country
        case idAtlasCity
        case idAtlasCountry
        case idAtlasNeighborhood
        case idAtlasState
        case idCity
        case idCountry
        case idState
        case state, street, zipcode, geoLocation
    }

}
