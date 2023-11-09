//
//  SWTabBarController.swift
///
//  e-Where
//
//  Created by Sean Warren on 2/19/17.
//  Copyright © 2017 Sean Warren. All rights reserved.
//
import UIKit
class SWTabBarController: UITabBarController {
  var incomingArray = [SWTabBar]()
  var arrayOfController = [(UINavigationController)]()

    init(incomingArray: [SWTabBar]) {

        self.incomingArray =  incomingArray
        super.init(nibName:nil, bundle:nil)
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().barTintColor = UIColor.white
        UITabBar.appearance().tintColor = UIColor.themeColor()
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        var arrayOfTabs = [SWTabBar]()

        arrayOfTabs = self.incomingArray
        createTabsFromArray(array: arrayOfTabs)
        viewControllers = arrayOfController
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    private func createTabsFromArray(array: [SWTabBar]) {
        for tab in array {
            let nav = createNavigationController(title: tab.title, imageName: tab.imageName, controller: tab.contoller)
            arrayOfController.append(nav)
        }
    }

    private func createNavigationController(title: String, imageName: String, controller: UIViewController)
        -> UINavigationController {
        let viewController = controller
        let navigationItem = UINavigationController(rootViewController: viewController)
        navigationItem.tabBarItem.title = title
        navigationItem.tabBarItem.image = UIImage(named: imageName)
        return navigationItem
    }
}
extension UITabBar {
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
                case 1136:
                    sizeThatFits.height = 49
                case 1334:
                    sizeThatFits.height = 49
                case 1920, 2208:
                    sizeThatFits.height = 49
                case 2436:
                    sizeThatFits.height = 83
                default:
                    sizeThatFits.height = 49
            }
        }
        return sizeThatFits
    }
}
