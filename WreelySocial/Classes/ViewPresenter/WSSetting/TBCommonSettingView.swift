//
//  TBCommonSettingView.swift
//
//  Created by Tirupati Balan on 18/06/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation
import UIKit
import MessageUI
import Kingfisher

struct TBMoreAppItem {
    var title : String? = ""
    var description : String? = ""
    var storeUrl : String? = ""
    var iconUrl : String? = ""
    
    init(title : String? = "", description : String? = "", storeUrl : String? = "", iconUrl : String? = "") {
        self.title = title
        self.description = description
        self.storeUrl = storeUrl
        self.iconUrl = iconUrl
    }
}

class TBCommonSettingView : UIViewController {
    var tableView : UITableView!
    var commonSettingPresenterProtocol : TBCommonSettingPresenterProtocol!
    var moreApps : [TBMoreAppItem] = []
    private var companyName : String {
        return "\(self.appName) Powered by Wreely"
    }
    private var copyrightYear : String = "2019"
    private var copyrightText : String {
        return "\(self.companyName) Copyright " + self.copyrightYear
    }
    private var appName : String {
        return WSConstant.WorkspaceDisplayName
    }
    private var appId : String { //"1351815873" - Wreely
        return WSConstant.WorkspaceAppleId
    }
    private var bundleIdentifier : String {
        return Bundle.main.infoDictionary?["CFBundleIdentifier"] as! String
    }
    private var appStoreShortUrl : String  {
        return WSConstant.WorkspaceAppleUrl
    }
    private var appVersion : String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
    }
    private var appBuildVersion : String {
        return Bundle.main.infoDictionary?["CFBundleVersion"] as! String
    }
    private var rateUsUrl : String {
        return "itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=" + self.appId + "&onlyLatestVersion=true&pageNumber=0&sortOrdering=1&type=Purple+Software"
    }
    private var shareText : String {
        return "Hey, Checkout this iOS app " + self.appName + "\n " + self.appStoreShortUrl
    }
    
    private var feedbackEmail : String = "hello@wreely.com"
    private var feedbackSubject : String {
        return "Feedback for " + self.appName
    }
    private var feedbackMessage : String {
        return "Your message : </br></br>App Version :" + self.appVersion + " </br>Device : " + self.modelIdentifier()
    }

    private var privacyPolicyUrl : String  = "https://www.celerstudio.com/wreely/community_platform/privacy_policy.html"
    private var termsAndConditionsUrl : String  = "https://www.celerstudio.com/wreely/community_platform/terms_and_conditions.html"
    private var facebookLikeUsUrl : String  = "https://www.facebook.com/wreely"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadAllAppsData() //load it from https://www.celerstudio.com/assets/all_apps.json
        self.tableView = UITableView.init(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.view.width, height: self.view.height)), style: .plain)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        view.addSubview(self.tableView)
        
        self.configureDependencies()
        
        self.title = "General"
        self.commonSettingPresenterProtocol.loadRecentApps()
        
