//
//  WSOTPConfirmationView.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 09/07/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

struct WSOTPConfirmationViewItem {
    var otpCode : String = ""
    var mobileNumber : String  = ""
    var memberId : Int = 0
    
    init(_ otpCode : String? = "", mobileNumber : String? = "", memberId : Int? = 0) {
        self.otpCode = otpCode!
        self.mobileNumber = mobileNumber!
        self.memberId = memberId!
    }
}

class WSOTPConfirmationView : WSViewController {
    @IBOutlet var tableView : UITableView!
    var otpConfirmationPresenterProtocol : WSOTPConfirmationPresenterProtocol!
    var otpConfirmationViewItem = WSOTPConfirmationViewItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.configureDependencies()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func configureDependencies() {
        let otpConfirmationPresenter = WSOTPConfirmationPresenter()
        otpConfirmationPresenter.otpConfirmationViewProtocol = self //PRESENTER -> VIEW CONNECTION
        self.otpConfirmationPresenterProtocol = otpConfirmationPresenter //VIEW -> PRESENTER  CONNECTION
    }
    
    @IBAction func confirmPressed() {
        if self.otpConfirmationViewItem.otpCode.isEmpty {
            self.tableView.reloadData()
            return
        }
        
        self.startViewAnimation()
        self.otpConfirmationPresenterProtocol.confirmOTP(self.otpConfirmationViewItem)
    }
    
    @objc func resendAction() {
        //self.startViewAnimation()
        self.otpConfirmationPresenterProtocol.resendOTP(self.otpConfirmationViewItem.mobileNumber)
    }
}


extension WSOTPConfirmationView : WSOTPConfirmationViewProtocol {
    func didValidUser() {
        self.stopViewAnimation()
        self.otpConfirmationPresenterProtocol.showWorkspaceSelection()
    }
    
    func didSuccessfulResponse<T>(_ response: T) {
        self.otpConfirmationPresenterProtocol.fetchValidUser()
    }
    
    func didSuccessfulResentResponse<T>(_ response: T) {
        self.stopViewAnimation()
        self.showToastMessage("Sent!")
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


extension WSOTPConfirmationView : UITableViewDelegate {
    
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

extension WSOTPConfirmationView : UITableViewDataSource {
    
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
                let textField = cell.getField(WSOTPConfirmationCellUIControlTag.otpTextField.rawValue) as! ErrorTextField
                textField.delegate = self
                textField.keyboardType = .numbersAndPunctuation
                textField.placeholderActiveColor = UIColor.themeColor()
                textField.dividerActiveColor = UIColor.themeColor()
                if (self.otpConfirmationViewItem.otpCode.isEmpty) {
                    textField.isErrorRevealed = true
                }
                
                let resendButton = cell.getButton(WSOTPConfirmationCellUIControlTag.resendButton.rawValue)
                resendButton.addTarget(self, action: #selector(self.resendAction), for: .touchUpInside)
                
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

extension WSOTPConfirmationView : TextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(textField: TextField, didChange text: String?) {
        let errorTextField = textField as! ErrorTextField
        errorTextField.isErrorRevealed = false
        
        self.otpConfirmationViewItem.otpCode = text!
    }
}
