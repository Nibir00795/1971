//
//  DocByCategory.swift
//  1971
//
//  Created by Right on 12/27/19.
//  Copyright © 2019 Mobioapp. All rights reserved.
//

import Foundation

// MARK: - DocByCategory
struct DocByCategory: Codable {
    let statusCode: Int
    let message: String
    let data: [DocInfo]

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data
    }
}

// MARK: - Datum
struct DocInfo: Codable {
    let id, docTitle, docCatID, adminID: String
    let docImgURL, docFileURL, docAuthor: String

    enum CodingKeys: String, CodingKey {
        case id
        case docTitle = "doc_title"
        case docCatID = "doc_cat_id"
        case adminID = "admin_id"
        case docImgURL = "doc_img_url"
        case docFileURL = "doc_file_url"
        case docAuthor = "doc_author"
    }
}
