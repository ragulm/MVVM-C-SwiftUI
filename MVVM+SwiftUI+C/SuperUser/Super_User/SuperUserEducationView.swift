//
//  SuperUserEducationView.swift
//  MVVM+SwiftUI+C
//
//  Created by Ragul Lakshmanan on 27/07/23.
//

import SwiftUI
import Combine

struct SuperUserEducationView: View {
    
    let didClickHigherEducation = PassthroughSubject<String, Never>()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        Button(action: {
            didClickHigherEducation.send("Higer Education")
        }, label: {
            Text("Higer Education")
        })
    }
}

struct SuperUserEducationView_Previews: PreviewProvider {
    static var previews: some View {
        SuperUserEducationView()
    }
}
