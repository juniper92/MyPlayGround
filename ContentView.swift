//
//  ContentView.swift
//  Alamofire+SwiftUI
//
//  Created by Juniper on 2022/02/08.
//

import SwiftUI
import SDWebImageSwiftUI
import Alamofire
import SwiftyJSON

struct ContentView: View {
    
    @ObservedObject var obs = observer()
    
    var body: some View {
        
        NavigationView {
            List(obs.datas) { i in
                
                Card(name: i.name, url: i.url)
            }
            .navigationTitle("JSON")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

class observer: ObservableObject {
    
    @Published var datas = [datatype]()
    
    init() {
        AF.request("https://api.github.com/users/hadley/orgs").responseData { data in
            
            let json = try! JSON(data: data.data!)
            
            for i in json {
                
                self.datas.append(datatype(id: i.1["id"].intValue, name: i.1["login"].stringValue, url: i.1["avatar_url"].stringValue))
            }
        }
    }
}


// 여기서 0은 json의 인덱스 수를 나타낸다
// 1은 각 인덱스의 json 데이터를 나타낸다
struct datatype: Identifiable {
    
    var id: Int
    var name: String
    var url: String
}


struct Card: View {
    
    var name = ""
    var url = ""
    
    var body: some View {
        
        HStack {
            AnimatedImage(url: URL(string: url)!)
                .resizable()
                .frame(width: 60, height: 60)
                .cornerRadius(60)
            
            Text(name).fontWeight(.heavy)
            
        }
    }
}
