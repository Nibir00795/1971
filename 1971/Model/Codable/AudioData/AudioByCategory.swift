//
//  PhotoByCategory.swift
//  1971
//
//  Created by Right on 12/26/19.
//  Copyright © 2019 Mobioapp. All rights reserved.
//

import Foundation

// MARK: - AudioByCategory
struct AudioByCategory: Codable {
    let statusCode: Int
    let message: String
    let data: [AudioInfo]

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data
    }
}

// MARK: - Datum
struct AudioInfo: Codable {
    let id, audioTitle, audioURL, audioCatID: String
    let audioImg, audioDescription: String

    enum CodingKeys: String, CodingKey {
        case id
        case audioTitle = "audio_title"
        case audioURL = "audio_url"
        case audioCatID = "audio_cat_id"
        case audioImg = "audio_img"
        case audioDescription = "audio_description"
    }
}

