//
//  AnimeResponse.swift
//  WeAniList
//
//  Created by Carlos Silva on 15/11/21.
//

struct AnimeResponse: Codable {
    var id: String
    var type: String
    var attributes: AnimeAttributesResponse
}

struct AnimeAttributesResponse: Codable {
    var createdAt: String
    var updatedAt: String
    var slug: String
    var synopsis: String?
    var description: String?
    var coverImageTopOffset: Int
    var canonicalTitle: String
    var posterImage: PosterImageResponse
}

struct PosterImageResponse: Codable {
    var tiny: String
    var large: String
    var small: String
    var medium: String
    var original: String
}
