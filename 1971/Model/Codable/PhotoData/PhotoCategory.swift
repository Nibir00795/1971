//
//  PhotoCategory.swift
//  1971
//
//  Created by Right on 12/20/19.
//  Copyright © 2019 Mobioapp. All rights reserved.
//

import Foundation


// MARK: - PhotoCategoryList
struct PhotoCategoryList: Codable {
    let statusCode: Int
    let message: String
    let data: [PhotoCategory]

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data
    }
}

// MARK: - Datum
struct PhotoCategory: Codable {
    let imgCatID, catName, adminID: String

    enum CodingKeys: String, CodingKey {
        case imgCatID = "img_cat_id"
        case catName = "cat_name"
        case adminID = "admin_id"
    }
}
