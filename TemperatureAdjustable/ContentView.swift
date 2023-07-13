//
//  ContentView.swift
//  TemperatureAdjustable
//
//  Created by Abdelrahman Shehab on 13/07/2023.
//

import SwiftUI

struct ContentView: View {
    @State var temp: CGFloat = 0
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(ColorMix.colorMix(percent: Int(temp)))
                .opacity(0.7)
                .edgesIgnoringSafeArea(.all)
            
            TemperatureControlView(temperatureValue: $temp)
        }//: ZSTACK
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
