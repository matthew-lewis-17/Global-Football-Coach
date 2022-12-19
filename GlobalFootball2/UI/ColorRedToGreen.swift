//
//  ColorRedToGreen.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 7/31/22.
//

import Foundation
import UIKit

func mixGreenAndRed(greenAmount: CGFloat) -> UIColor {
    let finalGreen = (greenAmount / 100)
    // the hues between red and green go from 0…1/3, so we can just divide percentageGreen by 3 to mix between them
    return UIColor(hue: finalGreen / 3, saturation: 1.0, brightness: 1.0, alpha: 1.0)
}
