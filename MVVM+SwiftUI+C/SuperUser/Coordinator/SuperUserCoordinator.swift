//
//  SuperUserCoordinator.swift
//  MVVM+SwiftUI+C
//
//  Created by Ragul Lakshmanan on 27/07/23.
//

import SwiftUI
import Combine

enum SuperUserCheck: String, Identifiable {
    case details
    case job
    case currentJob
    case education
    case higherEducation
    
    var id: String {
        self.rawValue
    }
}

class SuperUserCoordinator: ObservableObject, Hashable {
    
    @Published var type: SuperUserCheck
    
    private var id: UUID
    private var cancellable = Set<AnyCancellable>()

    let pushCoordinator = PassthroughSubject<SuperUserCoordinator, Never>()
    
    init(type: SuperUserCheck) {
        self.id = UUID()
        self.type = type
    }
    
    static func == (lhs: SuperUserCoordinator, rhs: SuperUserCoordinator) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    @ViewBuilder
    func build() -> some View {
        switch self.type {
        case .details:
            superUserDetails()
        case .job:
            superUserJob()
        case .currentJob:
            superUserCurrentJob()
        case .education:
            superUserEducation()
        case .higherEducation:
            superUserHigherEducation()
        }
    }
    
    private func superUserDetails() -> some View {
        let sUser = SuperUserView(name: "Ragul", age: "30", weight: 92, height: 172)
        self.bind(view: sUser)
        return sUser
    }
    
    private func superUserJob() -> some View {
        let uJob = SuperUserJobView()
        self.bind(view: uJob)
        return uJob
    }
    
    private func superUserCurrentJob() -> some View {
        SuperUserCurrentJobView()
    }
    
    private func superUserEducation() -> some View {
        let uEdu = SuperUserEducationView()
        self.bind(view: uEdu)
        return uEdu
    }
    
    private func superUserHigherEducation() -> some View {
        SuperUserHigherEducationView()
    }
    
    private func bind(view: SuperUserView) {
        view.didClickJob
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] val in
                self?.navigateToJob()
            })
            .store(in: &cancellable)
        
        view.didClickEducation
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] val in
                self?.navigateToEducation()
            })
            .store(in: &cancellable)
    }
    
    private func bind(view: SuperUserJobView) {
        view.didClickCurrentJob
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] val in
                self?.navigateCurrentJob()
            })
            .store(in: &cancellable)
    }
    
    private func bind(view: SuperUserEducationView) {
        view.didClickHigherEducation
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] val in
                self?.navigateHigerEducation()
            })
            .store(in: &cancellable)
    }
    
}

extension SuperUserCoordinator {
    
    func navigateToJob() {
        pushCoordinator.send(SuperUserCoordinator(type: .job))
    }
    
    func navigateToEducation() {
        pushCoordinator.send(SuperUserCoordinator(type: .education))
    }
    
    func navigateCurrentJob() {
        pushCoordinator.send(SuperUserCoordinator(type: .currentJob))
    }
    
    func navigateHigerEducation() {
        pushCoordinator.send(SuperUserCoordinator(type: .higherEducation))
    }
}
