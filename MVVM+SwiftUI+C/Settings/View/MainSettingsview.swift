//
//  mainSettingsview.swift
//  MVVM+SwiftUI+C
//
//  Created by Ragul Lakshmanan on 26/07/23.
//

import SwiftUI
import Combine

struct MainSettingsview: View {
    let didClickPrivacy = PassthroughSubject<Bool, Never>()
    let didClickCustom = PassthroughSubject<Bool, Never>()
    
    var body: some View {
        List {
            Button(action: {
                didClickPrivacy.send(true)
            }) {
                Text("Privacy Settings")
            }
            Button(action: {
                didClickCustom.send(true)
            }) {
                Text("Custom Settings")
            }
        }
        .navigationBarTitle("Settings")
    }
}

struct mainSettingsview_Previews: PreviewProvider {
    static var previews: some View {
        MainSettingsview()
    }
}
