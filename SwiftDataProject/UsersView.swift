//
//  UsersView.swift
//  SwiftDataProject
//
//  Created by Mayur on 17/08/24.
//

import SwiftUI
import SwiftData

struct UsersView: View {
    @Environment(\.modelContext) var modelContext
    @Query var users: [User]
    var body: some View {
        List(){
            ForEach(users){ user in
                NavigationLink(value: user){
                    HStack{
                        Text(user.name)
                        Spacer()
                        Text(String(user.unrappedJob.count))
                            .fontWeight(.black)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(.blue)
                            .foregroundStyle(.white)
                            .clipShape(.capsule)
                    }
                }
            }
            .onDelete { indexSet in
                for index in indexSet{
                    modelContext.delete(users[index])
                }
            }
        }
        .navigationDestination(for: User.self) { user in
            EditUserView(user: user)
        }
    }
    
    init(minimumJoiningDate: Date, sortOrder: [SortDescriptor<User>]) {
        _users = Query(filter: #Predicate<User>{ user in
            user.joiningDate >= minimumJoiningDate
        }, sort: sortOrder)
    }
}

#Preview {
    UsersView(minimumJoiningDate: .now, sortOrder: [SortDescriptor(\User.name)])
        .modelContainer(for: User.self)
}
