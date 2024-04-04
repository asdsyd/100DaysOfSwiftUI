//
//  DividerView.swift
//  MoonShot
//
//  Created by Asad Sayeed on 04/04/24.
//

import SwiftUI

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
