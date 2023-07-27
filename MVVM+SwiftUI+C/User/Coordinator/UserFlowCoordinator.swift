//
//  UserCoordinator.swift
//  MVVM+SwiftUI+C
//
//  Created by Ragul Lakshmanan on 26/07/23.
//

import Foundation
import Combine
import SwiftUI

// Enum to identify User flow screen Types
enum UserPage: String, Identifiable {
    case users, profile
    
    var id: String {
        self.rawValue
    }
}

class UserFlowCoordinator: ObservableObject, Hashable {
    
    @Published var page: UserPage
    
    private var id: UUID
    private var userID: Int?
    private var cancellables = Set<AnyCancellable>()
    
    let pushCoordinator = PassthroughSubject<UserFlowCoordinator, Never>()
    
    init(page: UserPage, userID: Int? = nil) {
        self.id = UUID()
        self.page = page
        
        if page == .profile {
            guard let userID = userID else {
                fatalError("userID must be provided for profile type")
            }
            self.userID = userID
        }
    }
    
    static func == (lhs: UserFlowCoordinator, rhs: UserFlowCoordinator) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    @ViewBuilder
    func build() -> some View {
        switch self.page {
        case .users:
            usersListView()
        case .profile:
            userDetailsView()
        }
    }
    
    private func usersListView() -> some View {
        let viewModel = UserListViewModel()
        let usersListView = UserListView(viewModel: viewModel)
        bind(view: usersListView)
        return usersListView
    }
    
    private func userDetailsView() -> some View {
        let viewModel = UserDetailsViewModel(userID: userID ?? 0)
        let userDetailsView = UserDetailsView(viewModel: viewModel)
        return userDetailsView
    }
    
    private func bind(view: UserListView) {
        view.didClickUser
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] user in
                self?.showUserProfile(for: user)
            })
            .store(in: &cancellables)
    }
    
}

extension UserFlowCoordinator {
    func showUserProfile(for user: User) {
        pushCoordinator.send(UserFlowCoordinator(page: .profile, userID: user.id))
    }
}

