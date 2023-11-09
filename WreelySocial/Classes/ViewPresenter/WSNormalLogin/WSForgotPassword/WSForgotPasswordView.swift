//
//  WSForgotPasswordView.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 20/12/17.
//  Copyright © 2017 Celerstudio. All rights reserved.
//

class WSForgotPasswordView : WSViewController {
    @IBOutlet var tableView : UITableView!
    var forgotPasswordPresenter = WSForgotPasswordPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureDependencies()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func configureDependencies() {
        self.forgotPasswordPresenter.forgotPasswordViewProtocol = self
    }

    func returnCell(forIndexPath row : Int, _ section : Int? = 0) -> WSForgotPasswordCell! {
        return self.tableView.cellForRow(at: NSIndexPath.init(row: row, section: section!) as IndexPath)! as! WSForgotPasswordCell
    }
    
    func emailField() -> ErrorTextField {
        let textFieldCell = self.returnCell(forIndexPath: WSForgotPasswordCellFieldType.emailFieldType.rawValue) as! WSForgotPasswordTextFieldCell
        return textFieldCell.emailField();
    }
    
    @IBAction func submitPressed() {
        self.forgotPasswordPresenter.didForgotPasswordPressed()
    }
    
    @IBAction func backButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
}

/**
 * Add here your methods for communication PRESENTER -> VIEW
 */

extension WSForgotPasswordView : WSForgotPasswordViewProtocol {
    func validationForField(_ fieldType: WSForgotPasswordCellFieldType) {
        switch fieldType {
            case .emailFieldType:
                self.emailField().isErrorRevealed = true
            default: break
        }
    }
    
    func submittedSuccessful() {
        self.stopViewAnimation()
        self.showToastMessage("Please check your inbox.")
        self.navigationController?.popViewController(animated: true)
    }
    
    func submitionFailed() {
        self.stopViewAnimation()
        self.showToastMessage("Oop's, email address not found.")
    }
}

extension WSForgotPasswordView : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 100
        default:
            return 47
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension WSForgotPasswordView : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath.row) {
            case 0:
                let cell:WSForgotPasswordTextFieldCell = (tableView.dequeueReusableCell(withIdentifier: "cell\(indexPath.row)", for: indexPath) as! WSForgotPasswordTextFieldCell)
                cell.cellFieldType = .emailFieldType
                cell.getField(cell.cellFieldType).delegate = self
                return cell
        default:
            break
        }
        return UITableViewCell.init()
    }
}

extension WSForgotPasswordView : TextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    func textField(textField: TextField, didChange text: String?) {
        self.emailField().isErrorRevealed = false
    }
}
