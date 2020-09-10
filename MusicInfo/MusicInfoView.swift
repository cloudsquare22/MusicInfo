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
            HStack {
                Spacer()
                Text(self.musicData.titile)
                    .font(.title)
                Spacer()
            }
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
                ForEach(self.musicData.musicians) { musician in
                    HStack {
                        Text(musician.instrument)
                        Spacer()
                        Text(musician.name)
                    }
                }
            }
            Section(header: Text("Album & Artist")) {
                Text(self.musicData.albumName)
                Text(self.musicData.artistName)
            }
        }
        .onTapGesture(count: 2, perform: {
            self.musicData.previous()
        })
        .onTapGesture(perform: {
            self.musicData.next()
        })

    }
}

struct MusicInfoView_Previews: PreviewProvider {
    static let musicData = MusicData()
    static var previews: some View {
        MusicInfoView().environmentObject(musicData)
    }
}
