//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Asad Sayeed on 08/05/24.
//

import SwiftUI

// P18-C3: For a real challenge make the views change color as you scroll. For the best effect, you should create colors using the Color(hue:saturation:brightness:) initializer, feeding in varying values for the hue.

struct ContentView: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]

    var body: some View {
        GeometryReader { fullView in
            ScrollView(.vertical) {
                ForEach(0..<50) { index in
                    GeometryReader { proxy in
                        // First, put your ContentView back to the spinning color rows example we had:
                        // P18-C1: Make views near the top of the scroll view fade out to 0 opacity – I would suggest starting at about 200 points from the top.
                        let minY = proxy.frame(in: .global).minY
                        // P18-C2: Make views adjust their scale depending on their vertical position, with views near the bottom being large and views near the top being small. I would suggest going no smaller than 50% of the regular size.
                        let height = fullView.size.height
                        let scale = min(max(minY / height, 0.65), 1.0)
                        let opacity = minY < 200 ? minY / 200 : 1
                        
                        Text("Row #\(index)")
                            .font(.title)
                            .frame(maxWidth: .infinity)
                            .background(colors[index % 7])
                            .rotation3DEffect(.degrees(minY - fullView.size.height / 2) / 5, axis: (x: 0, y: 1, z: 0))
                            .scaleEffect(scale)
                            .opacity(minY < 200 ? minY / 200 : 1)
                    }
                    .frame(height: 40)
                }
            }
        }
    }
}

//struct ContentView: View {
//    
//    var body: some View {
//        ScrollView(.horizontal, showsIndicators: false) {
//            HStack(spacing: 0) {
//                ForEach(1..<20) { number in
//                        Text("Number \(number)")
//                            .font(.largeTitle)
//                            .padding()
//                            .background(.red)
//                            .frame(width: 200, height: 200)
//                            .visualEffect { content, geometryProxy in
//                                content
//                                    .rotation3DEffect(
//                                        .degrees(-geometryProxy.frame(in: .global).minX / 8),
//                                        axis: (x: 0, y: 1, z: 0)
//                                    )
//                            }
//                }
//            }
//            .scrollTargetLayout()
//        }
//        .scrollTargetBehavior(.viewAligned)
//    }
//}

#Preview {
    ContentView()
}
