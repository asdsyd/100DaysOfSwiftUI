  //
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Asad Sayeed on 20/11/23.
//

import SwiftUI

struct TitleStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
        .font(.largeTitle)
        .foregroundColor(.blue)
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(TitleStyle())
    }
}

struct ContentView: View {
    let motto1 = Text("Hello there")
    let motto2 = Text("Asad here")
    
    
    var body: some View {
        VStack {
            Text("Made custom View Modifer")
                .titleStyle()
            
            motto1
                .foregroundStyle(.red)
            motto2
                .foregroundStyle(.blue)
        }

    }
}

#Preview {
    ContentView()
}
