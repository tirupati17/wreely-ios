//
//  WSLoginView.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 19/12/17.
//  Copyright © 2017 Celerstudio. All rights reserved.
//

class WSLoginView : WSViewController {
    @IBOutlet var tableView : UITableView!
    var loginPresenterProtocol : WSLoginPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.configureDependencies()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func configureDependencies() {
        let loginPresenter = WSLoginPresenter()
        loginPresenter.loginViewProtocol = self //PRESENTER -> VIEW CONNECTION
        self.loginPresenterProtocol = loginPresenter //VIEW -> PRESENTER  CONNECTION
    }
    
    func returnCell(forIndexPath row : Int, _ section : Int? = 0) -> WSLoginCell! {
        return self.tableView.cellForRow(at: NSIndexPath.init(row: row, section: section!) as IndexPath)! as! WSLoginCell
    }
    
    func emailField() -> ErrorTextField {
        let textFieldCell = self.returnCell(forIndexPath: WSLoginCellFieldType.emailFieldType.rawValue) as! WSLoginTextFieldCell
        return textFieldCell.emailField();
    }
    
    func passwordField() -> ErrorTextField {
        let textFieldCell = self.returnCell(forIndexPath: WSLoginCellFieldType.passwordFieldType.rawValue) as! WSLoginTextFieldCell
        return textFieldCell.passwordField();
    }
    
    @IBAction func loginPressed() {
        if self.emailField().isEmpty {
            self.validationForField(.emailFieldType)
            return
        }
        if self.passwordField().isEmpty {
            self.validationForField(.passwordFieldType)
            return
        }
        self.startViewAnimation()
        self.loginPresenterProtocol.didLoginPressed(self.emailField().text!, password: self.passwordField().text!)
    }
    
    @objc func forgotPassPressed() {
        self.loginPresenterProtocol.showForgotPasswordView()
    }
}

/**
 * Add here your methods for communication PRESENTER -> VIEW
 */

extension WSLoginView : WSLoginViewProtocol {
    func validationForField(_ fieldType: WSLoginCellFieldType) {
        switch fieldType {
            case .emailFieldType:
                self.emailField().isErrorRevealed = true
            case .passwordFieldType:
                self.passwordField().isErrorRevealed = true
            default: break
            
        }
    }

    func loginSuccessful() {
        self.stopViewAnimation()
        self.loginPresenterProtocol.showWorkspaceSelectionView()
    }
    
    func loginFailed(_ error : Error) {
        self.stopViewAnimation()
        self.showToastMessage(error.localizedDescription)
    }
    
    func presentController<T>(_ vc: T) {
        self.present(vc as! UIViewController, animated: true) {
            
        }
    }
    
    func pushController<T>(_ vc: T) {
        self.navigationController?.pushViewController(vc as! UIViewController, animated: true)
    }
    
}

extension WSLoginView : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
            case 0, 1:
                return 100
            default:
                return 47
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension WSLoginView : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath.row) {
            case 0, 1:
                let cell:WSLoginTextFieldCell = (tableView.dequeueReusableCell(withIdentifier: "cell\(indexPath.row)", for: indexPath) as! WSLoginTextFieldCell)
                switch (indexPath.row) {
                    case 0:
                        cell.cellFieldType = .emailFieldType
                        cell.emailField().text = Defaults[.username]
                        break
                    case 1:
                        cell.cellFieldType = .passwordFieldType
                        cell.passwordField().text = Defaults[.password]
                        cell.forgotPassButton().addTarget(self, action: #selector(self.forgotPassPressed), for: .touchUpInside)

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

extension WSLoginView : TextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    func textField(textField: TextField, didChange text: String?) {
        self.emailField().isErrorRevealed = false
        self.passwordField().isErrorRevealed = false
    }
}

