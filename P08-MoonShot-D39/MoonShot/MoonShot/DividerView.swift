//
//  DividerView.swift
//  MoonShot
//
//  Created by Asad Sayeed on 04/04/24.
//

import SwiftUI

// P8-C2: Extract one or two pieces of view code into their own new SwiftUI views – the horizontal scroll view in MissionView is a great candidate, but if you followed my styling then you could also move the Rectangle dividers out too.
struct DividerView: View {
    //Common Properties with default values for creating a rectangle divider which is reusable
    var height: CGFloat = 3
    
    var body: some View {
        //Create a rectangle using the above parameters
        Rectangle()
            .frame(height: height)
            .foregroundStyle(.blue)
            .padding(.vertical)
            
    }
}

#Preview {
    DividerView()
}
