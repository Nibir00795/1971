//
//  PhotoByCategory.swift
//  1971
//
//  Created by Right on 12/20/19.
//  Copyright © 2019 Mobioapp. All rights reserved.
//

import Foundation

// MARK: - PhotoByCategory
struct PhotoByCategory: Codable {
    let statusCode: Int
    let message: String
    let data: [photoInfo]

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data
    }
}

// MARK: - Datum
struct photoInfo: Codable {
    let id, imgTitle, imgURL, adminID: String
    let imgDesc, imgCatID: String

    enum CodingKeys: String, CodingKey {
        case id
        case imgTitle = "img_title"
        case imgURL = "img_url"
        case adminID = "admin_id"
        case imgDesc = "img_desc"
        case imgCatID = "img_cat_id"
    }
}
