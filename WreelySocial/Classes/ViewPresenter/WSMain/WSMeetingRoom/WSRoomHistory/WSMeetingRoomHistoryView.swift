//
//  WSMeetingRoomHistoryView.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 26/06/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation
import ParallaxHeader

class WSMeetingRoomHistoryView : WSViewController {
    @IBOutlet var tableView : UITableView!
    var selectedMonth : Date = Date() {
        didSet {
            self.tableView.reloadData()
            self.startViewAnimation()
            loadDataFrom(selectedMonth.getStartOf(.kMonth).toServerDateString, endDate: selectedMonth.getEndOf(.kMonth).toServerDateString)
        }
    }
    var meetingRoomHistoryPresenterProtocol : WSMeetingRoomHistoryPresenterProtocol!
    var meetingRoomHistory = [WSMeetingRoomHistory]() {
        didSet {
            if (self.meetingRoomHistory.count > 0) {
                self.tableView.removeNoResult()
            } else {
                self.tableView.showNoResult()
            }
            self.tableView.reloadData()
        }
    }
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My Booking's"
        self.configureDependencies()
        self.tableView.register(UINib(nibName:"WSMeetingRoomHistoryCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.startViewAnimation()
    }
    
    func configureDependencies() {
        let meetingRoomHistoryPresenter = WSMeetingRoomHistoryPresenter()
        meetingRoomHistoryPresenter.meetingRoomHistoryViewProtocol = self
        self.meetingRoomHistoryPresenterProtocol = meetingRoomHistoryPresenter
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadDataFrom(selectedMonth.getStartOf(.kMonth).toServerDateString, endDate: selectedMonth.getEndOf(.kMonth).toServerDateString)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
        
    @objc func meetingRoomHistoryAction(_ sender : UIButton) {
        
        if let meetingRoomHistory = self.meetingRoomHistory[safe : Int(sender.accessibilityIdentifier!)!] {
            if meetingRoomHistory.isBookedByMe {
                _ = self.showCustomAlertView(title : "Are you sure?", message: "Looks like you want to cancel your booking.", okTitle: "Sure", cancelTitle: "No", okHandler: { (alert) in
                    sender.setImage(UIImage.init(named: "icn_checkbox_unselected_enabled"), for: .normal)
                    self.meetingRoomHistoryPresenterProtocol.didSelectMeetingRoomHistory(meetingRoomHistory: meetingRoomHistory)
                }, cancelHandler: { (alert) in
                    
                })
            }
        }
    }
    
    @objc func leftAction() {
        let date = self.selectedMonth
        self.selectedMonth = Date.init(year: date.year, month: date.month - 1, day: date.day)
    }
    
    @objc func rightAction() {
        let date = self.selectedMonth
        self.selectedMonth = Date.init(year: date.year, month: date.month + 1, day: date.day)
    }
    
    func loadDataFrom(_ startDate : String, endDate : String) {
        self.meetingRoomHistoryPresenterProtocol.didFetchMeetingRoomHistory("\(WSSession.activeSession().currentUser().id!)", startDate: startDate, endDate: endDate)
    }

}

extension WSMeetingRoomHistoryView : WSMeetingRoomHistoryViewProtocol  {
    
    func updateMeetingRoomHistory(_ meetingRoomHistory : [WSMeetingRoomHistory]) {
        self.meetingRoomHistory = meetingRoomHistory
        self.stopViewAnimation()
    }
    
    func presentController<T>(_ vc: T) {
        
    }
    
    func pushController<T>(_ vc: T) {
        self.navigationController?.pushViewController(vc as! UIViewController, animated: true)
    }
    
    func didCancelSuccessful() {
        self.stopViewAnimation()
        self.showToastMessage("Successfully cancelled.")
        loadDataFrom(selectedMonth.getStartOf(.kMonth).toServerDateString, endDate: selectedMonth.getEndOf(.kMonth).toServerDateString)
    }
    
    func didFailedResponse(_ error : Error) {
        self.stopViewAnimation()
        self.showToastMessage(error.localizedDescription)
    }
    
}

extension WSMeetingRoomHistoryView : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let meetingRoomHistory = self.meetingRoomHistory[safe : indexPath.row] {
            if meetingRoomHistory.isBookedByMe && meetingRoomHistory.isCancellable {
                _ = self.showCustomAlertView(title : "Are you sure?", message: "Looks like you want to cancel your booking.", okTitle: "Sure", cancelTitle: "No", okHandler: { (alert) in
                    self.meetingRoomHistoryPresenterProtocol.didSelectMeetingRoomHistory(meetingRoomHistory: meetingRoomHistory)
                }, cancelHandler: { (alert) in
                    
                })
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let footerView = UIView.init(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.view.width, height: 50)))
        
        let leftRightButtonWidth = (footerView.width/2)/2
        
        let leftButton = UIButton.init(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: leftRightButtonWidth, height: 50)))
        leftButton.setImage(UIImage.init(named: "angle-left"), for: .normal)
        leftButton.backgroundColor = UIColor.white
        leftButton.addTarget(self, action: #selector(leftAction), for: .touchUpInside)
        footerView.addSubview(leftButton)
        
        let centerLabel = UILabel.init(frame: CGRect(origin: CGPoint(x: leftButton.right, y: 0), size: CGSize(width: footerView.width/2 + 1, height: 50)))
        centerLabel.backgroundColor = UIColor.white
        centerLabel.font = UIFont.getAppMediumFont(size: 14)
        centerLabel.textColor = UIColor.darkGray
        centerLabel.textAlignment = .center
        footerView.addSubview(centerLabel)
        
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "MMM"
        centerLabel.text = dateFormatter.string(from: self.selectedMonth)
        
        let rightButton = UIButton.init(frame: CGRect(origin: CGPoint(x: centerLabel.right, y: 0), size: CGSize(width: leftRightButtonWidth, height: 50)))
        rightButton.setImage(UIImage.init(named: "angle-right"), for: .normal)
        rightButton.backgroundColor = UIColor.white
        rightButton.addTarget(self, action: #selector(rightAction), for: .touchUpInside)
        footerView.addSubview(rightButton)

        return footerView
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return self.meetingRoomHistory.count > 0 ? 50 : 0
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView.init(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.view.width, height: 50)))
        let footerLeftLabel = UILabel.init(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: footerView.width/2, height: 50)))
        footerLeftLabel.backgroundColor = UIColor.white
        footerLeftLabel.font = UIFont.getAppMediumFont(size: 23)
        footerLeftLabel.textColor = UIColor.darkGray
        footerLeftLabel.textAlignment = .center
        footerView.addSubview(footerLeftLabel)
        footerLeftLabel.text = "Total Bookings"
        
        let footerRightLabel = UILabel.init(frame: CGRect(origin: CGPoint(x: footerView.width/2, y: 0), size: CGSize(width: footerView.width/2, height: 50)))
        footerRightLabel.width = footerView.width/2
        footerRightLabel.backgroundColor = UIColor.white
        footerRightLabel.font = UIFont.getAppMediumFont(size: 23)
        footerRightLabel.textColor = UIColor.themeColor()
        footerRightLabel.textAlignment = .center
        footerView.addSubview(footerRightLabel)
        footerRightLabel.text = "\(self.meetingRoomHistory.count)"
        return footerView
    }

}