//        let doneButton = UIBarButtonItem.init(barButtonSystemItem: .done, target: self, action: #selector(self.backOrDoneAction))
//        doneButton.tintColor = UIColor.white
//        self.navigationItem.leftBarButtonItem = doneButton
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func signOut() {
        let alert = UIAlertController.init(title: "", message: "Are you sure?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { (alert) in
            DispatchQueue.main.async {
                fatalError("Hello Crash")
                //AppDelegate.sharedDelegate.logout()
            }
        }))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.default, handler: { (alert) in
        }))
        self.present(alert, animated: true, completion: {
        })
    }
    
    func configureDependencies() {
        let commonSettingPresenter = TBCommonSettingPresenter()
        commonSettingPresenter.commonSettingViewProtocol = self //PRESENTER -> VIEW CONNECTION
        self.commonSettingPresenterProtocol = commonSettingPresenter //VIEW -> PRESENTER  CONNECTION
    }
    
    @objc func backOrDoneAction() {
        self.dismiss(animated: true) {
            
        }
    }
    
    func sendMail(_ recipients : [String], message : String, subject : String, isHTML : Bool? = true) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(recipients)
            mail.setSubject(subject)
            mail.setMessageBody(message, isHTML: isHTML!)
            present(mail, animated: true)
        } else {
            print("mail can not send")
        }
    }
    
    func modelIdentifier() -> String {
        if let simulatorModelIdentifier = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] {
            return simulatorModelIdentifier
        }
        var sysinfo = utsname()
        uname(&sysinfo)
        return String(bytes: Data(bytes: &sysinfo.machine, count: Int(_SYS_NAMELEN)), encoding: .ascii)!.trimmingCharacters(in: .controlCharacters)
    }
    
    func shareAction(_ text : String, image : UIImage? = nil, url : URL? = nil) {
        var shareAll = [text] as [Any]
        if image != nil {
            shareAll.append(image!)
        }
        if url != nil {
            shareAll.append(url!)
        }
        let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func resizeImageWithAspect(image: UIImage,scaledToMaxWidth width:CGFloat,maxHeight height :CGFloat)->UIImage? {
        let oldWidth = image.size.width;
        let oldHeight = image.size.height;
        
        let scaleFactor = (oldWidth > oldHeight) ? width / oldWidth : height / oldHeight;
        
        let newHeight = oldHeight * scaleFactor;
        let newWidth = oldWidth * scaleFactor;
        let newSize = CGSize(width: newWidth, height: newHeight)
        
        UIGraphicsBeginImageContextWithOptions(newSize,false,UIScreen.main.scale);
        
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height));
        let newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return newImage
    }
    
    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage {
        UIGraphicsBeginImageContext( newSize )
        image.draw(in: CGRect(x: 0,y: 0,width: newSize.width,height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!.withRenderingMode(.alwaysOriginal)
    }
    
    func loadAllAppsData() {
        if let path = Bundle.main.path(forResource: "all_apps", ofType: "json") {
            do {
                let data = try(Data(contentsOf: URL(fileURLWithPath: path), options: NSData.ReadingOptions.mappedIfSafe))
                let jsonDictionary = try(JSONSerialization.jsonObject(with: data, options: .mutableContainers)) as? [String: Any]
                if let postsArray = jsonDictionary?["apps"] as? [[String: AnyObject]] {
                    for postDictionary in postsArray {
                        var appItem = TBMoreAppItem()
                        appItem.title = postDictionary["title"] as? String
                        appItem.description = postDictionary["description"] as? String
                        appItem.storeUrl = postDictionary["storeUrl"] as? String
                        appItem.iconUrl = postDictionary["iconUrl"] as? String
                        self.moreApps.append(appItem)
                    }
                }
            } catch let err {
                print(err)
            }
        }
    }
}

extension TBCommonSettingView : MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}

/**
 * Description : Methods for communication between PRESENTER -> VIEW
 * Purpose : Mediator between model and view i.e pass processed data from server->model to view
 */

extension TBCommonSettingView : TBCommonSettingViewProtocol {
    
    func didLoadRecentApps(_ moreApps: [TBMoreAppItem]) {
        
    }
}

