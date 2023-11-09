//
//  UIColor+Extension.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 11/05/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    static func rgb(_ red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    class func themeColor() -> UIColor {
        return isPlayce ? UIColor.playceThemeColor() : UIColor.workloftThemeColor()
        //return UIColor.init(red: 0/255, green: 136/255, blue: 216/255, alpha: 1)
    }
    
    class func playceThemeColor() -> UIColor {
        return UIColor.init(red: 210/255, green: 0/255, blue: 0/255, alpha: 1)
    }
    
    class func workloftThemeColor() -> UIColor {
        return UIColor.init(red: 245/255, green: 115/255, blue: 0/255, alpha: 1)
    }
    
    class func whatsappSendCellColor() -> UIColor {
        return UIColor.init(red: 210/255, green: 253/255, blue: 198/255, alpha: 1)
    }
    
    class func getColorFromRGB(_ rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    class func generateRandomPastelColor(withMixedColor mixColor: UIColor? = nil) -> UIColor {
        // Randomly generate number in closure
        let randomColorGenerator = { ()-> CGFloat in
            CGFloat(arc4random() % 256 ) / 256
        }
        
        var red: CGFloat = randomColorGenerator()
        var green: CGFloat = randomColorGenerator()
        var blue: CGFloat = randomColorGenerator()
        
        // Mix the color
        if let mixColor = mixColor {
            var mixRed: CGFloat = 0, mixGreen: CGFloat = 0, mixBlue: CGFloat = 0;
            mixColor.getRed(&mixRed, green: &mixGreen, blue: &mixBlue, alpha: nil)
            
            red = (red + mixRed) / 2;
            green = (green + mixGreen) / 2;
            blue = (blue + mixBlue) / 2;
        }
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    
}
