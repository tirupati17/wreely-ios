//
//  WSEventListView.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 13/01/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import PopupDialog

class WSEventListView : WSViewController, SideMenuItemContent {
    @IBOutlet var tableView : UITableView!
    var eventListPresenterProtocol : WSEventListPresenterProtocol!
    var events = [WSEvent]() {
        didSet {
            if (self.events.count > 0) {
                self.tableView.removeNoResult()
            } else {
                self.tableView.showNoResult()
            }
            self.tableView.reloadData()
        }
    }
    
    override func loadView() {
        super.loadView()
        self.title = "Events"
        self.tableView.addSubview(self.refreshControl)
        self.configureDependencies()
        self.tableView.register(UINib(nibName: "WSEventListCell", bundle : nil), forCellReuseIdentifier: "cell")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.startViewAnimation() //for initial load
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadData()
    }
    
    func configureDependencies() {
        let eventListPresenter = WSEventListPresenter()
        eventListPresenter.eventListViewProtocol = self
        self.eventListPresenterProtocol = eventListPresenter
    }
    
    override func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.eventListPresenterProtocol.didFetchEvents()
    }
    
    func loadData() {
        self.eventListPresenterProtocol.didFetchEvents()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func showMenu() {
        showSideMenu()
    }
    
    func returnCell(forIndexPath row : Int, _ section : Int? = 0) -> WSEventListCell! {
        return self.tableView.cellForRow(at: NSIndexPath.init(row: row, section: section!) as IndexPath)! as! WSEventListCell
    }

    @objc func attendUnAttendAction(_ sender : WSButton) {
        sender.showLoading()
        if let event = self.events[safe : sender.indexIndentifier!] {
            if event.isAttending == 1 {
                self.eventListPresenterProtocol.unAttendEvent((event.id?.toString())!, success: { (response) in
                    sender.hideLoading()
                    self.eventListPresenterProtocol.didFetchEvents()
                }, failure: { (error) in
                    self.showToastMessage(error.getDetailErrorInfo()!)
                    sender.hideLoading()
                })
            } else {
                self.eventListPresenterProtocol.attendEvent((event.id?.toString())!, success: { (response) in
                    sender.hideLoading()
                    self.eventListPresenterProtocol.didFetchEvents()
                }, failure: { (error) in
                    self.showToastMessage(error.getDetailErrorInfo()!)
                    sender.hideLoading()
                })
            }
        }
    }
}

/**
 * Add here your methods for communication PRESENTER -> VIEW
 */

extension WSEventListView : WSEventListViewProtocol {
    
    func didFailedResponse<T>(_ error: T) {
        let error = error as! Error
        self.stopViewAnimation()
        self.showToastMessage(error.getDetailErrorInfo()!)
    }
    
    func presentController<T>(_ vc: T) {
        self.present(vc as! WSViewController, animated: true) {}
    }
    
    func pushController<T>(_ vc: T) {
        self.navigationController?.pushViewController(vc as! WSViewController, animated: true)
    }
    
    func updateView(_ events : [WSEvent]) {
        self.events = events
        self.stopViewAnimation()
    }
 }

extension WSEventListView : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 196
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let event = self.events[safe : indexPath.row] {
            let popUp = PopupDialog(title: event.title, message: event.description?.html2String)
            self.present(popUp, animated: true, completion: nil)
        }
    }
}

extension WSEventListView : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:WSEventListCell = (tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WSEventListCell)
        if let event = self.events[safe : indexPath.row] {
            cell.configureEventCell(event)
            let button = cell.getButton(WSEventListCellUIControlTag.attendUnAttendButton.rawValue) as! WSButton
            button.indexIndentifier = indexPath.row
            button.addTarget(self, action: #selector(self.attendUnAttendAction(_:)), for: .touchUpInside)
        }
        return cell
    }
}

extension WSEventListView : TextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
}
