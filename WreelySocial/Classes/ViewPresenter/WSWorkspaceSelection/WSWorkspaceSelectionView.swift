//
//  WSWorkspaceSelectionView.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 30/12/17.
//  Copyright © 2017 Celerstudio. All rights reserved.
//

import Foundation
import UIKit
import Material
import SwiftyUserDefaults
import NVActivityIndicatorView
import Kingfisher

class WSWorkspaceSelectionView : WSViewController {
    @IBOutlet var tableView : UITableView!
    var workspaceSelectionPresenterProtocol : WSWorkspaceSelectionPresenterProtocol!
    var vendors = [WSVendor]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureDependencies()
        
        self.tableView.register(UINib(nibName:"WSWorkspaceSelectionCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        //startAnimating(CGSize(width: 30, height: 30), message: "", type: NVActivityIndicatorType(rawValue: 1)!, color: UIColor.darkGray, backgroundColor: UIColor.clear)
        self.workspaceSelectionPresenterProtocol.didFetchVendors()
    }
    
    func configureDependencies() {
        let workspaceSelectionPresenter = WSWorkspaceSelectionPresenter()
        workspaceSelectionPresenter.workspaceSelectionViewProtocol = self
        self.workspaceSelectionPresenterProtocol = workspaceSelectionPresenter
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func returnCell(forIndexPath row : Int, _ section : Int? = 0) -> WSLoginCell! {
        return self.tableView.cellForRow(at: NSIndexPath.init(row: row, section: section!) as IndexPath)! as! WSLoginCell
    }
}

extension WSWorkspaceSelectionView : WSWorkspaceSelectionViewProtocol {
    func updateVendors(_ vendors : [WSVendor]) {
        self.vendors = vendors
        self.tableView.reloadData()
        self.stopViewAnimation()
    }

    func didFailedResponse<T>(_ error : T) {
        let error = error as! Error
        
        self.stopViewAnimation()
        self.showToastMessage(error.getDetailErrorInfo()!)
    }
    
    func presentController<T>(_ controller: T) {
        self.dismiss(animated: true) {
            AppDelegate.sharedDelegate.setRootViewController(controller as! UIViewController)
        }
    }
    
    func pushController<T>(_ vc: T) {
        self.navigationController?.pushViewController(vc as! UIViewController, animated: true)
    }
}

extension WSWorkspaceSelectionView : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 86
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let vendor = self.vendors[safe : indexPath.row] {
            self.workspaceSelectionPresenterProtocol.didSelectWorkspace(vendor: vendor)
        }
    }
}

extension WSWorkspaceSelectionView : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vendors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:WSWorkspaceSelectionCell = (tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WSWorkspaceSelectionCell)
        
        if let vendor = self.vendors[safe : indexPath.row] {
            cell.vendorNameLabel.text! = vendor.name!
            cell.vendorLogoImageView.kf.setImage(with: URL.init(string: vendor.vendorLogoUrl!))
        }
        return cell
    }
}
