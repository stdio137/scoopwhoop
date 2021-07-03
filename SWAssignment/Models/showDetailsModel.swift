//
//  showDetailsModel.swift
//  SWAssignment
//
//  Created by Shubham Tandon on 03/07/21.
//

import Foundation

struct ShowDetail {
    init() {
        self.name = ""
        self.featureImageLand = ""
        self.featureImg = ""
        self.titles = [String]()
        self.thumbnails = [String]()
        self.desc = ""
        self.nextOffset = 10
    }
    
    var name: String
    var featureImageLand: String
    var featureImg: String
    var titles: [String]
    var thumbnails: [String]
    var desc: String
    var nextOffset: Int
}

// MARK: - ShowDetailResponse
struct ShowDetailResponse: Codable {
    let status: Int
    let showDetails: ShowDetails
    let nextOffset: Int
    let data: [ShowDetailData]
    let err: String

    enum CodingKeys: String, CodingKey {
        case status
        case showDetails = "show_details"
        case nextOffset = "next_offset"
        case data, err
    }
}

// MARK: - Datum
struct ShowDetailData: Codable {
    let title: String
    let newTags: [NewTag]
    let featureImg: String

    enum CodingKeys: String, CodingKey {
        case title
        case newTags = "new_tags"
        case featureImg = "feature_img"
    }
}

// MARK: - NewTag
struct NewTag: Codable {
    let id: String
    let flag: Int
    let title, tagSlug, tagType: String

    enum CodingKeys: String, CodingKey {
        case id, flag, title
        case tagSlug = "tag_slug"
        case tagType = "tag_type"
    }
}

// MARK: - Show
struct ShowData: Codable {
    let topic: String
    let featureImgPort, topicFeatureImg, featureImgLand: String
    
    enum CodingKeys: String, CodingKey {
        case topic
        case featureImgPort = "feature_img_port"
        case topicFeatureImg = "topic_feature_img"
        case featureImgLand = "feature_img_land"
    }
}

// MARK: - ShowDetails
struct ShowDetails: Codable {
    let topicName: String
    let totalVideos: Int
    let topicDesc: String
    let topicSlug: String
    let featureImgLand: String

    enum CodingKeys: String, CodingKey {
        case topicName = "topic_name"
        case totalVideos = "total_videos"
        case topicDesc = "topic_desc"
        case topicSlug = "topic_slug"
        case featureImgLand = "feature_img_land"
    }
}
