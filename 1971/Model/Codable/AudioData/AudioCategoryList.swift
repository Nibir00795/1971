//
//  AudioCategory.swift
//  1971
//
//  Created by Right on 12/26/19.
//  Copyright © 2019 Mobioapp. All rights reserved.
//



import Foundation

// MARK: - AudioCategory
struct AudioCategoryList: Codable {
    let statusCode: Int
    let message: String
    let data: [AudioCategory]

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data
    }
}

// MARK: - Datum
struct AudioCategory: Codable {
    let catID, catName: String

    enum CodingKeys: String, CodingKey {
        case catID = "cat_id"
        case catName = "cat_name"
    }
}
