//
//  API_JCH.swift
//  JCH VCC
//
//  Created by Sami on 12/10/18.
//  Copyright © 2018 Sami. All rights reserved.
//
//
import Foundation
var basePath                                              = "http://glazeitsolutions.com" // SERVER

public let API_POPULAR_VIDEO                            = "\(basePath)/admin/public/api/video/popular.php"

public let API_RECENT_VIDEO                            = "\(basePath)/admin/public/api/video/recent.php"

//video
public let API_VIDEO_CATEGORY_LIST                            = "\(basePath)/admin/public/api/category/all.php"
public let API_VIDEO_BY_CATEGORY                            = "\(basePath)/admin/public/api/video/by-category.php"

//image
public let API_IMAGE_CATEGORY_LIST  = "\(basePath)/admin/public/api/category/image-category.php"
public let API_IMAGE_BY_CATEGORY                            = "\(basePath)/admin/public/api/image/by-category.php"

//audio
public let API_AUDIO_CATEGORY_LIST  = "\(basePath)/admin/public/api/category/audio-category.php"
public let API_AUDIO_BY_CATEGORY  = "\(basePath)/admin/public/api/audio/by-category.php"

//doc
public let API_DOC_CATEGORY_LIST  = "\(basePath)/admin/public/api/category/document-category.php"
public let API_DOC_BY_CATEGORY                            = "\(basePath)/admin/public/api/document/by-category.php"
