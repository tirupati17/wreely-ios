//
//  WSCompanyDetailView.swift
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

class WSCompanyDetailView : WSViewController, SideMenuItemContent {
    @IBOutlet var tableView : UITableView!
    var companyDetailPresenterProtocol : WSCompanyDetailPresenterProtocol!
    var company : WSCompany!
    
    override func loadView() {
        super.loadView()
        self.title = company.name
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let item = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        item.tintColor = UIColor.white
        self.navigationItem.backBarButtonItem = item
        
        self.configureDependencies()
        self.companyDetailPresenterProtocol.didFetchMoreDetail()
    }
    
    func configureDependencies() {
        let companyDetailPresenter = WSCompanyDetailPresenter()
        companyDetailPresenter.companyDetailViewProtocol = self
        self.companyDetailPresenterProtocol = companyDetailPresenter
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func showMenu() {
        showSideMenu()
    }
    
    func returnCell(forIndexPath row : Int, _ section : Int? = 0) -> WSCompanyDetailCell! {
        return self.tableView.cellForRow(at: NSIndexPath.init(row: row, section: section!) as IndexPath)! as! WSCompanyDetailCell
    }
}

/**
 * Add here your methods for communication PRESENTER -> VIEW
 */

extension WSCompanyDetailView : WSCompanyDetailViewProtocol {
    func noContentFromServer() {
        
    }
    
    func presentController<T>(_ vc: T) {
        
    }
    
    func pushController<T>(_ vc: T) {
        
    }
    
    func updateView(_ company : WSCompany) {
        self.company = company
        self.stopViewAnimation()
    }
    
 }

extension WSCompanyDetailView : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
            case 0:
                return 215
            case 1:
                return 100
            default:
                return 60
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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

extension WSCompanyDetailView : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell\(indexPath.row)", for: indexPath)
        switch indexPath.row {
            case 0:
                let imageView = cell.contentView.viewWithTag(111) as! UIImageView
                let font = UIFont.systemFont(ofSize: 16)
                if !(self.company.companyLogoURL?.isEmpty)! {
                    imageView.kf.setImage(with: URL.init(string: self.company.companyLogoURL!))
                } else {
                    imageView.setImage(string: self.company.name, color: .random, circular: true, textAttributes: [NSAttributedString.Key.font: font.withSize(font.pointSize * 2), NSAttributedString.Key.foregroundColor: UIColor.white])
                }
                //imageBgView.blurEffect()
                
                let nameLabel = cell.contentView.viewWithTag(112) as! UILabel
                nameLabel.text = self.company.name
                break
            case 1:
                let descriptionLabel = cell.contentView.viewWithTag(221) as! UITextView
                descriptionLabel.text = self.company.aboutCompany
                
                break
            case 2:
                let websiteLabel = cell.contentView.viewWithTag(331) as! UILabel
                if self.company.website != nil {
                    websiteLabel.text = self.company.website
                }
                break
            case 3:
                let labelObj = cell.contentView.viewWithTag(441) as! UILabel
                labelObj.text = self.company.contactPersonEmailId
                break
            case 4:
                let labelObj = cell.contentView.viewWithTag(551) as! UILabel
                labelObj.text = self.company.contactPersonNumber
                break
            case 5:
                let labelObj = cell.contentView.viewWithTag(661) as! UILabel
                labelObj.text = "Teams"
                break
            default:
                break
        }

        return cell
    }
}

extension WSCompanyDetailView : TextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
}
