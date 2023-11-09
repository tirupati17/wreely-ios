//
//  WSHomeViewController.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 25/06/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation
import FontAwesome_swift

enum ScreenFromHome : Int {
    case kMembersScreen = 0
    case kCompaniesScreen = 1
    case kMeetingRoomScreen = 2
    case kEventsScreen = 3
    case kNearByWorkspaceScreen = 4
    case kGroupChatScreen = 5
}

enum CalculatorCellUIControlTag : Int {
    case labelViewDetailTag = 111
    case labelViewTitleTag = 112
    case leftImageViewTag = 113
}

class WSHomeViewController : WSViewController {
    @IBOutlet var tableView : UITableView!
    
    override func loadView() {
        super.loadView()
        self.navigationItem.title = WSConstant.AppTitle
        
        let item = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        item.tintColor = UIColor.white
        self.navigationItem.backBarButtonItem = item
        
        let leftButton = UIBarButtonItem.init(image: UIImage.init(named: "settings.png"), style: .plain, target: self, action: #selector(self.showSetting))
        leftButton.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = leftButton
    }
    
    @objc func showSetting() {
        let vc = TBCommonSettingView()
        let nv = UINavigationController.init(rootViewController: vc)
        self.present(nv, animated: true) {}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
}

extension WSHomeViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case ScreenFromHome.kCompaniesScreen.rawValue:
            let vc = UIStoryboard.storyboard(.main).instantiateViewController(withIdentifier: WSCompanyListView.storyboardIdentifier) as! WSCompanyListView
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case ScreenFromHome.kMembersScreen.rawValue:
            let vc = UIStoryboard.storyboard(.main).instantiateViewController(withIdentifier: WSMemberListView.storyboardIdentifier) as! WSMemberListView
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case ScreenFromHome.kGroupChatScreen.rawValue:
            let vc = TBChatViewController.init()
            vc.firebaseDatabaseRef = .groupChat
            if (WSFirebaseSession.activeSession().isValidSession() == false) {
                self.startViewAnimation()
                WSFirebaseRequest.firebaseUserLogin(WSSession.activeSession().currentUser().emailId!, "123456789", { (response) in
                    self.stopViewAnimation()
                    WSRequest.fetchFirebaseCurrentUser({
                        self.navigationController?.pushViewController(vc, animated: true)
                    })
                }) { (error) in
                    self.stopViewAnimation()
                    self.showToastMessage(error.localizedDescription)
                    print(error)
                }
            } else {
                self.navigationController?.pushViewController(vc, animated: true)
            }
            break
        case ScreenFromHome.kEventsScreen.rawValue:
            let vc = UIStoryboard.storyboard(.main).instantiateViewController(withIdentifier: WSEventListView.storyboardIdentifier) as! WSEventListView
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case ScreenFromHome.kMeetingRoomScreen.rawValue:
            let vc = UIStoryboard.storyboard(.main).instantiateViewController(withIdentifier: WSMeetingRoomListView.storyboardIdentifier) as! WSMeetingRoomListView
            self.navigationController?.pushViewController(vc, animated: true)
            break
        default:
            break
        }
    }
}

extension WSHomeViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.view.width, height: 5)))
        view.backgroundColor = UIColor.clear
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:WSTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WSTableViewCell)
        let labelViewTitle = cell.getView(CalculatorCellUIControlTag.labelViewTitleTag.rawValue) as! UILabel
        let leftImageView = cell.getView(CalculatorCellUIControlTag.leftImageViewTag.rawValue) as! UIImageView
        
        labelViewTitle.accessibilityIdentifier = "fa-sitemap"
        switch indexPath.row {
        case ScreenFromHome.kCompaniesScreen.rawValue:
            labelViewTitle.text = "Companies"
            labelViewTitle.accessibilityIdentifier = "fa-sitemap"
            break
        case ScreenFromHome.kMembersScreen.rawValue:
            labelViewTitle.text = "Members"
            labelViewTitle.accessibilityIdentifier = "fa-diamond"
            break
        case ScreenFromHome.kGroupChatScreen.rawValue:
            labelViewTitle.text = "Conversations"
            labelViewTitle.accessibilityIdentifier = "fa-empire"
            break
        case ScreenFromHome.kEventsScreen.rawValue:
            labelViewTitle.text = "Events"
            labelViewTitle.accessibilityIdentifier = "fa-etsy"
            break
        case ScreenFromHome.kNearByWorkspaceScreen.rawValue:
            labelViewTitle.text = "Nearby Workspace"
            labelViewTitle.accessibilityIdentifier = "fa-eye"
            break
        case ScreenFromHome.kMeetingRoomScreen.rawValue:
            labelViewTitle.text = "Meeting Rooms"
            labelViewTitle.accessibilityIdentifier = "fa-eraser"
            break
        default:
            break
        }
        leftImageView.image = UIImage.fontAwesomeIcon(name: FontAwesome.fromCode(labelViewTitle.accessibilityIdentifier!)!, style: .brands, textColor: UIColor.themeColor(), size: CGSize(width: 35, height: 40))
        
        return cell
    }
}
