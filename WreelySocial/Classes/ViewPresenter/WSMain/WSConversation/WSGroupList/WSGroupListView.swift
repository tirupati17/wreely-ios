//
//  WSGroupListView.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 17/09/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation

let groupListCell = "groupListCell"

class WSGroupListView : WSViewController {
    var tableView : UITableView!
    var groupListPresenterProtocol : WSGroupListPresenterProtocol!
    
    var vendors = [WSVendor]() {
        didSet {
            tableView.reloadData()
        }
    }
    var members = [WSMember]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func loadView() {
        super.loadView()
        
        self.title = "Conversations"
        self.configureDependencies()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startViewAnimation()
        self.groupListPresenterProtocol.didFetchVendors()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)        
        self.groupListPresenterProtocol.didFetchMembers()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func configureDependencies() {
        let groupListPresenter = WSGroupListPresenter()
        groupListPresenter.groupListViewProtocol = self //PRESENTER -> VIEW CONNECTION
        self.groupListPresenterProtocol = groupListPresenter //VIEW -> PRESENTER  CONNECTION
        
        self.tableView = UITableView.init(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.view.width, height: self.view.height - kTabBarHeight)))
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.separatorInset = UIEdgeInsets(top: 0, left: 1000, bottom: 0, right: 0)
        self.view.addSubview(self.tableView)
        
        self.tableView.tableFooterView = UIView.init()
        self.tableView.register(WSGroupListCell.self, forCellReuseIdentifier: groupListCell)
    }
    
}

extension WSGroupListView : WSGroupListViewProtocol {
    
    
    func updateMembers(_ members : [WSMember]) {
        self.members = members.filter({ (member) -> Bool in
            if (member.id == WSSession.activeSession().currentUser().id || member.memberFirKey?.isEmpty == true) {
                return false
            }
            return true
        })
        self.stopViewAnimation()
    }
    
    func updateGroupList(_ response: [WSVendor]) {
        self.vendors = response
        self.stopViewAnimation()
    }
    
    func didSuccessfulResponse<T>(_ response: T) {
        print(response)
        self.stopViewAnimation()
    }
    
    func didFailedResponse<T>(_ error: T) {
        let error = error as! Error
        
        self.stopViewAnimation()
        self.showToastMessage(error.getDetailErrorInfo()!)
    }
    
    func presentController<T>(_ vc: T) {
        self.present(vc as! UIViewController, animated: true) {}
    }
    
    func pushController<T>(_ vc: T) {
        self.navigationController?.pushViewController(vc as! UIViewController, animated: true)
    }
}

extension WSGroupListView : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
            case 0:
                if let vendor = self.vendors[safe : indexPath.row] {
                    let vc = TBChatViewController()
                    vc.selectedVendor = vendor
                    vc.firebaseDatabaseRef = .groupChat
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                break
            default:
                if let member = self.members[safe : indexPath.row] {
                    let vc = TBChatViewController()
                    vc.selectedUser = member
                    vc.firebaseDatabaseRef = .oneToOneChat
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                break
        }
    }
}

extension WSGroupListView : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? self.vendors.count : self.members.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:WSGroupListCell = tableView.dequeueReusableCell(withIdentifier: groupListCell, for: indexPath) as! WSGroupListCell
        
        cell.accessoryType = .disclosureIndicator
        switch indexPath.section {
            case 0:
                if let vendor = self.vendors[safe : indexPath.row] {
                    cell.vendor = vendor
                }
                break
            default:
                if let member = self.members[safe : indexPath.row] {
                    cell.member = member
                }
                break
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 40 : 25
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewObj = UILabel.init(frame: CGRect(x: 0, y: 0, width: self.view.width, height: section == 0 ? 40 : 25))
        viewObj.backgroundColor = UIColor.white
        let titleLabel = UILabel.init(frame: CGRect(x: 20, y: 0, width: self.view.width - 20, height: section == 0 ? 40 : 25))
        titleLabel.numberOfLines = 1
        titleLabel.font = UIFont.getAppBoldFont(size: 14)
        titleLabel.textColor = UIColor.lightGray
        titleLabel.backgroundColor = UIColor.white
        titleLabel.text = section == 0 ? "Your groups" : "Active members (\(self.members.count))"
        viewObj.addSubview(titleLabel)
        return viewObj
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView.init()
    }
    
}
