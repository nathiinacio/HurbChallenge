//
//  Price.swift
//  HurbChallenge
//
//  Created by Nathalia Inacio on 01/09/19.
//  Copyright © 2019 Nathalia Inacio. All rights reserved.

import Foundation

// MARK: - PriceInterval
struct PriceInterval: Codable {
    let min, max: Int
    let filterPattern: String
}

// MARK: - PriceElement
struct PriceElement: Codable {
    let min, maxExclusive: Int
    let filter: String
    let count: Int
}
