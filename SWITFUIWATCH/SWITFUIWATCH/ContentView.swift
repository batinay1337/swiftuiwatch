//
//  ContentView.swift
//  SWITFUIWATCH
//
//  Created by Batınay Ünsel on 16.09.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        VStack {
            Watch()
                .padding(.bottom, 150)
            
            Text("Thanks for using SWIFTUIWATCH!")
                .padding(.bottom, 250)
            
            

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
