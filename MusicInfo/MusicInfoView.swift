//
//  MusicInfoView.swift
//  MusicInfo
//
//  Created by Shin Inaba on 2020/09/04.
//  Copyright © 2020 shi-n. All rights reserved.
//

import SwiftUI

struct MusicInfoView: View {
    @EnvironmentObject var musicData: MusicData

    var body: some View {
        List {
            Text(self.musicData.titile)
            Section(header: Text("Information")) {
                HStack {
                    Text("Lyrics")
                    Spacer()
                    Text(self.musicData.lyrics)
                }
                HStack {
                    Text("Composition")
                    Spacer()
                    Text(self.musicData.composition)
                }
                HStack {
                    Text("Arrangement")
                    Spacer()
                    Text(self.musicData.arrangement)
                }
            }
            Section(header: Text("Musicians")) {
                ForEach(0..<self.musicData.musicians.count) { index in
                    HStack {
                        Text(self.musicData.musicians[index].instrument)
                        Spacer()
                        Text(self.musicData.musicians[index].name)
                    }
                }
            }
        }
    }
}

struct MusicInfoView_Previews: PreviewProvider {
    static let musicData = MusicData()
    static var previews: some View {
        MusicInfoView().environmentObject(musicData)
    }
}
