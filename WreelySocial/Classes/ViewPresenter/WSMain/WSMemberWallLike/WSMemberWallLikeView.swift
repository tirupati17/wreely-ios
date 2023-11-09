//
//  WSMemberWallLikeView.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 10/09/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation

let memberWallLikeCellId = "memberWallLikeCell"

class WSMemberWallLikeView : WSViewController {
    var tableView : UITableView = UITableView()
    var memberWallLikePresenterProtocol : WSMemberWallLikePresenterProtocol!
    var memberWall : WSMemberWall? {
        didSet {
        }
    }
    
    var likes = [WSMemberWallLikes]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func loadView() {
        super.loadView()
        
        self.title = "Likes"
        self.configureDependencies()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startViewAnimation()
        self.memberWallLikePresenterProtocol.fetchLikes(forPost: memberWall!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func configureDependencies() {
        let memberWallLikePresenter = WSMemberWallLikePresenter()
        memberWallLikePresenter.memberWallLikeViewProtocol = self //PRESENTER -> VIEW CONNECTION
        self.memberWallLikePresenterProtocol = memberWallLikePresenter //VIEW -> PRESENTER  CONNECTION
        
        view.addSubview(tableView)
        view.addConstraintsWithFormat("H:|[v0]|", views: tableView)
        view.addConstraintsWithFormat("V:|[v0]|", views: tableView)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView.init()
        self.tableView.register(WSMemberWallLikeCell.self, forCellReuseIdentifier: memberWallLikeCellId)
    }
    
    @objc func showUserProfile(_ id : Int) {

    }
}

extension WSMemberWallLikeView : WSMemberWallLikeViewProtocol {
    func didSuccessfulResponse<T>(_ response: T) {
        self.likes = response as! [WSMemberWallLikes]
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

extension WSMemberWallLikeView : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension WSMemberWallLikeView : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.likes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:WSMemberWallLikeCell = tableView.dequeueReusableCell(withIdentifier: memberWallLikeCellId, for: indexPath) as! WSMemberWallLikeCell
        if let likeBy = self.likes[safe : indexPath.row] {
            cell.thumbImageView.kf.setImage(with: URL.init(string: likeBy.memberProfileImage!), placeholder: Image.init(named: "user-placeholder"))
            cell.titleLabel.text = likeBy.memberName
        }
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        cell.controller = self
        cell.accessoryType = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView.init()
    }
    
}


