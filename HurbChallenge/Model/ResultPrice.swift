//
//  ResultPrice.swift
//  HurbChallenge
//
//  Created by Nathalia Inacio on 01/09/19.
//  Copyright © 2019 Nathalia Inacio. All rights reserved.

import Foundation

// MARK: - ResultPrice
struct ResultPrice: Codable {
    let currency, currencyOriginal: String?
    let priceCurrentPrice, priceOldPrice: Double?
    let sku: String
    let originalAmountPerDay: Double?
    let amountPerDay, amount: Double
    let oldPrice, currentPrice, originalAmount: Int?
    
    enum CodingKeys: String, CodingKey {
        case currency
        case currencyOriginal
        case priceCurrentPrice
        case priceOldPrice
        case sku, originalAmountPerDay, amountPerDay, amount, oldPrice, currentPrice, originalAmount
    }
    
}


