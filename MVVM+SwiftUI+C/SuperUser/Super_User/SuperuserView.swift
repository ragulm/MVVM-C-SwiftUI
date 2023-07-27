//
//  SuperuserView.swift
//  MVVM+SwiftUI+C
//
//  Created by Ragul Lakshmanan on 27/07/23.
//

import SwiftUI
import Combine

struct SuperUserView: View {
    
    let didClickJob = PassthroughSubject<String, Never>()
    let didClickEducation = PassthroughSubject<String, Never>()
    
    var name: String
    var age: String
    var weight: Double
    var height: Double
    
    init(name: String, age: String, weight: Double, height: Double) {
        self.name = name
        self.age = age
        self.weight = weight
        self.height = height
    }
    
    var body: some View {
        Text(name)
        Text(age)
        Text("\(weight)")
        Text("\(height)")
        Button(action: {
            didClickJob.send("JOB")
        }, label: {
            Text("Job")
        })
        Button(action: {
            didClickEducation.send("Education")
        }, label: {
            Text("Education")
        })
    }
}

struct SuperUserView_Previews: PreviewProvider {
    static var previews: some View {
        SuperUserView(name: "Ragul", age: "31", weight: 92.1, height: 172)
    }
}
