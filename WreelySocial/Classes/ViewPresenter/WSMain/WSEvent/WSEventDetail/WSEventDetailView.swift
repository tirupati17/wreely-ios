//
//  WSEventDetailView.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 15/01/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation
import Foundation
import UIKit
import Material
import NVActivityIndicatorView
import Kingfisher
import Letters
import InteractiveSideMenu

class WSEventDetailView : WSViewController, SideMenuItemContent {
    @IBOutlet var tableView : UITableView!
    var eventDetailPresenterProtocol : WSEventDetailPresenterProtocol!
    var event : WSEvent!
    
    override func loadView() {
        super.loadView()
        self.title = event.title
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureDependencies()
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.tableView.register(UINib(nibName: "WSEventDetailCell", bundle : nil), forCellReuseIdentifier: "cell")
        self.eventDetailPresenterProtocol.didFetchMoreDetail()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    func configureDependencies() {
        let eventDetailPresenter = WSEventDetailPresenter()
        eventDetailPresenter.eventDetailViewProtocol = self
        self.eventDetailPresenterProtocol = eventDetailPresenter
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func showMenu() {
        showSideMenu()
    }
    
    func returnCell(forIndexPath row : Int, _ section : Int? = 0) -> WSEventDetailCell! {
        return self.tableView.cellForRow(at: NSIndexPath.init(row: row, section: section!) as IndexPath)! as! WSEventDetailCell
    }
}

/**
 * Add here your methods for communication PRESENTER -> VIEW
 */

extension WSEventDetailView : WSEventDetailViewProtocol {
    
    func presentController<T>(_ vc: T) {
        
    }
    
    func pushController<T>(_ vc: T) {
        
    }
    
    func updateView(_ event: WSEvent) {
        self.event = event
    }
    
 }

extension WSEventDetailView : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 228
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension WSEventDetailView : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:WSEventDetailCell = (tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WSEventDetailCell)
        return cell
    }
}

extension WSEventDetailView : TextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
}
