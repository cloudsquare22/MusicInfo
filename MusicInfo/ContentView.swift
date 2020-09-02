//
//  ContentView.swift
//  MusicInfo
//
//  Created by Shin Inaba on 2020/09/02.
//  Copyright © 2020 shi-n. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = 0
    
    @EnvironmentObject var musicData: MusicData
 
    var body: some View {
        TabView(selection: $selection){
            VStack {
                Text(self.musicData.albumName)
                Text(self.musicData.artistName)
                Text(self.musicData.titile)
                Text(self.musicData.lyrics)
                Text(self.musicData.composition)
            }
            .font(.title)
            .tabItem {
                VStack {
                    Image("first")
                    Text("First")
                }
            }
            .tag(0)
            Text("Second View")
                .font(.title)
                .tabItem {
                    VStack {
                        Image("second")
                        Text("Second")
                    }
                }
                .tag(1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static let musicData = MusicData()
    static var previews: some View {
        ContentView().environmentObject(musicData)
    }
}
