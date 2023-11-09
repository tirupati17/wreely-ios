//
//  MessageBubbleView.swift
//
//  Created by Tirupati Balan on 20/05/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

//Ref : https://github.com/khaptonstall/ios-message-bubble-demo/tree/finished-project

import Foundation
import UIKit

class MessageBubbleView: UIView {
    var currentUserIsSender = true {
        didSet {
            setNeedsDisplay()
        }
    }

    override func draw(_ rect: CGRect) {
        let bezierPath = UIBezierPath()
        
        //Draw main body
        bezierPath.move(to: CGPoint(x: rect.minX, y: rect.minY))
        bezierPath.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        bezierPath.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - 10.0))
        bezierPath.addLine(to: CGPoint(x: rect.minX, y: rect.maxY - 10.0))
        bezierPath.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        
        //Draw the tail
        if currentUserIsSender {
            bezierPath.move(to: CGPoint(x: rect.maxX - 25.0, y: rect.maxY - 10.0))
            bezierPath.addLine(to: CGPoint(x: rect.maxX - 10.0, y: rect.maxY))
            bezierPath.addLine(to: CGPoint(x: rect.maxX - 10.0, y: rect.maxY - 10.0))
            UIColor.init(white: 0.98, alpha: 1).setFill()
        } else {
            bezierPath.move(to: CGPoint(x: rect.minX + 25.0, y: rect.maxY - 10.0))
            bezierPath.addLine(to: CGPoint(x: rect.minX + 10.0, y: rect.maxY))
            bezierPath.addLine(to: CGPoint(x: rect.minX + 10.0, y: rect.maxY - 10.0))
            UIColor.init(white: 0.95, alpha: 1).setFill()
        }
        
        bezierPath.fill()
        bezierPath.close()
    }
}
