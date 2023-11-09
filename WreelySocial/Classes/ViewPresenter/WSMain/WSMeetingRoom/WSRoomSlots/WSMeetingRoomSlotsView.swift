//
//  WSMeetingRoomSlotsView.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 25/06/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation
import ParallaxHeader
import ScrollableDatepicker

class WSMeetingRoomSlotsView : WSViewController, SideMenuItemContent {
    @IBOutlet var tableView : UITableView!
    var meetingRoomSlotsPresenterProtocol : WSMeetingRoomSlotsPresenterProtocol!
    var meetingRoomSlots = [WSMeetingRoomSlot]() {
        didSet {
            if meetingRoomSlots.count == 0 {
                self.showToastMessage("Sorry, no slots available for bookings.")
            }
        }
    }
    var selectedMeetingRoom : WSMeetingRoom!
    @IBOutlet weak var scrollableDatepicker : ScrollableDatepicker! {
        didSet {
            var dates = [Date]()
            for day in 0...6 {
                dates.append(Date.init().addDay(day))
            }
            scrollableDatepicker.dates = dates
            scrollableDatepicker.selectedDate = Date()
            scrollableDatepicker.delegate = self
            var configuration = Configuration()
            
            // weekend customization
            configuration.selectedDayStyle.dateTextFont = UIFont.getAppBoldFont(size: 14)
            configuration.defaultDayStyle.dateTextFont = UIFont.getAppBoldFont(size: 14)
            configuration.weekendDayStyle.dateTextFont = UIFont.getAppBoldFont(size: 14)
            
            configuration.defaultDayStyle.weekDayTextColor = UIColor.themeColor()
            configuration.weekendDayStyle.dateTextColor = UIColor.darkGray
            
            // selected date customization
            configuration.selectedDayStyle.backgroundColor = UIColor(white: 0.9, alpha: 1)
            configuration.daySizeCalculation = .numberOfVisibleItems(5)
            configuration.selectedDayStyle.selectorColor = UIColor.themeColor()
            scrollableDatepicker.configuration = configuration
        }
    }
    
    override func loadView() {
        super.loadView()
        
        let imageView = UIImageView()
        if ((self.selectedMeetingRoom.images?.count) != 0) {
            imageView.kf.setImage(with: URL.init(string: (self.selectedMeetingRoom.images?.first)!))
        } else {
            imageView.image = UIImage(named: "placeholder-image.png")
        }
        imageView.contentMode = .scaleAspectFill
        tableView.parallaxHeader.view = imageView
        tableView.parallaxHeader.height = 180
        tableView.parallaxHeader.minimumHeight = 0
        tableView.parallaxHeader.mode = .topFill
        self.title = self.selectedMeetingRoom.name
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureDependencies()
        DispatchQueue.main.async {
            self.scrollableDatepicker.scrollToSelectedDate(animated: false)
            self.tableView.register(UINib(nibName:"WSMeetingRoomSlotsCell", bundle: nil), forCellReuseIdentifier: "cell")
        }
        self.meetingRoomSlotsPresenterProtocol.didFetchMeetingRoomSlots(self.selectedMeetingRoom.id.toString(), startDate: (self.scrollableDatepicker.selectedDate?.getStartOf(.kDay).toServerDateString)!, endDate: (self.scrollableDatepicker.selectedDate?.getEndOf(.kDay).toServerDateString)!)
    }
    
    func configureDependencies() {
        let meetingRoomSlotsPresenter = WSMeetingRoomSlotsPresenter()
        meetingRoomSlotsPresenter.meetingRoomSlotsViewProtocol = self
        self.meetingRoomSlotsPresenterProtocol = meetingRoomSlotsPresenter
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func showMenu() {
        showSideMenu()
    }
    
    @objc func meetingRoomSlotAction(_ sender : UIButton) {
        if let meetingRoomSlot = self.meetingRoomSlots[safe : Int(sender.accessibilityIdentifier!)!] {
            if meetingRoomSlot.isBookedByMe {
                _ = self.showCustomAlertView(title : "Are you sure?", message: "Looks like you want to cancel your booking.", okTitle: "Sure", cancelTitle: "No", okHandler: { (alert) in
                    sender.setImage(UIImage.init(named: "icn_checkbox_unselected_enabled"), for: .normal)
                    self.meetingRoomSlotsPresenterProtocol.didSelectMeetingRoomSlot(meetingRoomSlot: meetingRoomSlot)
                }, cancelHandler: { (alert) in
                    
                })
            } else {
                _ = self.showCustomAlertView(title : "Confirm?", message: meetingRoomSlot.isFreeCreditUsed == 1 ? "You have used your all available free hours. Now you will be charge for this slot booking. Please confirm to book this slot." : "Please confirm to book this slot.", okTitle: "Confirm", cancelTitle: "No", okHandler: { (alert) in
                    sender.setImage(UIImage.init(named: "icn_checkbox_selected_enabled"), for: .normal)
                    self.meetingRoomSlotsPresenterProtocol.didSelectMeetingRoomSlot(meetingRoomSlot: meetingRoomSlot)
                }, cancelHandler: { (alert) in
                    
                })
            }
        }
    }
    
}

extension WSMeetingRoomSlotsView: ScrollableDatepickerDelegate {
    
