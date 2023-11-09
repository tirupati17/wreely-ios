//
//  WSMeetingRoomListView.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 28/05/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation

class WSMeetingRoomListView : WSViewController, SideMenuItemContent {
    @IBOutlet var tableView : UITableView!
    var meetingRoomListPresenterProtocol : WSMeetingRoomListPresenterProtocol!
    var meetingRoomDashboard : WSMeetingRoomDashboard!
    
    @IBOutlet var monthLabel : UILabel!
    @IBOutlet var paidBookingLabel : UILabel!
    @IBOutlet var freeBookingLabel : UILabel!
    @IBOutlet var outOfLabel : UILabel!
    @IBOutlet var totalLabel : UILabel!

    var meetingRooms = [WSMeetingRoom]() {
        didSet {
            if (self.meetingRooms.count > 0) {
                self.tableView.removeNoResult()
            } else {
                self.tableView.showNoResult()
            }
            self.tableView.reloadData()
        }
    }
    
    override func loadView() {
        super.loadView()
        
        let rightButton = UIBarButtonItem.init(title: "History", style: .plain, target: self, action: #selector(self.showHistory))
        rightButton.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = rightButton
        self.title = "Meeting Room's"
        
        self.configureDependencies()
        self.tableView.addSubview(self.refreshControl)
        self.tableView.register(UINib(nibName:"WSMeetingRoomListCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startViewAnimation() //for initial load
    }
    
    func configureDependencies() {
        let meetingRoomListPresenter = WSMeetingRoomListPresenter()
        meetingRoomListPresenter.meetingRoomListViewProtocol = self
        self.meetingRoomListPresenterProtocol = meetingRoomListPresenter
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.meetingRoomListPresenterProtocol.didFetchMeetingRooms()
        self.meetingRoomListPresenterProtocol.didFetchMeetingRoomDashboard()
    }
    
    func updateDashboard(dashboard : WSMeetingRoomDashboard!) {
        if (dashboard == nil) {
            self.monthLabel.text = "NA"
            self.paidBookingLabel.text = "NA"
            self.freeBookingLabel.text = "NA"
            self.outOfLabel.text = "NA"
            self.totalLabel.text = "NA"
            return
        }
        self.meetingRoomDashboard = dashboard
        self.monthLabel.text = self.meetingRoomDashboard.month
        self.paidBookingLabel.text = self.meetingRoomDashboard.paidUsage
        self.freeBookingLabel.text = self.meetingRoomDashboard.freeRemaining
        self.outOfLabel.text = "out of " + self.meetingRoomDashboard.freeCredit!
        self.totalLabel.text = self.meetingRoomDashboard.totalUsage
    }
    
    func loadData() {
        self.meetingRoomListPresenterProtocol.didFetchMeetingRooms()
        self.meetingRoomListPresenterProtocol.didFetchMeetingRoomDashboard()
    }
    
    @objc func showHistory() {
        self.meetingRoomListPresenterProtocol.showHistory()
    }

    @objc func showMenu() {
        showSideMenu()
    }
}

extension WSMeetingRoomListView : WSMeetingRoomListViewProtocol  {
    
    func updateMeetingRooms(_ meetingRooms: [WSMeetingRoom]) {
        self.meetingRooms = meetingRooms
        self.stopViewAnimation()
    }
    
    func presentController<T>(_ vc: T) {

    }
    
    func pushController<T>(_ vc: T) {
        self.navigationController?.pushViewController(vc as! UIViewController, animated: true)
    }
}

extension WSMeetingRoomListView : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let meetingRoom = self.meetingRooms[safe : indexPath.row] {
            self.meetingRoomListPresenterProtocol.didSelectMeetingRoom(meetingRoom: meetingRoom)
        }
    }
}

extension WSMeetingRoomListView : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.meetingRooms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:WSMeetingRoomListCell = (tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WSMeetingRoomListCell)
        
        if let meetingRoom = self.meetingRooms[safe : indexPath.row] {
            cell.getLabel(WSMeetingRoomListCellUIControlTag.nameLabel.rawValue).text = meetingRoom.name
            cell.getLabel(WSMeetingRoomListCellUIControlTag.availabilityLabel.rawValue).text = meetingRoom.startTime! + " to " + meetingRoom.endTime!
            let thumbImageView = cell.getView(WSMeetingRoomListCellUIControlTag.thumbImageView.rawValue) as! UIImageView
            if let image = meetingRoom.images![safe : 0] {
                thumbImageView.kf.setImage(with: URL.init(string: image), placeholder: Image.init(named: "placeholder-image"))
            }
        }
        return cell
    }
}

extension WSMeetingRoomListView : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
}
