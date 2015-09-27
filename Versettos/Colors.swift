//
//  Colors.swift
//  Versettos
//
//  Created by Christian Soler & Eduardo Matos  on 9/25/15.
//  Copyright © 2015 Christian Soler & Eduardo Matos. All rights reserved.
//

import Foundation
import UIKit

class Colors {
    private var colors = [UIColor]()
    
    init(){
        createColors()
    }
    
    func randomColor() -> UIColor {
        return colors[Int(arc4random_uniform(UInt32(colors.count)))]
    }
    
    private func createColors(){
        colors.append(UIColor(red: 90/255.0, green: 187/255.0, blue: 181/255.0, alpha: 1.0))
        colors.append(UIColor(red: 222/255.0, green: 171/255.0, blue: 66/255.0, alpha: 1.0))
        colors.append(UIColor(red: 223/255.0, green: 86/255.0, blue: 94/255.0, alpha: 1.0))
        colors.append(UIColor(red: 239/255.0, green: 130/255.0, blue: 100/255.0, alpha: 1.0))
        colors.append(UIColor(red: 77/255.0, green: 75/255.0, blue: 82/255.0, alpha: 1.0))
        colors.append(UIColor(red: 105/255.0, green: 94/255.0, blue: 133/255.0, alpha: 1.0))
        colors.append(UIColor(red: 85/255.0, green: 176/255.0, blue: 112/255.0, alpha: 1.0))
        
        colors.append(UIColor(red: 143/255.0, green: 190/255.0, blue: 86/255.0, alpha: 1.0))
        colors.append(UIColor(red: 76/255.0, green: 90/255.0, blue: 206/255.0, alpha: 1.0))
        
        colors.append(UIColor(red: 26/255.0, green: 188/255.0, blue: 156/255.0, alpha: 1.0))
        colors.append(UIColor(red: 46/255.0, green: 204/255.0, blue: 113/255.0, alpha: 1.0))
        colors.append(UIColor(red: 52/255.0, green: 152/255.0, blue: 219/255.0, alpha: 1.0))
        colors.append(UIColor(red: 155/255.0, green: 89/255.0, blue: 182/255.0, alpha: 1.0))
        colors.append(UIColor(red: 52/255.0, green: 73/255.0, blue: 94/255.0, alpha: 1.0))
        colors.append(UIColor(red: 241/255.0, green: 196/255.0, blue: 15/255.0, alpha: 1.0))
        colors.append(UIColor(red: 230/255.0, green: 126/255.0, blue: 34/255.0, alpha: 1.0))
        colors.append(UIColor(red: 231/255.0, green: 76/255.0, blue: 60/255.0, alpha: 1.0))
    }
}