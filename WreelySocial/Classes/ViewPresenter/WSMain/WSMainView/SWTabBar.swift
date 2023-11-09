///
//  e-Where
//
//  Created by Sean Warren on 2/19/17.
//  Copyright © 2017 Sean Warren. All rights reserved.
//

import UIKit
class SWTabBar {
    var title: String = ""
    var imageName: String = ""
    var contoller: UIViewController
    init(title: String = "", imageName: String = "", contoller: UIViewController = WSViewController()) {
        self.title =  title
        self.imageName = imageName
        self.contoller = contoller
    }
    open func createTabData() -> [SWTabBar] {
        var arrayOfTabs = [SWTabBar]()
        
        let companyMemberPageVc = UIStoryboard.storyboard(.main).instantiateViewController(withIdentifier: "WSMemberCompanyPageController") as! WSMemberCompanyPageController
        let companyMemberPage = SWTabBar(title: "Community", imageName: "group-profile-users", contoller: companyMemberPageVc)


        //let eventVc = UIStoryboard.storyboard(.main).instantiateViewController(withIdentifier: WSEventListView.storyboardIdentifier) as! WSEventListView
        //let events = SWTabBar(title: "Events", imageName: "ticket", contoller: eventVc)

        let meetingVc = UIStoryboard.storyboard(.main).instantiateViewController(withIdentifier: WSMeetingRoomListView.storyboardIdentifier) as! WSMeetingRoomListView
        let meetingRoom = SWTabBar(title: "Meeting Room", imageName: "tasks-list", contoller: meetingVc)

        
//        let workspacesVC = UIStoryboard.storyboard(.main).instantiateViewController(withIdentifier: WSWorkspaceListView.storyboardIdentifier) as! WSWorkspaceListView
//        let workspaces = SWTabBar(title: "Nearby", imageName: "compass-circular-variant", contoller: workspacesVC)

        let conversation = SWTabBar(title: "Conversation", imageName: "inbox", contoller: WSGroupListView.init())
        let settings = SWTabBar(title: "Settings", imageName: "settings", contoller: TBCommonSettingView())
        
        arrayOfTabs = [companyMemberPage, meetingRoom, conversation, settings]
        return arrayOfTabs
    }
}
