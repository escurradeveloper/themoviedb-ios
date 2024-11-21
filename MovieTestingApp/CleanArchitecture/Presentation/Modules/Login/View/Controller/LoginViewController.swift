//
//  LoginViewController.swift
//  MovieTestingApp
//
//  Created by Escurra Colquis
//

import UIKit

// MARK: - LoginViewControllerProtocol
protocol LoginViewControllerProtocol: AnyObject {
    func clearTextField()
    func showToast(message: String)
    func showModal(title: String, message: String)
}

class LoginViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var userTextField: UITextField?
    @IBOutlet weak var passwordTextField: UITextField?
    @IBOutlet weak var loginButton: UIButton?
    
    // MARK: - Properties
    var presenter: LoginPresenterProtocol?
    var loginConfigurator: LoginConfiguratorProtocol?
    var activeField: UITextField?
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLoginView()
        setupControl()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        setupGestureRecognizer()
    }
    
    // MARK: - Functions
    private func configureLoginView() {
        loginConfigurator = LoginConfigurator()
        loginConfigurator?.configureLoginView(viewController: self)
    }
    
    private func setupControl() {
        userTextField?.delegate = self
        passwordTextField?.delegate = self
        userTextField?.keyboardType = .alphabet
        passwordTextField?.keyboardType = .alphabet
        userTextField?.autocorrectionType = .no
        passwordTextField?.autocorrectionType = .no
        userTextField?.layer.cornerRadius = 20.0
        userTextField?.clipsToBounds = true
        passwordTextField?.layer.cornerRadius = 20.0
        passwordTextField?.clipsToBounds = true
        loginButton?.layer.cornerRadius = 30.0
        loginButton?.clipsToBounds = true
    }
    
    private func validateCheckName(textField: UITextField, maxLength: Int?) {
        let max = (maxLength != nil) ? (maxLength ?? 0) : 0
        if String(textField.text!.prefix(1)) == .withSpace || !textField.text!.isFormatName || textField.text!.count > max {
            textField.deleteBackward()
        }
    }
    
    private func validateCheckPassword(textField: UITextField, maxLength: Int?) {
        let max = (maxLength != nil) ? (maxLength ?? 0) : 0
        if !textField.text!.isAlphanumeric || textField.text!.count > max {
            textField.deleteBackward()
        }
    }
    
    fileprivate func endEditing() {
        self.view.endEditing(true)
    }
    
    // MARK: - IBActions
    @IBAction func didTapLogin(_ sender: UIButton) {
        let nameUser = userTextField?.text
        let passwordUser = passwordTextField?.text
        endEditing()
        presenter?.goToListMovie(name: nameUser, password: passwordUser)
    }
    
    @IBAction func userEditingChanged(_ sender: UITextField) {
        guard let textField = userTextField else {
            return
        }
        validateCheckName(textField: textField, maxLength: UserName.maximunNameLength.rawValue)
    }
    
    @IBAction func passwordEditingChanged(_ sender: UITextField) {
        guard let textField = passwordTextField else {
            return
        }
        validateCheckPassword(textField: textField, maxLength: PasswordName.maximunNameLength.rawValue)
    }
    
    // MARK: - UIStatusBarStyle
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

// MARK: LoginViewControllerProtocol
extension LoginViewController: LoginViewControllerProtocol {
    func clearTextField() {
        userTextField?.text = .empty
        passwordTextField?.text = .empty
    }
    
    func showToast(message: String) {
        Utils.showMessageTop(true, textBody: message)
    }
    
    func showModal(title: String, message: String) {
        Utils.routeToModal(title: title, subtitle: message, from: self, okTitle: NSLocalizedString("accept", comment: "accept"))
    }
}

// MARK: ModalInformationDelegate
extension LoginViewController: ModalInformationDelegate {
    func didTapAccept() {
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
}

// MARK: UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userTextField {
            self.passwordTextField?.becomeFirstResponder()
        } else if textField == passwordTextField {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        self.activeField = nil
    }
}

// MARK: UIGestureRecognizerDelegate
extension LoginViewController: UIGestureRecognizerDelegate {
    func setupGestureRecognizer() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc fileprivate func dismissKeyboard() {
        endEditing()
    }
}
