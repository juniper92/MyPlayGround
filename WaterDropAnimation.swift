//
//  Home.swift
//  SwiftUIView
//
//  Created by Juniper on 2022/02/14.
//

import SwiftUI

struct WaterDropAnimation: View {
    var body: some View {
        
        VStack {
            
            Image(systemName: "humidity.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.cyan)
            
            Text("WaterDrop")
                .fontWeight(.semibold)
                .foregroundColor(.cyan)
            
            // MARK: Wave Form
            GeometryReader { proxy in
                
                let size = proxy.size
                
                ZStack {
                    Image(systemName: "drop.fill")
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.white)
                        .scaleEffect(x: 1.1, y: 1)
                        .offset(y: -1)
                    
                    // Wave form shape
                    WaterWave(progress: 1, waveHeight: 0.1, offset: size.width)
                        .fill(Color.blue)
                    // Water Drops
                        .overlay(content: {
                            ZStack {
                                Circle()
                                    .fill(.white.opacity(0.1))
                                    .frame(width: 15, height: 15)
                                    .offset(x: -20 )
                            }
                        })
                    // Masking into Drop Shape
                        .mask {
                            Image(systemName: "drop.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding(20)
                        }
                }
                .frame(width: size.width, height: size.height, alignment: .center)
            }
            .frame(height: 350)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(.gray)
    }
}

struct WaterDropAnimation_Previews: PreviewProvider {
    static var previews: some View {
        WaterDropAnimation()
    }
}

struct WaterWave: Shape {
    
    var progress: CGFloat
    // 웨이브 높이
    var waveHeight: CGFloat
    // 초기 애니메이션 시작
    var offset: CGFloat
    
    // 애니메이션 사용
    var animationData: CGFloat {
        get {offset}
        set {offset = newValue}
    }
    
    func path(in rect: CGRect) -> Path {
        return Path { path in
            path.move(to: .zero)
            
            let progressHeight: CGFloat = (1 - progress) * rect.height
            let height = waveHeight * rect.height
            
            for value in stride(from: 0, through: rect.width, by: 2) {
                
                let x: CGFloat = value
                let sine: CGFloat = sin(Angle(degrees:value + offset).radians)
                let y: CGFloat = progressHeight + (height * sine)
                
                path.addLine(to: CGPoint(x: x, y: y))
            }
            
            // Bottom Portion
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
        }
    }
}
