//
//  MusicDataFileView.swift
//  MusicInfo
//
//  Created by Shin Inaba on 2020/09/09.
//  Copyright © 2020 shi-n. All rights reserved.
//

import SwiftUI

struct MusicDataFileView: View {
    @EnvironmentObject var musicData: MusicData

    var body: some View {
        List {
            Section(header: Text("Music Data Files")) {
                ForEach(self.musicData.musicDataFileList) { musicDataFile in
                    Text(musicDataFile.fileName)
                }
            }
        }
        .onAppear() {
            self.musicData.setMusicInfoDataFileList()
        }
    }
}

struct MusicDataFileView_Previews: PreviewProvider {
    static let musicData = MusicData()
    static var previews: some View {
        MusicDataFileView().environmentObject(musicData)
    }
}
