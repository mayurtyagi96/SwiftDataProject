//
//  EditUserView.swift
//  SwiftDataProject
//
//  Created by Mayur on 17/08/24.
//

import SwiftUI
import SwiftData

struct EditUserView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    var user: User
    @State private var userName: String = ""
    @State private var userCity: String = ""
    @State private var userJoinDate: Date = .now
    
    var body: some View {
        Form{
            TextField("Enter user's name", text: $userName)
            TextField("Enter user's city", text: $userCity)
            DatePicker("Joining Date", selection: $userJoinDate)
        }
        .toolbar{
            Button("delete", systemImage: "trash", action: deleteUser)
            Button("Save", action: save)
        }
        .navigationTitle("Edit User")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func deleteUser(){
        modelContext.delete(user)
        dismiss()
    }
    
    func save(){
        user.name = userName
        user.city = userCity
        user.joiningDate = userJoinDate
        dismiss()
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
