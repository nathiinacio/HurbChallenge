//
//  Login.swift
//  HurbChallenge
//
//  Created by Nathalia Inacio on 01/09/19.
//  Copyright © 2019 Nathalia Inacio. All rights reserved.
//

import UIKit
import Firebase

class Login: UIViewController {
    
    // MARK: - Initialization
    
    // MARK: Outlets
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
   
    // MARK: Variables
    var activityView:UIActivityIndicatorView!
    
    // MARK: View Cicle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        
        showLoginButton(button: loginButton)
        activityView = UIActivityIndicatorView(style: .gray)
        activityView.color = UIColor.white
        activityView.frame = CGRect(x: 0, y: 0, width: 50.0, height: 50.0)
        activityView.center = loginButton.center
        
        view.addSubview(activityView)
        
        emailTextField.delegate = self as? UITextFieldDelegate
        passwordTextField.delegate = self as? UITextFieldDelegate
        emailTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        
        setLoginButton(enabled: false)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emailTextField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        NotificationCenter.default.removeObserver(self)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return .lightContent
        }
    }
    
    @objc func keyboardWillAppear(notification: NSNotification){

        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue

        loginButton.center = CGPoint(x: view.center.x,
                                     y: view.frame.height - keyboardFrame.height - 16.0 - loginButton.frame.height / 2)
        activityView.center = self.loginButton.center
    }
    
    @objc func textFieldChanged(_ target:UITextField) {
        let email = emailTextField.text
        let password = passwordTextField.text
        let formFilled = email != nil && email != "" && password != nil && password != ""
        setLoginButton(enabled: formFilled)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        /// Resigns the target textField and assigns the next textField in the form.
        
        switch textField {
        case emailTextField:
            emailTextField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
            break
        case passwordTextField:
            handleSignIn()
            break
        default:
            break
        }
        return true
    }
    
    
    
    // MARK: Auxiliar
    @objc func handleSignIn() {
        guard let email = emailTextField.text else { return }
        guard let pass = passwordTextField.text else { return }
        
        setLoginButton(enabled: false)
        loginButton.setTitle("", for: .normal)
        activityView.startAnimating()
        
        UserManager.instance.login(withEmail: email, password: pass) { (error) in
            if error != nil {
                debugPrint(String(describing: error?.localizedDescription))
                debugPrint("Error logging in: \(error!.localizedDescription)")
                self.resetForm()
            } else {
                if UserManager.instance.currentUser != nil {
                    self.performSegue(withIdentifier: "goToMain", sender: self)
                } else {
                    debugPrint("Error logging in: \(error!.localizedDescription)")
                    self.resetForm()
                }
            }
        }
    }
    
    func resetForm() {
        
        let tentarNovamente = UIAlertAction(title: "Tentar Novamente", style: .default, handler: { (action) -> Void in
            self.emailTextField.text = ""
            self.passwordTextField.text = ""
        })
        
        let cancelar = UIAlertAction(title: "Cancelar", style: .default ) { (action) -> Void in
            self.dismiss()
        }
        
        let alert = UIAlertController(title: "Erro ao Logar", message: nil, preferredStyle: .alert)
        alert.addAction(tentarNovamente)
        alert.addAction(cancelar)
        self.present(alert, animated: true, completion: nil)
        alert.view.tintColor = UIColor.paletteBlue
        
        setLoginButton(enabled: true)
        loginButton.setTitle("Fazer Login", for: .normal)
        activityView.stopAnimating()
    }
    
    @objc private func dismiss() {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    /**
     Enables or Disables the **continueButton**.
     */
    
    func setLoginButton(enabled:Bool) {
        if enabled {
            loginButton.alpha = 1.0
            loginButton.isEnabled = true
        } else {
            loginButton.alpha = 0.5
            loginButton.isEnabled = false
        }
    }
    
   
    /// Button rounded corners
    func showLoginButton(button: UIButton) {
        button.layer.cornerRadius = 25
        button.clipsToBounds = true
        button.layer.masksToBounds = true
    }
    
    
    
    // MARK: Actions
    @IBAction func forgotPassword(_ sender: Any) {
        let forgotPasswordAlert = UIAlertController(title: "Esqueceu sua senha?", message: "Digite seu e-mail de login abaixo:", preferredStyle: .alert)
        forgotPasswordAlert.addTextField { (textField) in
            textField.placeholder = "Digite seu e-mail"
        }
        forgotPasswordAlert.view.tintColor = UIColor.paletteBlue
        forgotPasswordAlert.addAction(UIAlertAction(title: "Cancelar", style: .default, handler: nil))
        forgotPasswordAlert.addAction(UIAlertAction(title: "Redefinir senha", style: .default, handler: { (action) in
            let resetEmail = forgotPasswordAlert.textFields?.first?.text
            
            Auth.auth().sendPasswordReset(withEmail: resetEmail!, completion: { (error) in
                /// Make sure you execute the following code on the main queue
                DispatchQueue.main.async {
                    // Use "if let" to access the error, if it is non-nil
                    if let error = error {
                        debugPrint("error: \(error.localizedDescription)")
                        let resetFailedAlert = UIAlertController(title: "Redefinir senha falhou", message: "Não existe nenhuma conta com este e-mail", preferredStyle: .alert)
                        resetFailedAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                        resetFailedAlert.view.tintColor = UIColor.paletteBlue
                        self.present(resetFailedAlert, animated: true, completion: nil)
                    } else {
                        let resetEmailSentAlert = UIAlertController(title: "E-mail enviado com sucesso!", message: "Cheque seu e-mail para redefinir sua senha", preferredStyle: .alert)
                        resetEmailSentAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                        resetEmailSentAlert.view.tintColor = UIColor.paletteBlue
                        self.present(resetEmailSentAlert, animated: true, completion: nil)
                    }
                }
            })
        }))
        /// Present Alert
        self.present(forgotPasswordAlert, animated: true, completion: nil)
    }
    
    
    @IBAction func loginTaped(_ sender: Any) {
         handleSignIn()
    }
    

    
}
