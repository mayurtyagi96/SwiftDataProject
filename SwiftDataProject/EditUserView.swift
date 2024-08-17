//
//  EditUserView.swift
//  SwiftDataProject
//
//  Created by Mayur on 17/08/24.
//

import SwiftUI
import SwiftData

struct EditUserView: View {
    @Bindable var user: User
    
    var body: some View {
        Form{
            TextField("Enter user's name", text: $user.name)
            TextField("Enter user's city", text: $user.city)
            DatePicker("Joining Date", selection: $user.joiningDate)
        }
        .navigationTitle("Edit User")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    do{
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: User.self, configurations: config)
        let user = User(name: "Mayur", city: "Gurugram", joinDate: Date.now)
        return EditUserView(user: user)
            .modelContainer(container)
    }catch{
        return Text("Switf data error \(error.localizedDescription)")
    }
}
