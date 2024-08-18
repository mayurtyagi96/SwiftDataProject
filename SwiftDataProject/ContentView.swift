//
//  ContentView.swift
//  SwiftDataProject
//
//  Created by Mayur on 17/08/24.
//
import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var futureJoining = false
    @State private var sortOrder = [
        SortDescriptor(\User.name),
        SortDescriptor(\User.joiningDate)
    ]
    
    var body: some View {
        NavigationStack(){
            UsersView(minimumJoiningDate: futureJoining ? .now : .distantPast, sortOrder: sortOrder)
            .navigationTitle("Users")
            .toolbar{
                Button(futureJoining ? "All Joinings" : "Future Joinings"){
                    futureJoining.toggle()
                }
                Button("Add sample user", systemImage: "plus") {
                    addSampleUserAndJobs()
//                    addSampleUserAndJobs()
//                    try? modelContext.delete(model: User.self)
//                    let first = User(name: "Ed Sheeran", city: "London", joinDate: .now.addingTimeInterval(86400 * -10))
//                               let second = User(name: "Rosa Diaz", city: "New York", joinDate: .now.addingTimeInterval(86400 * -5))
//                               let third = User(name: "Roy Kent", city: "London", joinDate: .now.addingTimeInterval(86400 * 5))
//                               let fourth = User(name: "Johnny English", city: "London", joinDate: .now.addingTimeInterval(86400 * 10))
//
//                               modelContext.insert(first)
//                               modelContext.insert(second)
//                               modelContext.insert(third)
//                               modelContext.insert(fourth)
                }
                Menu("Sort", systemImage: "arrow.up.arrow.down"){
                    Picker("Sort", selection: $sortOrder) {
                        Text("Sort by Name")
                            .tag([
                                SortDescriptor(\User.name),
                                SortDescriptor(\User.joiningDate)
                            ])
                        Text("Sort by Joining date")
                            .tag([
                                SortDescriptor(\User.joiningDate),
                                SortDescriptor(\User.name)
                            ])
                    }
                }
            }
            
        }
    }
    func deleteAllUsers(){
        try? modelContext.delete(model: User.self)
    }
    func deleteAllJobs(){
        try? modelContext.delete(model: Job.self)
    }
    func addSampleUserAndJobs(){
        let user1 = User(name: "user2", city: "agra", joinDate: .now)
        let job1 = Job(name: "Chudha", priority: 1)
        let job2 = Job(name: "Mistri", priority: 2)
       
        modelContext.insert(user1)
        user1.job?.append(job1)
        user1.job?.append(job2)
    }
}

#Preview {
    ContentView()
}
