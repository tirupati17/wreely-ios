//
//  WSMemberDetailView.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 15/01/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation
import UIKit
import Material
import NVActivityIndicatorView
import Kingfisher
import Letters
import InteractiveSideMenu

class WSMemberDetailView : WSViewController, SideMenuItemContent {
    @IBOutlet var tableView : UITableView!
    var memberDetailPresenterProtocol : WSMemberDetailPresenterProtocol!
    var member : WSMember!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = member.name
        let item = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        item.tintColor = UIColor.white
        self.navigationItem.backBarButtonItem = item
        
        self.configureDependencies()
        
        if (WSSession.activeSession().currentUser().id == member.id) {
            self.memberDetailPresenterProtocol.didFetchMoreDetail()
        }
    }
    
    func configureDependencies() {
        let memberDetailPresenter = WSMemberDetailPresenter()
        memberDetailPresenter.memberDetailViewProtocol = self
        self.memberDetailPresenterProtocol = memberDetailPresenter
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func sideMenuPressed() {
        showSideMenu()
    }
    
    func returnCell(forIndexPath row : Int, _ section : Int? = 0) -> WSMemberDetailTopCell! {
        return self.tableView.cellForRow(at: NSIndexPath.init(row: row, section: section!) as IndexPath)! as! WSMemberDetailTopCell
    }
}

/**
 * Add here your methods for communication PRESENTER -> VIEW
 */

extension WSMemberDetailView : WSMemberDetailViewProtocol {
    func noContentFromServer() {
        
    }
    
    func presentController<T>(_ vc: T) {
        
    }
    
    func pushController<T>(_ vc: T) {
        
    }
    
    func updateView(_ member : WSMember) {
        self.member = member
        self.tableView.reloadData()
        self.stopViewAnimation()
    }
}

extension WSMemberDetailView : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
            case 0:
                return 194
            case 1:
                return 100
            default:
                return 60
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
            case 2:
                UIApplication.shared.openURL(URL.init(string: self.member.websiteUrl!)!)
                break
            case 3:
                UIApplication.shared.openURL(URL.init(string: self.member.linkedinUrl!)!)
                break
            case 4:
                UIApplication.shared.openURL(URL.init(string: self.member.facebookUrl!)!)
                break
            case 5:
                UIApplication.shared.openURL(URL.init(string: self.member.twitterUrl!)!)
                break
            case 6:
                UIApplication.shared.openURL(URL.init(string: self.member.instagramUrl!)!)
                break
            default:
                break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView.init(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.view.width, height: 30)))
        let footerLabel = UILabel.init(frame: footerView.frame)
        footerLabel.backgroundColor = UIColor.white
        footerLabel.font = UIFont.getAppMediumFont(size: 10)
        footerLabel.textColor = UIColor.darkGray
        footerLabel.textAlignment = .center
        footerView.addSubview(footerLabel)
        footerLabel.text = ""
        return footerView
    }
}

extension WSMemberDetailView : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell\(indexPath.row)", for: indexPath)
        switch indexPath.row {
            case 0:
                let imageView = cell.contentView.viewWithTag(111) as! UIImageView
                imageView.clipsToBounds = true
                imageView.layer.masksToBounds = true
                imageView.layer.cornerRadius = imageView.height/2
                imageView.translatesAutoresizingMaskIntoConstraints = false
                imageView.layer.borderWidth = 0

                let font = UIFont.systemFont(ofSize: 16)
                if !(self.member.profilePicUrl?.isEmpty)! {
                    imageView.kf.setImage(with: URL.init(string: self.member.profilePicUrl!))
                } else {
                    imageView.setImage(string: self.member.name, color: .random, circular: true, textAttributes: [NSAttributedString.Key.font: font.withSize(font.pointSize * 2), NSAttributedString.Key.foregroundColor: UIColor.white])
                }
                
                let nameLabel = cell.contentView.viewWithTag(112) as! UILabel
                nameLabel.text = self.member.name
                let designationLabel = cell.contentView.viewWithTag(113) as! UILabel
                designationLabel.font = UIFont.getAppRegularFont(size: 14)
                designationLabel.text = self.member.companyName
                break
            case 1:
                let descriptionLabel = cell.contentView.viewWithTag(221) as! UITextView
                descriptionLabel.text = self.member.aboutMe
                
                break
            case 2:
                let labelObj = cell.contentView.viewWithTag(331) as! UILabel
                labelObj.text = self.member.websiteUrl
                break
            case 3:
                let labelObj = cell.contentView.viewWithTag(441) as! UILabel
                labelObj.text = self.member.linkedinUrl
                break
            case 4:
                let labelObj = cell.contentView.viewWithTag(551) as! UILabel
                labelObj.text = self.member.facebookUrl
                break
            case 5:
                let labelObj = cell.contentView.viewWithTag(661) as! UILabel
                labelObj.text = self.member.twitterUrl
                break
            case 6:
                let labelObj = cell.contentView.viewWithTag(771) as! UILabel
                labelObj.text = self.member.instagramUrl
                break
            case 7:
                let labelObj = cell.contentView.viewWithTag(771) as! UILabel
                labelObj.text = self.member.companyName
                break
            default:
                break
        }
        return cell
    }
}

extension WSMemberDetailView : TextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
}
