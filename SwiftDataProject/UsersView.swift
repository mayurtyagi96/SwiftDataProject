//
//  UsersView.swift
//  SwiftDataProject
//
//  Created by Mayur on 17/08/24.
//

import SwiftUI
import SwiftData

struct UsersView: View {
    @Query var users: [User]
    var body: some View {
        List(users){ user in
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
