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
    @Published var arrangement = "-"
    @Published var musicians: [Musician] = []
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

        if let now : MPMediaItem = player.nowPlayingItem {
            if let name = now.albumTitle {
                self.albumName = name
            }

            if let name = now.albumArtist {
                if self.artistName != name {
                    loadMusicInfoData(artistName: name)
                }
                self.artistName = name
            }
            else if let name = now.artist {
                if self.artistName != name {
                    loadMusicInfoData(artistName: name)
                }
                self.artistName = name
            }
            
            if let name = now.title {
                self.titile = name
            }
            print(self.albumName)
            print(self.artistName)
            print(self.titile)
            print(now.albumTrackNumber)
                        
            var selectAlbum = -1
            for (index, album) in self.musicInfoData.albums.enumerated() {
                let albumName = album.albumName.uppercased().components(separatedBy: .whitespaces).joined()
                let nowAlbumName = self.albumName.uppercased().components(separatedBy: .whitespaces).joined()
                print(albumName)
                print(nowAlbumName)
                if albumName == nowAlbumName {
                    selectAlbum = index
                    break
                }
            }
            
            if selectAlbum != -1 && self.musicInfoData.albums[selectAlbum].musics.count >= now.albumTrackNumber {
                self.lyrics = arrayToString(self.musicInfoData.albums[selectAlbum].musics[now.albumTrackNumber - 1].lyrics)
                self.composition = arrayToString(self.musicInfoData.albums[selectAlbum].musics[now.albumTrackNumber - 1].composition)
                self.arrangement = arrayToString(self.musicInfoData.albums[selectAlbum].musics[now.albumTrackNumber - 1].arrangement)
                if self.musicInfoData.albums[selectAlbum].musics[now.albumTrackNumber - 1].musicians.count > 0 {
                    self.musicians = self.musicInfoData.albums[selectAlbum].musics[now.albumTrackNumber - 1].musicians
                }
                else {
                    self.musicians = self.musicInfoData.albums[selectAlbum].musicians
                    if let musicians = self.musicInfoData.albums[selectAlbum].musics[now.albumTrackNumber - 1].addMusicians {
                        self.musicians.append(contentsOf: musicians)
                    }
                }
            }
        }
    }
    
    func arrayToString(_ strings: [String]) -> String {
        var result = ""
        for (index, string) in strings.enumerated() {
            result = result + string
            if strings.count > index + 1 {
                result = result + ", "
            }
        }
        return result
    }
    
    func loadMusicInfoData() {
        guard let url = Bundle.main.url(forResource: "Example", withExtension: "json") else {
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

    func loadMusicInfoData(artistName: String) {
        let fileManager = FileManager.default
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let filePath = documentsPath + "/\(artistName).json"
        if fileManager.fileExists(atPath: filePath) == true {
            print("File Exists:\(filePath)")

            guard let data = try? Data(contentsOf: URL(fileURLWithPath: filePath)) else {
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

    func next() {
        player.skipToNextItem()
    }
    
    func previous() {
        player.skipToPreviousItem()
    }
    
}
