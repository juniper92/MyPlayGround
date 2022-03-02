//
//  Home.swift
//  SwiftUIViews
//
//  Created by Juniper on 2022/03/02.
//

import SwiftUI

// MARK: - ContentView
struct ContentView: View {
    var body: some View {
        Home()
            .buttonStyle(BorderlessButtonStyle())
            .textFieldStyle(PlainTextFieldStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
    }
}


// MARK: - Model & SampleData
// Note Model and Sample Notes

struct Note: Identifiable {
    var id = UUID().uuidString
    var note: String
    var date: Date
    var cardColor: Color
}

// Sample Dates
func getSampleDate(offset: Int) -> Date {
    let calendar = Calendar.current
    
    let date = calendar.date(byAdding: .day, value: offset, to: Date())
    
    return date ?? Date()
}

var notes : [Note] = [
    Note(note: "The biginning of screenless design UI jobs to be taken", date: getSampleDate(offset: 1), cardColor: Color.Palette.TitleGreen),
    Note(note: "2222222222222222222222222222222", date: getSampleDate(offset: -10), cardColor: Color.Palette.Mint),
    Note(note: "333333333333333333", date: getSampleDate(offset: 15), cardColor: Color.Palette.Pink),
    Note(note: "4444444444444444444444444", date: getSampleDate(offset: 10), cardColor: Color.Palette.DarkGreen)
]


// MARK: - HomeView 
struct Home: View {
    
    // Showing Card Colors on Button Click
    @State var showColors: Bool = false
    
    // Button Animation
    @State var animateButton: Bool = false
    
    var body: some View {
        HStack(spacing: 0) {
            MainContent()
        }
        .frame(alignment: .leading)
        .background(Color.white.ignoresSafeArea())
        .overlay(SiceBar())
        .preferredColorScheme(.light)
    }
    
    @ViewBuilder
    func MainContent() -> some View {
        VStack(spacing: 15) {
            
            // Search Bar
            HStack(spacing: 10) {
                Image(systemName: "magnifyingglass")
                    .font(.title3)
                    .foregroundColor(.gray)
                
                TextField("Search", text: .constant(""))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 10)
            .overlay(
                Rectangle()
                    .fill(Color.gray.opacity(0.15))
                    .frame(height: 1)
                    .padding(.horizontal, -25)
                // Moving offset 6
                    .offset(y: 6)
                    .opacity(1)
                ,
                
                alignment: .bottom
            )
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 15) {
                    Text("Notes")
                        .font(.largeTitle.bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // Columns
                    let columns = Array(repeating: GridItem(.flexible(),spacing: 15), count: 1)
                    
                    LazyVGrid(columns: columns, spacing: 25) {
                        
                        // Notes
                        ForEach(notes) { note in
                            // Card View
                            CardView(note: note)
                        }
                    }
                    .padding(.top, 30)
                }
                .padding(.top, 30)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.top, 15)
        .padding(.horizontal, 25)
    }
    
    @ViewBuilder
    func CardView(note: Note) -> some View {
        VStack {
            Text(note.note)
                .font(.body)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                Text(note.date, style: .date)
                    .foregroundColor(.black)
                    .opacity(0.8)
                
                Spacer(minLength: 0)
                
                // Edit Button
                Button {
                    
                } label: {
                    Image(systemName: "pencil")
                        .font(.system(size: 15, weight: .bold))
                        .padding(8)
                        .foregroundColor(.white)
                        .background(Color.black)
                        .clipShape(Circle())
                }

            }
            .padding(.top, 55)
        }
        .padding()
        .background(note.cardColor)
        .cornerRadius(15)
    }
    
    @ViewBuilder
    func SiceBar() -> some View {
        VStack {
//            Text("Pocket")
//                .font(.title2)
//                .fontWeight(.semibold)
            
//            AddButton()
//                .zIndex(1)
            
            VStack(spacing: 15) {
                
                let colors =
                [Color.Palette.TitleGreen, Color.Palette.Blue, Color.Palette.Pink, Color.Palette.Mint]
                
                ForEach(colors, id: \.self) { color in
                    Circle()
                        .fill(color)
                        .frame(width: 25, height: 25)
                }
                
            }
            .padding(.top, 20)
            .frame(height: showColors ? nil : 0)
            .opacity(showColors ? 1 : 0)
            .zIndex(0)
            
            AddButton()
                .zIndex(1)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
        .padding()
        // Blur View
        .background(
            BlurView(style: .systemUltraThinMaterialDark)
                .opacity(showColors ? 1 : 0)
                .ignoresSafeArea()
        )
        
    }
    
    @ViewBuilder
    func AddButton() -> some View {
        Button {
            withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)) {
                showColors.toggle()
                animateButton.toggle()
            }
            
            // Resetting the button
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(.spring()) {
                    animateButton.toggle()
                }
            }
        } label: {
            Image(systemName: "plus")
                .font(.title2)
                .scaleEffect(animateButton ? 1.1 : 1)
                .foregroundColor(.white)
                .padding(15)
                .background(Color.black)
                .clipShape(Circle())
        }
        .rotationEffect(.init(degrees: showColors ? 45 : 0))
        .scaleEffect(animateButton ? 1.1 : 1)
        .padding()

    }
}



struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            .preferredColorScheme(.light)
    }
}

// MARK: - Extensions
// Extending View to get Frame and ggetting devide os types
extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
}

extension Color {
    struct Palette {
        static var Blue: Color {
            return Color("Blue")
        }
        
        static var Mint: Color {
            return Color("Mint")
        }
        
        static var LightGreen: Color {
            return Color("LightGreen")
        }
        
        static var Pink: Color {
            return Color("Pink")
        }
        
        static var DarkGreen: Color {
            return Color("DarkGreen")
        }
        
        static var TitleGreen: Color {
            return Color("Title")
        }
    }
}



// MARK: - BlurView
// Since App Supports iOS 14
struct BlurView: UIViewRepresentable {
    
    var style: UIBlurEffect.Style
    func makeUIView(context: Context) -> UIVisualEffectView {
     
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
        
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        
    }
}