extension TBCommonSettingView : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.view.width, height: 30)))
        let headerLabel = UILabel.init(frame: headerView.frame)
        headerLabel.backgroundColor = UIColor.white
        headerLabel.font = UIFont.getAppMediumFont(size: 14)
        headerLabel.textAlignment = .left
        headerLabel.textColor = UIColor.darkGray
        headerView.addSubview(headerLabel)
        switch (section) {
            case 0,1,2:
                headerLabel.text = ""//"  General Support"
            default:
                headerLabel.text = "  More Apps By " + self.companyName
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch (section) {
            case 2:
                return 30
            default:
                return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        switch (section) {
            case 2:
                let footerView = UIView.init(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.view.width, height: 30)))
                let footerLabel = UILabel.init(frame: footerView.frame)
                footerLabel.backgroundColor = UIColor.white
                footerLabel.font = UIFont.getAppMediumFont(size: 10)
                footerLabel.textColor = UIColor.darkGray
                footerLabel.textAlignment = .center
                footerView.addSubview(footerLabel)
                footerLabel.text = self.copyrightText + " Version " + self.appVersion + " (\(self.appBuildVersion))"
                return footerView
            default:
                return nil
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch (indexPath.section) {
            case 0:
                switch (indexPath.row) {
                    case 0:
                        let vc = UIStoryboard.storyboard(.main).instantiateViewController(withIdentifier: WSMemberDetailView.storyboardIdentifier) as! WSMemberDetailView
                        vc.member = WSSession.activeSession().currentUser()
                        self.navigationController?.pushViewController(vc, animated: true)
                        break
                    default:
                        break
                }
            case 1:
                switch (indexPath.row) {
                    case 0:
                        self.sendMail([self.feedbackEmail], message: self.feedbackMessage, subject: feedbackSubject)
                        break
                    case 1:
                        UIApplication.shared.openURL(URL.init(string: self.rateUsUrl)!)
                        break
                    case 2:
                        self.shareAction(self.shareText)
                        break
                    case 3:
                        UIApplication.shared.openURL(URL.init(string: self.facebookLikeUsUrl)!)
                        break
                    default:
                        break
                }
            case 2:
                switch (indexPath.row) {
                    case 0:
                         [][0]
                        //UIApplication.shared.openURL(URL.init(string: self.privacyPolicyUrl)!)
                        break
                    case 1:
                        if #available(iOS 10.0, *) {
                            UIApplication.shared.open(URL.init(string: self.termsAndConditionsUrl)!, options: [:], completionHandler: nil)
                        } else {
                            // Fallback on earlier versions
                        }
                        break
                    case 2:
                        self.signOut()
                        break
                    default:
                        break
                }
            case 3:
                let moreAppItem = self.moreApps[indexPath.row]
                UIApplication.shared.openURL(URL.init(string: moreAppItem.storeUrl!)!)
            default:
                break
        }
    }
}

extension TBCommonSettingView : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch (section) {
            case 0:
                return 1
            case 1:
                return 4
            case 2:
                return 3
            default:
                return self.moreApps.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let indentifier = "cell\(indexPath.row)"
        var cell = tableView.dequeueReusableCell(withIdentifier: indentifier)
        if (cell == nil)  {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: indentifier)
        }
        
        cell?.textLabel?.font = UIFont.getAppRegularFont(size: 16)//UIFont(name: "Avenir-Book", size: 25)
        //cell?.textLabel?.textColor = UIColor(r: 83, g: 83, b: 83)
        
//        cell?.textLabel?.font = UIFont.getAppMediumFont(size: 14)
        cell?.detailTextLabel?.font = UIFont.getAppMediumFont(size: 12)
        cell?.textLabel?.textAlignment = .left

        switch (indexPath.section) {
            case 0:
                switch (indexPath.row) {
                    case 0:
                        cell?.textLabel?.text = "View Profile"
                        break
                    default:
                        break
                }
                return cell!
            case 1:
                switch (indexPath.row) {
                    case 0:
                        cell?.textLabel?.text = "Give us feedback"
                        break
                    case 1:
                        cell?.textLabel?.text = "Rate us"
                        break
                    case 2:
                        cell?.textLabel?.text = "Invite friends"
                        break
                    case 3:
                        cell?.textLabel?.text = "Like us on facebook"
                        break
                    default:
                        break
                }
                return cell!
            case 2:
                switch (indexPath.row) {
                    case 0:
                        cell?.textLabel?.text = "Privacy Policy"
                        break
                    case 1:
                        cell?.textLabel?.text = "Terms & Conditions"
                        break
                    case 2:
                        cell?.textLabel?.text = "Sign Out"
                        break
                    default:
                        break
                }
                return cell!
            case 3:
                let moreAppItem = self.moreApps[indexPath.row]
                cell?.textLabel?.textAlignment = .left
                cell?.textLabel?.text = moreAppItem.title
                cell?.detailTextLabel?.text = moreAppItem.description
                
                cell?.imageView?.kf.setImage(with: URL.init(string: moreAppItem.iconUrl!), completionHandler: { (image, error, cache, url) in
                    cell?.imageView?.image = self.resizeImageWithAspect(image: image!, scaledToMaxWidth: 40, maxHeight: 40)
                    cell?.imageView?.layer.cornerRadius = 4
                    cell?.imageView?.clipsToBounds = true
                    cell?.setNeedsLayout()
                })
                return cell!
            default:
                break
        }
        return UITableViewCell.init()
    }
}

extension TBCommonSettingView : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
}
