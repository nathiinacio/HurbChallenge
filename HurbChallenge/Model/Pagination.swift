//
//  Pagination.swift
//  HurbChallenge
//
//  Created by Nathalia Inacio on 01/09/19.
//  Copyright © 2019 Nathalia Inacio. All rights reserved.

import Foundation

// MARK: - Pagination
struct Pagination: Codable {
    let count: Int
    let firstPage, nextPage: String
    let previousPage: String?
    let lastPage: String
}
