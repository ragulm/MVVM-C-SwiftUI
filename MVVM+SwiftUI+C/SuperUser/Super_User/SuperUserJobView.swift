//
//  SuperUserJobView.swift
//  MVVM+SwiftUI+C
//
//  Created by Ragul Lakshmanan on 27/07/23.
//

import SwiftUI
import Combine

struct SuperUserJobView: View {
    
    let didClickCurrentJob = PassthroughSubject<String, Never>()
    
    var body: some View {
        Text("JOB")
        Button(action: {
            didClickCurrentJob.send("Current JOB")
        }, label: {
            Text("Current JOB")
        })
    }
}

struct SuperUserJobView_Previews: PreviewProvider {
    static var previews: some View {
        SuperUserJobView()
    }
}
