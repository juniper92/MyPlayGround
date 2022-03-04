//
//  ContentView.swift
//  CustomVideoPlayer
//
//  Created by Juniper on 2022/03/04.
//

import SwiftUI
import AVKit

struct ContentView: View {
    
    var body: some View {
        
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}

struct Home: View {
    
    @State var index = 0
    @State var top = 0
    @State var data = [
        Video(id: 0, player: AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "cat", ofType: "mp4")!)), replay: false),
        Video(id: 1, player: AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "cock", ofType: "mp4")!)), replay: false),
        Video(id: 2, player: AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "graphic", ofType: "mp4")!)), replay: false),
        Video(id: 3, player: AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "owl", ofType: "mp4")!)), replay: false),
        Video(id: 4, player: AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "sea", ofType: "mp4")!)), replay: false)
    ]
    
    var body: some View {
        
        ZStack {
            
            PlayerScrollView(data: self.$data)
            
            VStack {
                
                HStack(spacing: 15) {
                    Button {
                        self.top = 0
                    } label: {
                        Text("Following")
                            .foregroundColor(self.top == 0 ? .white : Color.white.opacity(0.3))
                            .fontWeight(self.top == 0 ? .bold : .none)
                            .padding(.vertical)
                    }
                    
                    Button {
                        self.top = 1
                    } label: {
                        Text("Fore You")
                            .foregroundColor(self.top == 1 ? .white : Color.white.opacity(0.3))
                            .fontWeight(self.top == 1 ? .bold : .none)
                            .padding(.vertical)
                    }

                }
                
                Spacer()
                
                HStack {
                    
                    Spacer()
                    
                    VStack(spacing: 35) {
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "photo.circle")
                                .renderingMode(.original)
                                .resizable()
                                .frame(width: 55, height: 55)
                        }
                        
                        Button {
                            
                        } label: {
                            VStack(spacing: 8) {
                                Image(systemName: "heart.fill")
                                    .font(.title)
                                    .foregroundColor(.white)
                                
                                Text("22K")
                                    .foregroundColor(.white)
                            }
                        }
                        
                        Button {
                            
                        } label: {
                            VStack(spacing: 8) {
                                Image(systemName: "message.fill")
                                    .font(.title)
                                    .foregroundColor(.white)
                                
                                Text("1021")
                                    .foregroundColor(.white)
                            }
                        }
                        
                        Button {
                            
                        } label: {
                            VStack(spacing: 8) {
                                Image(systemName: "arrowshape.turn.up.right.circle")
                                    .font(.title)
                                    .foregroundColor(.white)
                                
                                Text("share")
                                    .foregroundColor(.white)
                            }
                        }
                        

                    }
                    .padding(.bottom, 55)
                    .padding(.trailing)
                }
                
                HStack(spacing: 0) {
                    Button {
                        self.index = 0
                    } label: {
                        Image(systemName: "house")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(self.index == 0 ? .white : Color.white.opacity(0.3))
                            .padding(.horizontal)
                    }
                    
                    Spacer(minLength: 0)
                    
                    Button {
                        self.index = 1
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(self.index == 1 ? .white : Color.white.opacity(0.3))
                            .padding(.horizontal)
                    }
                    
                    Spacer(minLength: 0)

                    Button {
                    } label: {
                        Image(systemName: "square.and.arrow.up.fill")
                            .renderingMode(.original)
                            .resizable()
                            .frame(width: 35, height: 35)
                            .padding(.horizontal)
                    }
                    
                    Spacer(minLength: 0)

                    Button {
                        self.index = 2
                    } label: {
                        Image(systemName: "bubble.right")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(self.index == 2 ? .white : Color.white.opacity(0.3))
                            .padding(.horizontal)
                    }
                    
                    Spacer(minLength: 0)

                    Button {
                        self.index = 3
                    } label: {
                        Image(systemName: "person.fill")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(self.index == 3 ? .white : Color.white.opacity(0.3))
                            .padding(.horizontal)
                    }


                }
                .padding(.horizontal)
            }
            // due to all edges are ignored
            .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
            .padding(.bottom, (UIApplication.shared.windows.first?.safeAreaInsets.bottom)! + 5)
        }
        .background(Color.black.ignoresSafeArea(.all))
        .edgesIgnoringSafeArea(.all)
    }
}


struct PlayerView: View {
    
    @Binding var data: [Video]
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<self.data.count) { i in
                
                ZStack {
                    Player(player: self.data[i].player)
                    // full screensize because were going to make paging
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .offset(y: -5)
                    
                    if self.data[i].replay {
                        Button {
                            // playing the video again
                            self.data[i].replay
                            self.data[i].player.seek(to: .zero)
                            self.data[i].player.play()
                        } label: {
                            Image(systemName: "goforward")
                                .resizable()
                                .frame(width: 55, height: 60)
                                .foregroundColor(.white)
                        }
                    }
                }
            }
        }
        .onAppear {
            
            // doing it for first video because scrollview didnt dragged yet
            
            self.data[0].player.play()
            
            self.data[0].player.actionAtItemEnd = .none
            
            NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.data[0].player.currentItem, queue: .main) { (_) in
                
                // notification to identify at the end of the video
                
                // enabling replay button
                self.data[0].replay = true
            }
        }
    }
}


struct Player: UIViewControllerRepresentable {
    
    var player: AVPlayer
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let view = AVPlayerViewController()
        view.player = player
        view.showsPlaybackControls = false
        view.videoGravity = .resizeAspectFill
        return view
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        
    }
}


class Host: UIHostingController<ContentView> {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}


// sample video for video playing
struct Video: Identifiable {
    var id: Int
    var player: AVPlayer
    var replay: Bool
}

struct PlayerScrollView: UIViewRepresentable {
    func makeCoordinator() -> Coordinator {
        return PlayerScrollView.Coordinator(parent1: self)
    }
    
    
    @Binding var data: [Video]
    
    func makeUIView(context: Context) -> UIScrollView {
        let view = UIScrollView()
        let childView = UIHostingController(rootView: PlayerView(data: self.$data))
        
        // each children occupies one full screen so height = count * height of screen
        childView.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * CGFloat((data.count)))
        // same here
        view.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * CGFloat((data.count)))
        
        view.addSubview(childView.view)
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        
        // to ignore safe area
        view.contentInsetAdjustmentBehavior = .never
        view.isPagingEnabled = true
        view.delegate = context.coordinator
        
        return view
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        
        // to dynamically update height based on data
        uiView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * CGFloat((data.count)))
        
        for i in 0..<uiView.subviews.count {
            uiView.subviews[i].frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * CGFloat((data.count)))
        }
    }
    
    class Coordinator: NSObject, UIScrollViewDelegate {
        
        var parent: PlayerScrollView
        var index = 0
        
        init(parent1: PlayerScrollView) {
            parent = parent1
        }
        
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            let currentindex = Int(scrollView.contentOffset.y / UIScreen.main.bounds.height)
            print(index)
            
            if index != currentindex {
                index = currentindex
                
                for i in 0..<parent.data.count {
                    
                    // pausing all other videos...
                    parent.data[i].player.seek(to: .zero)
                    parent.data[i].player.pause()
                }
                
                // playing next video
                parent.data[index].player.play()
                
                parent.data[index].player.actionAtItemEnd = .none
                
                NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: parent.data[index].player.currentItem, queue: .main) { (_) in
                    
                    // notification to identify at the end of the video
                    
                    // enabling replay button
                    self.parent.data[self.index].replay = true
                }
            }
        }
    }
}

// my graphics performance is low

