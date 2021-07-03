//
//  ShowsModel.swift
//  SWAssignment
//
//  Created by Shubham Tandon on 03/07/21.
//

import UIKit

struct Show {
    
    internal init(name: String, showimageURL: String, nameSlug: String) {
        self.name = name
        self.showimageURL = showimageURL
        self.nameSlug = nameSlug
    }

    var name: String
    var showimageURL: String
    var nameSlug: String
    var topicDesc: String?
}

// MARK: - ShowsResponse
struct ShowsResponse: Decodable {
    let status, nextOffset, totalShows: Int
    let data: [ShowResponse]
    let err: String

    enum CodingKeys: String, CodingKey {
        case status
        case nextOffset = "next_offset"
        case totalShows = "total_shows"
        case data, err
    }
}

// MARK: - ShowResponse
struct ShowResponse: Decodable {
    let featureImgPort: String
    let topicName: String
    let topicSlug: String
    let topicDesc: String

    enum CodingKeys: String, CodingKey {
        case featureImgPort = "feature_img_port"
        case topicName = "topic_name"
        case topicSlug = "topic_slug"
        case topicDesc = "topic_desc"
    }
}
