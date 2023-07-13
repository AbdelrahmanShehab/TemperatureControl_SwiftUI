//
//  TemperatureControlView.swift
//  TemperatureAdjustable
//
//  Created by Abdelrahman Shehab on 13/07/2023.
//

import SwiftUI

struct TemperatureControlView: View {
    // MARK: -  PROPERTIES
    @Binding var temperatureValue: CGFloat
    @State var angleValue: CGFloat = 0.0
    let config = Config(minimumValue: 0.0,
                        maximumValue: 100.0,
                        totalValue: 100.0,
                        knobRadius: 15.0,
                        radius: 125.0)
    
    // MARK: -  FUNCTIONS
    
    private func change(location: CGPoint) {
        // Creating vector from location point
        let vector = CGVector(dx: location.x, dy: location.y)
        
        // Getting angle in radian need to substract the knob radius and padding from the dy and dx
        let angle = atan2(vector.dy - (config.knobRadius + 10), vector.dx - (config.knobRadius + 10)) + .pi / 2.0
        
        // Convert angle range from (-pi to pi) to (0 to 2pi)
        let fixedAngle = angle < 0.0 ? angle + 2.0 * .pi : angle
        // Convert angle value to temperatue value
        let value = fixedAngle / (2.0 * .pi) * config.totalValue
        if value >= config.minimumValue && value <= config.maximumValue {
            temperatureValue = value
            angleValue = fixedAngle * 180 / .pi // Converting to degree
        }
        
    }
    // MARK: -  BODY
    var body: some View {
        ZStack {
            Circle()
                .frame(width: config.radius * 2, height: config.radius * 2)
                .scaleEffect(1.2)
            
            Circle()
                .stroke(
                    Color.gray,
                    style: StrokeStyle(lineWidth: 3, lineCap: .butt, dash: [3, 23.18])
                )
                .frame(width: config.radius * 2, height: config.radius * 2)
            
            Circle()
                .trim(from: 0.0, to: temperatureValue / config.totalValue)
                .stroke(ColorMix.colorMix(percent: Int(temperatureValue)), lineWidth: 4)
                .frame(width: config.radius * 2, height: config.radius * 2)
                .rotationEffect(.degrees(-90))
            
            Circle()
                .fill(ColorMix.colorMix(percent: Int(temperatureValue)))
                .frame(width: config.knobRadius * 2, height: config.knobRadius * 2)
                .padding(10)
                .offset(y: -config.radius)
                .rotationEffect(Angle.degrees(Double(angleValue)))
                .gesture(
                    DragGesture(minimumDistance: 0.0)
                        .onChanged({ value in
                            change(location: value.location)
                        })
                )
            
            Text("\(String.init(format: "%.0f", temperatureValue))º")
                .font(.system(size: 60))
                .foregroundColor(.white)
//                .foregroundColor(ColorMix.colorMix(percent: Int(temperatureValue)))
            
        }//: ZSTACK
    }
}

struct TemperatureControlView_Previews: PreviewProvider {
    @State static var value: CGFloat = 20
    static var previews: some View {
        TemperatureControlView(temperatureValue: $value)
    }
}