extension WSMeetingRoomHistoryView : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.meetingRoomHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:WSMeetingRoomHistoryCell = (tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WSMeetingRoomHistoryCell)
        
        if let meetingRoomHistory = self.meetingRoomHistory[safe : indexPath.row] {
            cell.getLabel(WSMeetingRoomHistoryCellUIControlTag.nameLabel.rawValue).text = meetingRoomHistory.meetingRoomName
            cell.getLabel(WSMeetingRoomHistoryCellUIControlTag.timeLabel.rawValue).text = (meetingRoomHistory.startTime?.toServerDate.toTimeString)! + "-" + (meetingRoomHistory.endTime?.toServerDate.toTimeString)!
            let selectionButton = cell.getButton(WSMeetingRoomHistoryCellUIControlTag.selectionButton.rawValue)
            if meetingRoomHistory.isCancellable {
                selectionButton.isEnabled = true
                selectionButton.setImage(UIImage.init(named: "icn_checkbox_selected_enabled"), for: .normal)
                selectionButton.accessibilityIdentifier = "\(indexPath.row)"
                selectionButton.addTarget(self, action: #selector(self.meetingRoomHistoryAction(_:)), for: .touchUpInside)
            } else {
                selectionButton.isEnabled = false
                selectionButton.setImage(UIImage.init(named: "icn_checkbox_selected_disabled"), for: .normal)
            }
        }
        return cell
    }
}

extension WSMeetingRoomHistoryView : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
}
