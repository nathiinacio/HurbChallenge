//
//  Hotel.swift
//  HurbChallenge
//
//  Created by Nathalia Inacio on 01/09/19.
//  Copyright © 2019 Nathalia Inacio. All rights reserved.

import Foundation

// MARK: - Hotel
class Hotel: Codable {
    let filters: Filters
    let results: [Result]
    let pagination: Pagination
    
    init(filters: Filters, results: [Result], pagination: Pagination) {
        self.filters = filters
        self.results = results
        self.pagination = pagination
    }
}
