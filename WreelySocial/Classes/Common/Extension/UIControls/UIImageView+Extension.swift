//
//  UIImageView+Extension.swift
//
//  Created by Tirupati Balan on 30/12/17.
//  Copyright © 2017 Celerstudio. All rights reserved.
//

import Foundation
import UIKit
import CoreImage

extension UIImageView {
    func blurEffect() {
        let currentFilter = CIFilter(name: "CIGaussianBlur")
        let beginImage = CIImage(image: self.image!)
        currentFilter!.setValue(beginImage, forKey: kCIInputImageKey)
        currentFilter!.setValue(10, forKey: kCIInputRadiusKey)
        
        let cropFilter = CIFilter(name: "CICrop")
        cropFilter!.setValue(currentFilter!.outputImage, forKey: kCIInputImageKey)
        cropFilter!.setValue(CIVector(cgRect: beginImage!.extent), forKey: "inputRectangle")
        
        let output = cropFilter!.outputImage
        let cgimg = CIContext(options: nil).createCGImage(output!, from: output!.extent)
        let processedImage = UIImage(cgImage: cgimg!)
        self.image = processedImage
    }
}
