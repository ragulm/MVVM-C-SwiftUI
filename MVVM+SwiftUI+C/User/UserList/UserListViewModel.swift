//
//  UserListViewModel.swift
//  MVVM+SwiftUI+C
//
//  Created by Ragul Lakshmanan on 26/07/23.
//

import Combine

class UserListViewModel: ObservableObject {
    
    @Published var users: [User] = []
    
    func fetchUsers() {
        self.users = [
            User(id: 1, name: "User 1"),
            User(id: 2, name: "User 2"),
            User(id: 3, name: "User 3")
        ]
    }
}

struct User: Identifiable {
    let id: Int
    let name: String
}
