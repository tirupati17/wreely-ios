//
//  UIImage+Extension.swift
//  UserExperior
//
//  Created by Tirupati Balan on 17/11/18.
//  Copyright © 2018 UserExperior. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }

    func jpeg(_ jpegQuality: JPEGQuality) -> Data? {
        return self.jpegData(compressionQuality: jpegQuality.rawValue)
    }
    
    func resized(toWidth width: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer {
            UIGraphicsEndImageContext()
        }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
