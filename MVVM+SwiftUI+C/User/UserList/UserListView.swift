//
//  UserListView.swift
//  MVVM+SwiftUI+C
//
//  Created by Ragul Lakshmanan on 26/07/23.
//

import SwiftUI
import Combine

struct UserListView: View {
    
    @StateObject var viewModel: UserListViewModel
    let didClickUser = PassthroughSubject<User, Never>()
    
    var body: some View {
        NavigationView {
            List(viewModel.users) {user in
                Button(action: {
                    didClickUser.send(user)
                }, label: {
                    Text(user.name)
                })
            }
        }
        .navigationBarTitle("ML User")
        .onAppear {
            viewModel.fetchUsers()
        }
    }
}

struct UserListView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView(viewModel: UserListViewModel())
    }
}
