//
//  Search.swift
//  itune
//
//  Created by Bill Chang on 2022/6/3.
//

import Foundation

// https://developer.apple.com/library/archive/documentation/AudioVideo/Conceptual/iTuneSearchAPI/Searching.html
struct SearchResponse: Codable {
   let resultCount: Int
   let results: [SongItem]
}

struct SongItem: Codable {
   let artistName: String
   let trackName: String
   let previewUrl: URL
}
