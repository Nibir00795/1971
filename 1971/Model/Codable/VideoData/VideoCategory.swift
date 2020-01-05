//
//  VideoCategory.swift
//  1971
//
//  Created by Mobioapp on 18/12/19.
//  Copyright © 2019 Mobioapp. All rights reserved.
//

import Foundation


struct VideoCategory: Codable {
    let statusCode: Int
    let message: String
    let data: [CategoryList]

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data
    }
}

// MARK: - Datum
struct CategoryList: Codable {
    let id, imageName, title, adminID: String
    let status, imageResolution: String
    let created: Int

    enum CodingKeys: String, CodingKey {
        case id
        case imageName = "image_name"
        case title
        case adminID = "admin_id"
        case status
        case imageResolution = "image_resolution"
        case created
    }
}
