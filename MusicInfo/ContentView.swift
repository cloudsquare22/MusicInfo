//
//  ContentView.swift
//  MusicInfo
//
//  Created by Shin Inaba on 2020/09/02.
//  Copyright © 2020 shi-n. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = 1
    
    @EnvironmentObject var musicData: MusicData
 
    var body: some View {
        TabView(selection: $selection) {
            Text("Second View")
                .font(.title)
                .tabItem {
                    VStack {
                        Image(systemName: "gear")
                            .font(.title)
                        Text("Setting")
                    }
                }
                .tag(0)
            MusicInfoView()
                .tabItem {
                    VStack {
                        Image(systemName: "music.note")
                            .font(.title)
                        Text("Music Info")
                    }
            }
            .tag(1)
            MusicDataFileView()
                .tabItem {
                    VStack {
                        Image(systemName: "doc.plaintext")
                            .font(.title)
                        Text("Data")
                    }
                }
                .tag(2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static let musicData = MusicData()
    static var previews: some View {
        ContentView().environmentObject(musicData)
    }
}
