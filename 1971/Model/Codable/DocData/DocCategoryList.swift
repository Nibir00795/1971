//
//  DocCategoryList.swift
//  1971
//
//  Created by Right on 12/27/19.
//  Copyright © 2019 Mobioapp. All rights reserved.
//

import Foundation

// MARK: - DoccategoryList
struct DocCategoryList: Codable {
    let statusCode: Int
    let message: String
    let data: [DocCategory]

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data
    }
}

// MARK: - Datum
struct DocCategory: Codable {
    let docID, docCatTitle, adminID: String

    enum CodingKeys: String, CodingKey {
        case docID = "doc_id"
        case docCatTitle = "doc_cat_title"
        case adminID = "admin_id"
    }
}

