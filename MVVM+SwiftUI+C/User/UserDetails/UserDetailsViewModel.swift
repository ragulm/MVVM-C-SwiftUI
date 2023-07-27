//
//  UserDetailsViewModel.swift
//  MVVM+SwiftUI+C
//
//  Created by Ragul Lakshmanan on 26/07/23.
//

import Combine

class UserDetailsViewModel: ObservableObject {
    @Published var profile:Profile?
    private var userID: Int
    
    init(userID: Int) {
        self.userID = userID
    }
    
    func fetchProfile() {
        self.profile = Profile(id: 05,
                               name: "Jone Doe",
                               age: 25,
                               occupation: "Doctor")
    }
}

struct Profile: Identifiable {
    let id: Int
    let name: String
    let age: Int
    let occupation: String
}
