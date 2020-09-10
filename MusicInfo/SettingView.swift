//
//  SettingView.swift
//  MusicInfo
//
//  Created by Shin Inaba on 2020/09/11.
//  Copyright © 2020 shi-n. All rights reserved.
//

import SwiftUI

struct SettingView: View {
    var body: some View {
        List {
            Section(header: Text("About")) {
                VStack {
                    Text("Music Info")
                        .font(.largeTitle)
                    Text("Version 1.0")
                        .font(.caption)
                }
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
