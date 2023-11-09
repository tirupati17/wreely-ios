//
//  UIWindow+Extension.swift
//  UserExperior
//
//  Created by Tirupati Balan on 17/11/18.
//  Copyright © 2018 UserExperior. All rights reserved.
//

import Foundation
import UIKit

extension UIWindow {
    
    func captureScreen() -> UIImage? {
        /*
         Description =>
         Creates a bitmap-based graphics context with the specified options.
         You use this function to configure the drawing environment for rendering into a bitmap. The format for the bitmap is a ARGB 32-bit integer pixel format using host-byte order. If the opaque parameter is true, the alpha channel is ignored and the bitmap is treated as fully opaque (noneSkipFirst | kCGBitmapByteOrder32Host). Otherwise, each pixel uses a premultipled ARGB format (premultipliedFirst | kCGBitmapByteOrder32Host).
         
         This function may be called from any thread of your app.
         
         Parameter =>
         
         size:
         The size (measured in points) of the new bitmap context. This represents the size of the image returned by the UIGraphicsGetImageFromCurrentImageContext() function. To get the size of the bitmap in pixels, you must multiply the width and height values by the value in the scale parameter.
         
         opaque:
         A Boolean flag indicating whether the bitmap is opaque. If you know the bitmap is fully opaque, specify true to ignore the alpha channel and optimize the bitmap’s storage. Specifying false means that the bitmap must include an alpha channel to handle any partially transparent pixels.
         
         scale:
         The scale factor to apply to the bitmap. If you specify a value of 0.0, the scale factor is set to the scale factor of the device’s main screen.
         
         */
        
        UIGraphicsBeginImageContextWithOptions(self.frame.size, self.isOpaque, 0.0)

        /*
         Returns the current graphics context.
         
         Description =>
         The current graphics context is nil by default. Prior to calling its drawRect: method, view objects push a valid context onto the stack, making it current. If you are not using a UIView object to do your drawing, however, you must push a valid context onto the stack manually using the UIGraphicsPushContext(_:) function.
         
         This function may be called from any thread of your app.
         */
        
        self.layer.render(in: UIGraphicsGetCurrentContext()!)

        /*
         Returns an image based on the contents of the current bitmap-based graphics context.
         
         Description =>
         You should call this function only when a bitmap-based graphics context is the current graphics context. If the current context is nil or was not created by a call to UIGraphicsBeginImageContext(_:), this function returns nil.
         
         This function may be called from any thread of your app.
         */
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        /*
         Removes the current bitmap-based graphics context from the top of the stack.
         
         Description =>
         You use this function to clean up the drawing environment put in place by the UIGraphicsBeginImageContext(_:) function and to remove the corresponding bitmap-based graphics context from the top of the stack. If the current context was not created using the UIGraphicsBeginImageContext(_:) function, this function does nothing.
         
         This function may be called from any thread of your app.
         */
        
        UIGraphicsEndImageContext()
        return image;
    }
    
}
