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
    @AppStorage("userNo") var user = 1
    
    var body: some View {
        NavigationStack(){
            UsersView(minimumJoiningDate: futureJoining ? .now : .distantPast, sortOrder: sortOrder)
            .navigationTitle("Users")
            .navigationBarTitleDisplayMode(.large)
            .toolbar{
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button("Add sample user", systemImage: "plus") {
                        addSampleUserAndJobs()
                    }
                    Button("Delete all user", systemImage: "trash") {
                        deleteAllUsers()
                    }
                }
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button(futureJoining ? "All Joinings" : "Future Joinings"){
                        futureJoining.toggle()
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
    }
    
    func deleteAllUsers(){
        try? modelContext.delete(model: User.self)
        user = 1
    }
    
    func deleteAllJobs(){
        try? modelContext.delete(model: Job.self)
    }
    
    func addSampleUserAndJobs(){
        let user1 = User(name: "user\(user)", city: "agra", joinDate: .now.addingTimeInterval(86400 * -10))
        let job1 = Job(name: "Chudha", priority: 1)
        let job2 = Job(name: "Mistri", priority: 2)
       
        modelContext.insert(user1)
        user += 1
        
        if user % 2 == 0{
            user1.job?.append(job1)
            user1.job?.append(job2)
            user1.joiningDate = .now.addingTimeInterval(86400 * 10)
        }
        
    }
}

#Preview {
    ContentView()
}
