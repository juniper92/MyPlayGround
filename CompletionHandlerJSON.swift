//
//  ContentView.swift
//  CompletionHandler+SwiftUI
//
//  Created by Juniper on 2022/02/08.
//

import SwiftUI
import SDWebImageSwiftUI

// MARK: - ContentView
struct CompletionHandlerJSON: View {
    var body: some View {
        
        NavigationView {
            Home()
                .navigationTitle("GitHub Users")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct CompletionHandlerJSON_Previews: PreviewProvider {
    static var previews: some View {
        CompletionHandlerJSON()
    }
}


// MARK: - Home
struct Home: View {
    
    @State var users: [JSONData] = []
    
    var body: some View {
        VStack {
            if users.isEmpty {
                Spacer()
                ProgressView()
                Spacer()
                
            } else {
                // 유저 디스플레이 해주기
                List(users) { user in
                    
                    NavigationLink {
                        DetailView(user: user)
                    } label: {
                        RowView(user: user)
                    }

                }
                .listStyle(InsetGroupedListStyle())
            }
        }
        // 리프레쉬 버튼
        .navigationBarItems(trailing:
                                Button(action: {
            users.removeAll()
            
            getUserData(url: "https://api.github.com/users") { users in
                self.users = users
            }
        }, label: {
            Image(systemName: "arrow.clockwise")
        })
        )
        .onAppear {
            // 유저 데이터 로딩
            getUserData(url: "https://api.github.com/users") { users in
                self.users = users
            }
        }
    }
}


// MARK: - RowView (UserView)
struct RowView: View {
    
    var user: JSONData
    
    var body: some View {
        
        HStack(spacing: 15) {
            AnimatedImage(url: URL(string: user.avatar_url)!)
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .shadow(radius: 4)
            
            Text(user.login)
                .fontWeight(.bold)
                .foregroundColor(.black)
        }
        .padding(.vertical, 5)
    }
}



// MARK: - Detail View
struct DetailView: View {
    var user: JSONData
    @State var followers: [JSONData] = []
    @State var isEmpty = false
    
    var body: some View {
        
        VStack {
            if followers.isEmpty {
                Spacer()
                
                if isEmpty {
                    Text("No Followers")
                        .fontWeight(.bold)
                } else {
                    ProgressView()
                }
                
                Spacer()
            } else {
                // displaying users
                List {
                    // Initial Followers Text
                    Text("Followers")
                    ForEach(followers) { user in
                        RowView(user: user)
                    }
                    .listStyle(InsetGroupedListStyle())
                }
            }
        }
        // setting user name as Nav title
        .navigationTitle(user.login)
        .onAppear {
            // loading user followers data
            getUserData(url: user.followers_url) { followers in
                
                if followers.isEmpty {
                    isEmpty = true
                } else {
                    self.followers = followers
                }
            }
        }
    }
}


// MARK: - Model : JSONData
struct JSONData: Identifiable, Decodable {
    
    var id: Int
    var login: String
    var avatar_url: String
    var followers_url: String
}


// MARK: - FUNCTIONS
// JSON데이터에 대한 completion handler
// 유저 데이터 어레이 번환
func getUserData(url: String, completion: @escaping ([JSONData]) -> ()) {
    
    let session = URLSession(configuration: .default)
    
    session.dataTask(with: URL(string: url)!) { data, _, err in
        
        if err != nil {
            print(err!.localizedDescription)
            return
        }
        
        // JSON 디코딩
        do {
            let users = try JSONDecoder().decode([JSONData].self, from: data!)
            
            // returning users
            completion(users)
            
        } catch {
            print(error)
        }
    }
    .resume()
}

