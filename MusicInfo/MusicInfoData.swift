//
//  MusicInfoData.swift
//  MusicInfo
//
//  Created by Shin Inaba on 2020/09/03.
//  Copyright © 2020 shi-n. All rights reserved.
//

import Foundation

struct MusicInfoData: Codable {
    let artistName: String
    let albums: [Album]
}

struct Album: Codable {
    let albumName: String
    let musics: [Music]
}

struct Music: Codable {
    let track: Int
    let title: String
    let lyrics: String
    let composition: String
}
