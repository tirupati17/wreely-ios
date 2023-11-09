//
//  WSOTPView.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 09/07/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

class WSOTPView : WSViewController {
    @IBOutlet var tableView : UITableView!
    var otpPresenterProtocol : WSOTPPresenterProtocol!
    var mobileNumber : String = "" //use WSOTPViewItem struct 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.configureDependencies()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func configureDependencies() {
        let otpPresenter = WSOTPPresenter()
        otpPresenter.otpViewProtocol = self //PRESENTER -> VIEW CONNECTION
        self.otpPresenterProtocol = otpPresenter //VIEW -> PRESENTER  CONNECTION
    }
    
    @IBAction func skipPressed() {
        AppDelegate.sharedDelegate.showMainTab()
    }
    
    @IBAction func loginPressed() {
        if self.mobileNumber.isEmpty {
            self.tableView.reloadData()
            return
        }

        self.startViewAnimation()
        self.otpPresenterProtocol.sendNumberForOTP("+91", mobile: self.mobileNumber.removeWhitespace())
    }
}

extension WSOTPView : WSOTPViewProtocol {
    func didSuccessfulResponse<T>(_ response: T) {
        let response = response as JSON
        
        self.stopViewAnimation()
        self.otpPresenterProtocol.showOTPConfirmationView(WSOTPConfirmationViewItem.init("+91", mobileNumber: self.mobileNumber, memberId: response["member_id"] as? Int))
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

extension WSOTPView : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
            case 0, 1:
                return 120
            default:
                return 47
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension WSOTPView : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath.row) {
            case 0, 1:
                let cell:WSOTPCell = (tableView.dequeueReusableCell(withIdentifier: "cell\(indexPath.row)", for: indexPath) as! WSOTPCell)
                switch (indexPath.row) {
                    case 0:
                        let textField = cell.getField(WSOTPCellUIControlTag.mobileTextField.rawValue) as! ErrorTextField
                        textField.delegate = self
                        textField.placeholder = "Enter number"
                        textField.placeholderActiveColor = UIColor.themeColor()
                        textField.dividerActiveColor = UIColor.themeColor()
                        textField.keyboardType = .numbersAndPunctuation
                        if (self.mobileNumber.isEmpty) {
                            textField.isErrorRevealed = true
                        }
                        break
                    default:
                        break
                }
                return cell
            default:
                break
        }
        return UITableViewCell.init()
    }
}

extension WSOTPView : TextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(textField: TextField, didChange text: String?) {
        let errorTextField = textField as! ErrorTextField
        errorTextField.isErrorRevealed = false
        
        self.mobileNumber = text!
    }
}
