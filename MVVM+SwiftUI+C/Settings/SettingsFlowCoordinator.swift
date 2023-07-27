//
//  SettingsCoordinator.swift
//  MVVM+SwiftUI+C
//
//  Created by Ragul Lakshmanan on 26/07/23.
//

import SwiftUI
import Combine

enum SettingsPage: String, Identifiable {
    case main, privacy, custom
    
    var id: String {
        self.rawValue
    }
}

class SettingsFlowCoordinator: ObservableObject, Hashable {
    
    @Published var page: SettingsPage
    
    private var id: UUID
    private var cancellables = Set<AnyCancellable>()
    
    let pushCoordinator = PassthroughSubject<SettingsFlowCoordinator, Never>()
    
    init(page: SettingsPage) {
        id = UUID()
        self.page = page
    }
    
    static func == (lhs: SettingsFlowCoordinator, rhs: SettingsFlowCoordinator) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    @ViewBuilder
    func build() -> some View {
        switch self.page {
        case .main:
            mainSettingsView()
        case .privacy:
            privacySettingsView()
        case .custom:
            customSettingsView()
        }
    }
    
    private func mainSettingsView() -> some View {
        let mainView = MainSettingsview()
        bind(view: mainView)
        return mainView
    }
    
    private func privacySettingsView() -> some View {
        return PrivacySettingsView()
    }
    
    private func customSettingsView() -> some View {
        return CustomSettingsView()
    }
    
    
    private func bind(view: MainSettingsview) {
        view.didClickPrivacy
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] didClick in
                if didClick {
                    self?.showPrivacySettings()
                }
            })
            .store(in: &cancellables)
        
        view.didClickCustom
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] didClick in
                if didClick {
                    self?.showCustomSettings()
                }
            })
            .store(in: &cancellables)
    }
    
}

extension SettingsFlowCoordinator {
    private func showPrivacySettings() {
        pushCoordinator.send(SettingsFlowCoordinator(page: .privacy))
    }
    
    private func showCustomSettings() {
        pushCoordinator.send(SettingsFlowCoordinator(page: .custom))
    }
}
