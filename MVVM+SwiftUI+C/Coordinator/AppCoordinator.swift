//
//  BaseCoordinator.swift
//  MVVM+SwiftUI+C
//
//  Created by Ragul Lakshmanan on 26/07/23.
//

import Foundation
import Combine
import SwiftUI

class AppCoordinator: ObservableObject {
    
    @Published var path: NavigationPath
    private var cancellables = Set<AnyCancellable>()
    
    init(path: NavigationPath) {
        self.path = path
    }
    
    @ViewBuilder
    func build() -> some View {
        homeView()
    }
    
    private func push<T: Hashable>(_ coordinator: T) {
        self.path.append(coordinator)
    }
    
    func homeView() -> some View {
        let homeView = HomeView()
        bind(home: homeView)
        return homeView
    }
    
    private func usersFlow() {
        let usersFlowCoordinator = UserFlowCoordinator(page: .users)
        self.bind(userCoordinator: usersFlowCoordinator)
        self.push(usersFlowCoordinator)
    }
    
    private func settingsFlow() {
        let settingsFlowCoordinator = SettingsFlowCoordinator(page: .main)
        self.bind(settingsCoordinator: settingsFlowCoordinator)
        self.push(settingsFlowCoordinator)
    }
    
    private func profileFlow() {
        let profileFlowCoordinator = ProfileFlowCoordinator(page: .main)
        self.bind(profileCoordinator: profileFlowCoordinator)
        self.push(profileFlowCoordinator)
    }
    
    private func superUserFlow() {
        let superUserCoordinator = SuperUserCoordinator(type: .details)
        self.bind(superUserCoordinator: superUserCoordinator)
        self.push(superUserCoordinator)
    }
    
    func bind(home: HomeView) {
        home.didClickMenuItem
            .receive(on: DispatchQueue.main)
            .sink { [weak self] item in
                switch item {
                case "Users":
                    self?.usersFlow()
                case "Settings":
                    self?.settingsFlow()
                case "Profile":
                    self?.profileFlow()
                case "Super User":
                    self?.superUserFlow()
                default:
                    break
                }
            }
            .store(in: &cancellables)
    }
    
    func bind(userCoordinator: UserFlowCoordinator) {
        userCoordinator.pushCoordinator
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] coordinator in
                self?.push(coordinator)
            })
            .store(in: &cancellables)
    }
    
    func bind(settingsCoordinator: SettingsFlowCoordinator) {
        settingsCoordinator.pushCoordinator
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] coordinator in
                self?.push(coordinator)
            })
            .store(in: &cancellables)
    }
    
    func bind(profileCoordinator: ProfileFlowCoordinator) {
        profileCoordinator.pushCoordinator
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] coordinator in
                self?.push(coordinator)
            })
            .store(in: &cancellables)
    }
    
    func bind(superUserCoordinator: SuperUserCoordinator) {
        superUserCoordinator.pushCoordinator
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {[weak self] coordinator in
                self?.push(coordinator)
            })
            .store(in: &cancellables)
    }
}
