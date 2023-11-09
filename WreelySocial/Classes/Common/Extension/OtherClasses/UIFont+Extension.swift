//
//  UIFont+Extension.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 21/05/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {

    class func getAppMediumFont(size:CGFloat) -> UIFont {
        return UIFont.init(name: WSConstant.AppCustomFontMedium, size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    class func getAppRegularFont(size:CGFloat) -> UIFont {
        return UIFont.init(name: WSConstant.AppCustomFontRegular, size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    class func getAppBoldFont(size:CGFloat) -> UIFont {
        return UIFont.init(name: WSConstant.AppCustomFontBold, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