    func datepicker(_ datepicker: ScrollableDatepicker, didSelectDate date: Date) {
        self.startViewAnimation()
        self.meetingRoomSlotsPresenterProtocol.didFetchMeetingRoomSlots(self.selectedMeetingRoom.id.toString(), startDate: date.getStartOf(.kDay).toServerDateString, endDate: date.getEndOf(.kDay).toServerDateString)
    }
}

extension WSMeetingRoomSlotsView : WSMeetingRoomSlotsViewProtocol  {
    
    func updateMeetingRoomSlots(_ meetingRoomSlots : [WSMeetingRoomSlot]) {
        self.meetingRoomSlots = meetingRoomSlots.filter({ (room) -> Bool in
            return !(room.startTime?.toServerDate.isPastDate)!
        })
        
        self.tableView.reloadData()
        self.stopViewAnimation()
    }
    
    func presentController<T>(_ vc: T) {
        
    }
    
    func pushController<T>(_ vc: T) {
        self.navigationController?.pushViewController(vc as! UIViewController, animated: true)
    }
    
    func didCancelSuccessfull() {
        self.stopViewAnimation()
        self.showToastMessage("Successfully cancelled.")
        self.meetingRoomSlotsPresenterProtocol.didFetchMeetingRoomSlots(self.selectedMeetingRoom.id.toString(), startDate: (self.scrollableDatepicker.selectedDate?.getStartOf(.kDay).toServerDateString)!, endDate: (self.scrollableDatepicker.selectedDate?.getEndOf(.kDay).toServerDateString)!)
    }
    
    func didBookingSuccessfull() {
        self.stopViewAnimation()
        self.showToastMessage("Successfully booked.")
        self.meetingRoomSlotsPresenterProtocol.didFetchMeetingRoomSlots(self.selectedMeetingRoom.id.toString(), startDate: (self.scrollableDatepicker.selectedDate?.getStartOf(.kDay).toServerDateString)!, endDate: (self.scrollableDatepicker.selectedDate?.getEndOf(.kDay).toServerDateString)!)
    }
    
    func didFailedResponse(_ error : Error) {
        self.stopViewAnimation()
        self.showToastMessage(error.localizedDescription)
    }
    
    func didCancelFailedResponse(_ error : Error) {
        self.stopViewAnimation()
        self.showToastMessage("Oop's sorry, Looks like there is no such bookings or only 2 hour prior meeting room bookings are cancellable.")
        
        self.meetingRoomSlotsPresenterProtocol.didFetchMeetingRoomSlots(self.selectedMeetingRoom.id.toString(), startDate: (self.scrollableDatepicker.selectedDate?.getStartOf(.kDay).toServerDateString)!, endDate: (self.scrollableDatepicker.selectedDate?.getEndOf(.kDay).toServerDateString)!)
    }
}

extension WSMeetingRoomSlotsView : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let meetingRoomSlot = self.meetingRoomSlots[safe : indexPath.row] {
            if (meetingRoomSlot.availableStatus == 0) {
                return
            }
            if meetingRoomSlot.isBookedByMe {
                _ = self.showCustomAlertView(title : "Are you sure?", message: "Looks like you want to cancel your booking.", okTitle: "Sure", cancelTitle: "No", okHandler: { (alert) in
                    self.meetingRoomSlotsPresenterProtocol.didSelectMeetingRoomSlot(meetingRoomSlot: meetingRoomSlot)
                }, cancelHandler: { (alert) in
                    
                })
            } else {
                _ = self.showCustomAlertView(title : "Confirm?", message: "Please confirm to book this slot.", okTitle: "Confirm", cancelTitle: "No", okHandler: { (alert) in
                    self.meetingRoomSlotsPresenterProtocol.didSelectMeetingRoomSlot(meetingRoomSlot: meetingRoomSlot)
                }, cancelHandler: { (alert) in
                    
                })
            }
        }
    }
}

extension WSMeetingRoomSlotsView : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.meetingRoomSlots.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:WSMeetingRoomSlotsCell = (tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WSMeetingRoomSlotsCell)
        
        if let meetingRoomSlot = self.meetingRoomSlots[safe : indexPath.row] {
            cell.getLabel(WSMeetingRoomSlotsCellUIControlTag.nameLabel.rawValue).text = (meetingRoomSlot.startTime?.toServerDate.toTimeString)! + "-" + (meetingRoomSlot.endTime?.toServerDate.toTimeString)!
            let selectionButton = cell.getButton(WSMeetingRoomSlotsCellUIControlTag.selectionButton.rawValue)
            if meetingRoomSlot.availableStatus == 1 {
                selectionButton.setImage(UIImage.init(named: meetingRoomSlot.isBookedByMe ? "icn_checkbox_selected_enabled" : "icn_checkbox_unselected_enabled"), for: .normal)
                selectionButton.isEnabled = true
                selectionButton.accessibilityIdentifier = "\(indexPath.row)"
                selectionButton.addTarget(self, action: #selector(self.meetingRoomSlotAction(_:)), for: .touchUpInside)
            } else {
                selectionButton.isEnabled = false
                selectionButton.setImage(UIImage.init(named: "icn_checkbox_selected_disabled"), for: .normal)
            }
        }
        return cell
    }
}

extension WSMeetingRoomSlotsView : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
}
