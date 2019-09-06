//
//  QuantityDescriptors.swift
//  HurbChallenge
//
//  Created by Nathalia Inacio on 01/09/19.
//  Copyright © 2019 Nathalia Inacio. All rights reserved.

import Foundation

// MARK: - QuantityDescriptors
struct QuantityDescriptors: Codable {
    let maxChildren, maxAdults, maxFreeChildrenAge, nights: Int?
    let maxPeople: Int?
}
