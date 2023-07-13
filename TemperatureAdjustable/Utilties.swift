//
//  Utilties.swift
//  TemperatureAdjustable
//
//  Created by Abdelrahman Shehab on 13/07/2023.
//

import SwiftUI

struct ColorMix {
    static func colorMix(percent: Int) -> Color {
        let p = Double(percent)
        let tempB = (100.0 - p) / 100
        let b: Double = tempB < 0 ? 0 : tempB
        let tempR = 1 + (p - 100.0) / 100
        let r: Double = tempR < 0 ? 0 : tempR
        return Color.init(red: r, green: 0, blue: b)
    }
}
