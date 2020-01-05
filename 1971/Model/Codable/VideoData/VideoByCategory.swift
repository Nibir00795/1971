//
//  VideoByCategory.swift
//  1971
//
//  Created by Mobioapp on 18/12/19.
//  Copyright © 2019 Mobioapp. All rights reserved.
//

import Foundation

struct VideoByCategory: Codable {
    let statusCode: Int
    let message: String
    let data: [VideoInfo]

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data
    }
}

// MARK: - Datum
struct VideoInfo: Codable {
    let id, category: String
    let adminID, status: String?
    let title: String
    let datumDescription: String?
    let imageName, type: String
    let uploadedVideo: String?
    let youtube: String
    let vimeo, youku, videoLink: String?
    let featured, viewCount, imageResolution, duration: String
    let created: Int

    enum CodingKeys: String, CodingKey {
        case id, category
        case adminID = "admin_id"
        case status, title
        case datumDescription = "description"
        case imageName = "image_name"
        case type
        case uploadedVideo = "uploaded_video"
        case youtube, vimeo, youku
        case videoLink = "video_link"
        case featured
        case viewCount = "view_count"
        case imageResolution = "image_resolution"
        case duration, created
    }
}
