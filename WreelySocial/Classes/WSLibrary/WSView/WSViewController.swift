//
//  WSViewController.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 20/12/17.
//  Copyright © 2017 Celerstudio. All rights reserved.
//

@_exported import Foundation
@_exported import UIKit
@_exported import NVActivityIndicatorView
@_exported import SCLAlertView
@_exported import Toast_Swift
@_exported import ParallaxHeader
@_exported import Material
@_exported import SwiftyUserDefaults
@_exported import InteractiveSideMenu
@_exported import Letters
@_exported import Kingfisher

class WSViewController : WSBasicViewController, NVActivityIndicatorViewable {
    var activityIndicatorView : NVActivityIndicatorView!
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.handleRefresh(_:)), for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.themeColor()
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let rect =  CGRect(x: 0, y: 0, width: 40 , height: 40)
        let center = CGPoint(x: (view.frame).midX, y: (view.frame).midY)
        
        activityIndicatorView =  NVActivityIndicatorView(frame: rect, type: .ballPulse , color: UIColor.themeColor(), padding: CGFloat(0))
        activityIndicatorView.center = center
        view.addSubview(activityIndicatorView)
        
        if let resId = self.restorationIdentifier {
            WSTracking.logEvent("Screen_\(resId)")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func stopViewAnimation() {
        DispatchQueue.main.async {
            self.activityIndicatorView.stopAnimating()
            self.stopAnimating()
            self.refreshControl.endRefreshing()
        }
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {

    }
    
    func startViewAnimation() {
        DispatchQueue.main.async {
            self.activityIndicatorView.startAnimating()
        }
    }
    
    func showAlertWithTitleAndMessage(title: String, message: String, handler: ((UIAlertAction) -> Swift.Void)? = nil) {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: handler))
        self.present(alert, animated: true, completion: {
        })
    }
    
    func showCustomAlertWithTitleAndMessage(title: String, message: String) {
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: true,
            hideWhenBackgroundViewIsTapped : true,
            circleBackgroundColor : UIColor.themeColor(), contentViewBorderColor : UIColor.themeColor()
        )
        let alertView = SCLAlertView(appearance: appearance)
        alertView.showInfo(title, subTitle: message)
    }
    
    func showCustomAlertView(title: String, message: String, okTitle : String? = "OK", cancelTitle : String? = "Cancel", okHandler: ((SCLAlertView) -> Swift.Void)? = nil, cancelHandler: ((SCLAlertView) -> Swift.Void)? = nil) -> SCLAlertView {
        let appearance = SCLAlertView.SCLAppearance(
            kCircleIconHeight: 40,
            kWindowWidth: self.view.width - 80,
            showCloseButton: false,
            hideWhenBackgroundViewIsTapped : true,
            circleBackgroundColor : UIColor.themeColor(), contentViewBorderColor : UIColor.themeColor()
        )
        let alertView = SCLAlertView(appearance: appearance)
        alertView.addButton(okTitle!) {
            okHandler!(alertView)
        }
        alertView.addButton(cancelTitle!) {
            cancelHandler!(alertView)
        }
        alertView.showCustom(title, subTitle: message, color: UIColor.themeColor(), icon: UIImage.init(named: "icn_logo_small")!, colorStyle:0x0088D8)
        return alertView
    }
    
    func showToastMessage(_ message : String) {
        DispatchQueue.main.async {
            self.view.makeToast(message, duration: 3.0, position: .top)
        }
    }
}
