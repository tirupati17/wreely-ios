//
//  UIView+Extension.swift
//
//  Created by Tirupati Balan on 30/12/17.
//  Copyright © 2017 Celerstudio. All rights reserved.
//

import Foundation
import UIKit

extension CGRect: ExpressibleByStringLiteral {

    public var top: CGFloat {
        get {
            return origin.y
        }
        set(value) {
            origin.y = value
        }
    }
    
    public var left: CGFloat {
        get {
            return origin.x
        }
        set(value) {
            origin.x = value
        }
    }
    
    public var bottom: CGFloat {
        get {
            return origin.y + size.height
        }
        set(value) {
            origin.y = value - size.height
        }
    }
    
    public var right: CGFloat {
        get {
            return origin.x + size.width
        }
        set(value) {
            origin.x = value - size.width
        }
    }
    
    public var centerX: CGFloat {
        get {
            return origin.x + size.width / 2
        }
        set (value) {
            origin.x = value - size.width / 2
        }
    }
    
    public var centerY: CGFloat {
        get {
            return origin.y + size.height / 2
        }
        set (value) {
            origin.y = value - size.height / 2
        }
    }
    
    public var center: CGPoint {
        get {
            return CGPoint(x: centerX, y: centerY)
        }
        set (value) {
            centerX = value.x
            centerY = value.y
        }
    }
    
    public typealias ExtendedGraphemeClusterLiteralType = StringLiteralType
    
    public init(stringLiteral value: StringLiteralType) {
        self.init()
        let rect: CGRect
        if value[value.startIndex] != "{" {
            let comp = value.components(separatedBy: ",")
            if comp.count == 4 {
                rect = NSCoder.cgRect(for: "{{\(comp[0]),\(comp[1])}, {\(comp[2]), \(comp[3])}}")
            } else {
                rect = CGRect.zero
            }
        } else {
            rect = NSCoder.cgRect(for: value)
        }
        
        self.size = rect.size;
        self.origin = rect.origin;
    }
    
    public init(extendedGraphemeClusterLiteral value: ExtendedGraphemeClusterLiteralType) {
        self.init(stringLiteral: value)
    }
    
    public typealias UnicodeScalarLiteralType = StringLiteralType
    
    public init(unicodeScalarLiteral value: UnicodeScalarLiteralType) {
        self.init(stringLiteral: value)
    }
}

extension CGPoint: ExpressibleByStringLiteral {
    public typealias ExtendedGraphemeClusterLiteralType = StringLiteralType
    
    public init(stringLiteral value: StringLiteralType) {
        self.init()
        
        let point:CGPoint;
        if value[value.startIndex] != "{" {
            point = NSCoder.cgPoint(for: "{\(value)}")
        } else {
            point = NSCoder.cgPoint(for: value)
        }
        self.x = point.x;
        self.y = point.y;
    }
    
    public init(extendedGraphemeClusterLiteral value: ExtendedGraphemeClusterLiteralType) {
        self.init(stringLiteral: value)
    }
    
    public typealias UnicodeScalarLiteralType = StringLiteralType
    
    public init(unicodeScalarLiteral value: UnicodeScalarLiteralType) {
        self.init(stringLiteral: value)
    }
}

extension UIView {
    
    func getNoResultLabel() -> UILabel {
        guard let labelObj = self.viewWithTag(232323) as? UILabel else {
            let label = UILabel.init(frame: CGRect(x: 0, y: 0, width: self.width, height: self.height))
            label.backgroundColor = UIColor.clear
            label.text = "No result found"
            label.tag = 232323
            label.textAlignment = .center
            label.font = UIFont.getAppBoldFont(size: 14)
            return label
        }
        return labelObj
    }
    
    func showNoResult(){
        self.getNoResultLabel().text = "No result found"
        self.addSubview(self.getNoResultLabel())
    }
    
    func showNoInternetConnectionResult(){
        self.getNoResultLabel().text = "Oop's, Seems to be a network related issue."
        self.addSubview(self.getNoResultLabel())
    }
    
    func removeNoResult(){
        self.getNoResultLabel().removeFromSuperview()
    }

    func addConstraintsWithFormat(_ format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
    
    public var viewHeightWithTabBar : CGFloat {
        return CGFloat(self.height - kTabBarHeight)
    }
    
    public var top: CGFloat {
        get {
            return frame.top
        }
        set(value) {
            var frame = self.frame
            frame.top = value
            self.frame = frame
        }
    }
    
    public var left: CGFloat {
        get {
            return frame.left
        }
        set(value) {
            var frame = self.frame
            frame.left = value
            self.frame = frame
        }
    }
    
    public var bottom: CGFloat {
        get {
            return frame.bottom
        }
        set(value) {
            var frame = self.frame
            frame.bottom = value
            self.frame = frame
        }
    }
    
    public var right: CGFloat {
        get {
            return frame.right
        }
        set(value) {
            var frame = self.frame
            frame.right = value
            self.frame = frame
        }
    }
    
    public var width: CGFloat {
        get {
            return frame.width
        }
        set(value) {
            var frame = self.frame
            frame.size.width = value
            self.frame = frame
        }
    }
    
    public var height: CGFloat {
        get {
            return frame.height
        }
        set(value) {
            var frame = self.frame
            frame.size.height = value
            self.frame = frame
        }
    }
    
    public var centerX: CGFloat {
        get {
            return frame.centerX
        }
        set(value) {
            var frame = self.frame
            frame.centerX = value
            self.frame = frame
        }
    }
    
    public var centerY: CGFloat {
        get {
            return frame.centerY
        }
        set(value) {
            var frame = self.frame
            frame.centerY = value
            self.frame = frame
        }
    }
    
    func roundedView() {
        self.clipsToBounds = false
        self.layer.cornerRadius = self.frame.size.width/2
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.init(white: 0.8, alpha: 1).cgColor
    }
    
    func squareRoundedView() {
        self.clipsToBounds = false
        self.layer.cornerRadius = 5
    }
    
    func shadow() {
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowColor = UIColor.init(white: 0.3, alpha: 1).cgColor
        self.layer.opacity = 1
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: 10).cgPath
        self.layer.shadowRadius = 10
    }
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            let color = UIColor(cgColor: layer.borderColor!)
            return color
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOffset = CGSize(width: 0, height: 2)
            layer.shadowOpacity = 0.4
            layer.shadowRadius = shadowRadius
        }
    }
}
