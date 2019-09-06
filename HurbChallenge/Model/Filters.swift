//
//  Filters.swift
//  HurbChallenge
//
//  Created by Nathalia Inacio on 01/09/19.
//  Copyright © 2019 Nathalia Inacio. All rights reserved.

import Foundation

// MARK: - Filters
struct Filters: Codable {
    let amenities, attributes, countries, cities: [PurpleAmenity]
    let departureCities, duration, food, people: [PurpleAmenity]
    let prices: [PriceElement]
    let priceInterval: PriceInterval
    let productType, regulation, rooms, stars: [PurpleAmenity]
    let states: [PurpleAmenity]
}
