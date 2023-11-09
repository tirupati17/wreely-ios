//
//  SWSettingController.swift
///
//  e-Where
//
//  Created by Sean Warren on 2/19/17.
//  Copyright © 2017 Sean Warren. All rights reserved.
//

import UIKit
import LBTAComponents

class SWSettingController: DatasourceController {
    private var appName : String = "Wreely - Community Platform"
    private var appId : String = "1351815873"
    private var appStoreShortUrl : String  = "https://goo.gl/SqXZD4"
    private var shareText : String {
        return "Hey, Checkout this iOS app " + self.appName + "\n " + self.appStoreShortUrl
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Settings"

        view.backgroundColor = .white
        collectionView?.backgroundColor = .white
        datasource = SettingsDatasource()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 125)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dataSource =  SettingsDatasource().objects as [Any]?
        guard let dataObject = dataSource?[indexPath.item] as? (SWMenuItem) else {return}
        switch indexPath.row {
        case 0:
            let vc = UIStoryboard.storyboard(.main).instantiateViewController(withIdentifier: WSMemberDetailView.storyboardIdentifier) as! WSMemberDetailView
            vc.member = WSSession.activeSession().currentUser()
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 1:
            let vc = TBCommonSettingView()
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 2:
            UIApplication.shared.openURL(URL.init(string: "https://wreely.com")!)
            break
        default:
            let alert = UIAlertController.init(title: "", message: "Are you sure?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { (alert) in
                AppDelegate.sharedDelegate.logout()
            }))
            alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.default, handler: { (alert) in
            }))
            self.present(alert, animated: true, completion: {
            })
            break
        }
        print(dataObject.title + " \(indexPath.item)")
    }

   override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                                sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 45)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
