//
//  WSSideMenuRootViewController.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 27/12/17.
//  Copyright © 2017 Celerstudio. All rights reserved.
//

import Foundation
import UIKit
import Material
import InteractiveSideMenu
import Kingfisher
import FontAwesome_swift

class WSSideMenuRootViewController : MenuViewController {
    @IBOutlet var tableView : UITableView!
    @IBOutlet var vendorLogo : UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.vendorLogo.kf.setImage(with: URL.init(string: WSSession.activeSession().currentVendor().vendorLogoUrl!))
        self.vendorLogo.clipsToBounds = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func returnCell(forIndexPath row : Int, _ section : Int? = 0) -> UITableViewCell! {
        return self.tableView.cellForRow(at: NSIndexPath.init(row: row, section: section!) as IndexPath)!
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    @IBAction func switchWorkspace() {
        let vc = UIStoryboard.storyboard(.main).instantiateViewController(withIdentifier: WSWorkspaceSelectionView.storyboardIdentifier)
        self.present(vc, animated: true) {
            
        }
    }
    
    func signOut() {
        AppDelegate.sharedDelegate.logout()
    }
}

extension WSSideMenuRootViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let menuContainerViewController = self.menuContainerViewController else {
            return
        }
        switch indexPath.section {
            case 0:
                switch indexPath.row {
                    case 0, 1:
                        menuContainerViewController.selectContentViewController(menuContainerViewController.contentViewControllers[indexPath.row])
                        break
                    case 2:
                        menuContainerViewController.selectContentViewController(menuContainerViewController.contentViewControllers[3])
                        break

                    default:
                        break
                }
                break;
            case 1:
                switch indexPath.row {
                    case 0:
                        menuContainerViewController.selectContentViewController(menuContainerViewController.contentViewControllers[2])
                        break
                    case 1:
                        self.signOut()
                        break
                    case 2:
                        break
                    default:
                        break
                    }
                    break;
            default: break
        }
        menuContainerViewController.hideSideMenu()
    }
}

extension WSSideMenuRootViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            case 0:
                return 3
            case 1:
                return 2
            default:
                break
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = (tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) )
        
        let imageView = cell.viewWithTag(111) as! UIImageView
        let label = cell.viewWithTag(112) as! UILabel
        label.accessibilityIdentifier = "fa-home"
        switch indexPath.section {
            case 0:
                switch indexPath.row {
                    case 0:
                        label.text = "Companies"
                        break
                    case 1:
                        label.text = "Members"
                        label.accessibilityIdentifier = "fa-sitemap"
                        break
                    case 2:
                        label.text = "Group Conversations"
                        label.accessibilityIdentifier = "fa-users"
                        break
                    case 3:
                        label.text = "Events"
                        label.accessibilityIdentifier = "fa-ticket"
                        break
                    default:
                        break
                }
                break;
            case 1:
                switch indexPath.row {
                    case 0:
                        label.text = "Book Meeting Room"
                        label.accessibilityIdentifier = "fa-calendar"
                        break
                    case 1:
                        label.text = "Sign Out"
                        label.accessibilityIdentifier = "fa-sign-out"
                        break
                    case 2:
                        break
                    default:
                        break
                }
                break;
            default: break
        }
        imageView.image = UIImage.fontAwesomeIcon(name: FontAwesome.fromCode(label.accessibilityIdentifier!)!, style: .brands, textColor: UIColor.darkGray, size: CGSize(width: 20, height: 30))
        return cell
    }
}
