//
//  UserDetailsView.swift
//  MVVM+SwiftUI+C
//
//  Created by Ragul Lakshmanan on 26/07/23.
//

import SwiftUI

struct UserDetailsView: View {
    @StateObject var viewModel: UserDetailsViewModel
    
    var body: some View {
        VStack {
            Text(viewModel.profile?.name ?? "N/A")
                .font(.title)
            if let age = viewModel.profile?.age {
                Text("Age: \(String(age))")
            } else {
                Text("Age: Unknown")
            }
            Text("Occupation: \(viewModel.profile?.occupation ?? "N/A")")
            Spacer()
        }
        .padding()
        .navigationBarTitle("USER DETAILS")
        .onAppear {
            viewModel.fetchProfile()
        }
    }
    
}

struct UserDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailsView(viewModel: UserDetailsViewModel(userID: 1))
    }
}
