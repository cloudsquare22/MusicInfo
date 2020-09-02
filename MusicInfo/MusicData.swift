//
//  MusicData.swift
//  MusicInfo
//
//  Created by Shin Inaba on 2020/09/02.
//  Copyright © 2020 shi-n. All rights reserved.
//

import SwiftUI
import MediaPlayer

final class MusicData: ObservableObject {
    @Published var albumName = "-"
    @Published var artistName = "-"
    @Published var titile = "-"
    @Published var lyrics = "-"
    @Published var composition = "-"
    var musicInfoData: MusicInfoData = MusicInfoData(artistName: "-", albums: [])

    var player: MPMusicPlayerController! = MPMusicPlayerController.systemMusicPlayer
    let userDefaults = UserDefaults.standard

    init() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(MusicData.changeMusic(_:)), name: NSNotification.Name.MPMusicPlayerControllerNowPlayingItemDidChange, object: player)
        player.beginGeneratingPlaybackNotifications()
        loadMusicInfoData()
        setNowPlaying()
    }

    @objc func changeMusic(_ notification:Notification?) {
        print(#function)
        setNowPlaying()
    }
    
    func setNowPlaying() {
        print(#function)
        self.albumName = "-"
        self.artistName = "-"
        self.titile = "-"
        self.lyrics = "-"
        self.composition = "-"

        if let now : MPMediaItem = player.nowPlayingItem {
            if let name = now.albumTitle {
                self.albumName = name
            }

            if let name = now.albumArtist {
                self.artistName = name
            }
            else if let name = now.artist {
                self.artistName = name
            }
            
            if let name = now.title {
                self.titile = name
            }
            
            print(now.albumTrackNumber)
            if self.musicInfoData.albums[0].musics.count >= now.albumTrackNumber {
                self.lyrics = self.musicInfoData.albums[0].musics[now.albumTrackNumber - 1].lyrics
                self.composition = self.musicInfoData.albums[0].musics[now.albumTrackNumber - 1].composition
            }
        }
    }
    
    func loadMusicInfoData() {
        guard let url = Bundle.main.url(forResource: "kyosuke_himuro", withExtension: "json") else {
            fatalError("ファイルが見つからない")
        }
        guard let data = try? Data(contentsOf: url) else {
            fatalError("ファイル読み込みエラー")
        }
        let decoder = JSONDecoder()
        guard let musicInfoData = try? decoder.decode(MusicInfoData.self, from: data) else {
            fatalError("JOSN読み込みエラー")
        }
        print(musicInfoData)
        self.musicInfoData = musicInfoData
    }
    
}
