//
//  Gallery.swift
//  HurbChallenge
//
//  Created by Nathalia Inacio on 01/09/19.
//  Copyright © 2019 Nathalia Inacio. All rights reserved.

import Foundation

// MARK: - Gallery
class Gallery: Codable {
    let galleryDescription: String?
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case galleryDescription
        case url
    }
    
    init(galleryDescription: String?, url: String) {
        self.galleryDescription = galleryDescription
        self.url = url
    }
}
