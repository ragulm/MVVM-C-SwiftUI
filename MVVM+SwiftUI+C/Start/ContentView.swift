//
//  ContentView.swift
//  MVVM+SwiftUI+C
//
//  Created by Ragul Lakshmanan on 26/07/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject var appCoordinator = AppCoordinator(path: NavigationPath())
    
    var body: some View {
        NavigationStack(path: $appCoordinator.path) {
            appCoordinator.build()
                .navigationDestination(for: UserFlowCoordinator.self) { coordinator in
                    coordinator.build()
                }
                
                .navigationDestination(for: SettingsFlowCoordinator.self) {
                    coordinator in
                    coordinator.build()
                }
            
                .navigationDestination(for: ProfileFlowCoordinator.self) {
                    coordinator in
                    coordinator.build()
                }
            
                .navigationDestination(for: SuperUserCoordinator.self) {
                    coordinator in
                    coordinator.build()
                }
        }
        .environmentObject(appCoordinator)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
