//
//  WSMainViewController.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 28/12/17.
//  Copyright © 2017 Celerstudio. All rights reserved.
//

import Foundation
import UIKit
import InteractiveSideMenu

class WSMainViewController : MenuContainerViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let screenSize: CGRect = UIScreen.main.bounds
        self.transitionOptions = TransitionOptions(duration: 0.4, visibleContentWidth: screenSize.width / 4)

        menuViewController = UIStoryboard.storyboard(.main).instantiateViewController(withIdentifier: "WSSideMenuRootViewController") as! MenuViewController
        contentViewControllers = contentControllers()
        selectContentViewController(contentViewControllers.first!)
    }
    
    private func contentControllers() -> [UIViewController] {
        let controllersIdentifiers = [WSCompanyListView.storyboardIdentifier, WSMemberListView.storyboardIdentifier, WSMeetingRoomListView.storyboardIdentifier]
        var contentList = [UIViewController]()

        for identifier in controllersIdentifiers {
            if let viewController = self.storyboard?.instantiateViewController(withIdentifier: identifier) {
                contentList.append(viewController)
            }
        }
        let vc = TBChatViewController.init()
        vc.firebaseDatabaseRef = .groupChat
        contentList.append(vc)
        
        return contentList
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }

}
