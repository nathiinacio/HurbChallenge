//
//  CreateNewAccount.swift
//  HurbChallenge
//
//  Created by Nathalia Inacio on 05/09/19.
//  Copyright © 2019 Nathalia Inacio. All rights reserved.
//

import UIKit
import Firebase

class CreateNewAccount: UIViewController {
    
    // MARK: - Initialization
    
    // MARK: Outlets
    @IBOutlet weak var createNewAccountButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmationTextField: UITextField!
    
    // MARK: Variables
    var activityView:UIActivityIndicatorView!
    
    // MARK: View Cicle
    override func viewDidLoad() {
        
        //Button rounded corners
        showCreateNewAccountButton(button: createNewAccountButton)
        
        activityView = UIActivityIndicatorView(style: .gray)
        activityView.color = UIColor.white
        activityView.frame = CGRect(x: 0, y: 0, width: 50.0, height: 50.0)
        activityView.center = self.createNewAccountButton.center
        
        
        emailTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        passwordConfirmationTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        nameTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        
        view.addSubview(activityView)
        setcreateNewAccountButton(enabled: false)
 
    }

 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nameTextField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        passwordConfirmationTextField.resignFirstResponder()
        nameTextField.resignFirstResponder()
        
        NotificationCenter.default.removeObserver(self)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get { return .lightContent }
    }
    
    @objc func keyboardWillAppear(notification: NSNotification){
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        createNewAccountButton.center = CGPoint(x: view.center.x,
                                                y: view.frame.height - keyboardFrame.height - 16.0 - createNewAccountButton.frame.height / 2)
        activityView.center = createNewAccountButton.center
    }
    
    
    @objc func textFieldChanged(_ target:UITextField) {
        let email = emailTextField.text
        let passwordConfirmed = passwordConfirmationTextField.text
        let password = passwordTextField.text
        let name = nameTextField.text
        
        let formFilled = email != nil && email != "" && passwordConfirmed != nil && passwordConfirmed != "" && password != nil && password != "" && name != nil && name != ""
        setcreateNewAccountButton(enabled: formFilled)
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameTextField:
            nameTextField.resignFirstResponder()
            emailTextField.becomeFirstResponder()
        case emailTextField:
            emailTextField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
            break
        case passwordTextField:
            passwordTextField.resignFirstResponder()
            passwordConfirmationTextField.becomeFirstResponder()
            break
        case passwordConfirmationTextField:
            handleSignUp()
            break
        default:
            break
        }
        return true
    }
    
    
    @objc func handleSignUp() {
        guard let email = emailTextField.text else { return }
        guard let pass = passwordTextField.text else { return }
        guard let name = nameTextField.text else { return }
        
        setcreateNewAccountButton(enabled: false)
        createNewAccountButton.setTitle("", for: .normal)
        activityView.startAnimating()
        
        
        
        Auth.auth().fetchProviders(forEmail: email, completion: { (stringArray, error) in
            if error != nil {
                debugPrint(error!)
            } else {
                if stringArray == nil {
                    debugPrint("No password. No active account")
                    Auth.auth().createUser(withEmail: email, password: pass) { user, error in
                        if error == nil && user != nil {
                            debugPrint("User created!")
                            let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                            changeRequest?.displayName = name
                            UserManager.instance.currentUser =  user?.user.uid
                            changeRequest?.commitChanges { error in
                                if error == nil {
                                    debugPrint("User display name changed!")
                                    Auth.auth().currentUser?.sendEmailVerification(completion:
                                        {(error) in
                                            if error == nil {
                                                
                                                let reenviar = UIAlertAction(
                                                    title: "Não recebi, reenviar!",
                                                    style: .default) {
                                                        (_) in Auth.auth().currentUser?.sendEmailVerification(completion: nil)
                                                }
                                                
                                                let ok = UIAlertAction(
                                                    title: "Ok, verifiquei!",
                                                    style: .default,
                                                    handler: { (action) -> Void in
                                                        Auth.auth().currentUser?.reload(completion: { (err) in
                                                            if err == nil {
                                                                if Auth.auth().currentUser!.isEmailVerified {
                                                                    debugPrint("VERIFIED")
                                                                    
                                                                    self.saveProfile(username: name) { success in
                                                                        if success {
                                                                            self.dismiss(animated: true, completion: nil)
                                                                        } else {
                                                                            self.resetForm()
                                                                            Auth.auth().currentUser?.delete(completion: nil)
                                                                        }
                                                                    }
                                                                } else {
                                                                    debugPrint("It aint verified yet")
                                                                    let alertVC = UIAlertController(
                                                                        title: "Erro",
                                                                        message: "Desculpe. Seu e-mail ainda não foi verificado, deseja reenviar o e-mail de verificação para \(email)?",
                                                                        preferredStyle: .alert)
                                                                    
                                                                    let alertActionOkay = UIAlertAction(
                                                                        title: "Reenviar",
                                                                        style: .default) {
                                                                            (_) in Auth.auth().currentUser?.sendEmailVerification(completion: nil)
                                                                    }
                                                                    
                                                                    let alertActionVerified = UIAlertAction(
                                                                        title: "Ok, verifiquei!", style: .default,
                                                                        handler: { (action) -> Void in
                                                                            Auth.auth().currentUser?.reload()
                                                                            if (!(Auth.auth().currentUser?.isEmailVerified)!) {
                                                                                
                                                                            } else {
                                                                                self.saveProfile(username: name) { success in
                                                                                    if success {
                                                                                        self.dismiss(animated: true, completion: nil)
                                                                                    } else {
                                                                                        self.resetForm()
                                                                                    }
                                                                                }
                                                                            }
                                                                    })
                                                                    
                                                                    let alertActionCancel = UIAlertAction(
                                                                        title: "Cancelar",
                                                                        style: .default) {
                                                                            (_) in
                                                                            Auth.auth().currentUser?.delete(completion: nil)
                                                                            self.dismiss()
                                                                    }
                                                                    
                                                                    
                                                                    alertVC.addAction(alertActionOkay)
                                                                    alertVC.addAction(alertActionVerified)
                                                                    alertVC.addAction(alertActionCancel)
                                                                    
                                                                    alertVC.view.tintColor = UIColor.paletteBlue
                                                                    self.present(alertVC, animated: true, completion: nil)
                                                                    
                                                                }
                                                            } else {
                                                                
                                                                debugPrint(err?.localizedDescription ?? "")
                                                            }
                                                        })
                                                })
                                                
                                                let alert = UIAlertController(
                                                    title: "E-mail de verificação",
                                                    message: "Um e-mail de verificação foi enviado, por favor cheque seu e-mail! Não esqueça de checar em spam!",
                                                    preferredStyle: .alert)
                                                alert.addAction(ok)
                                                alert.addAction(reenviar)
                                                self.present(alert, animated: true, completion: nil)
                                                alert.view.tintColor = UIColor.paletteBlue
                                                
                                                
                                                
                                            } else {
                                                let ok = UIAlertAction(
                                                    title: "Ok",
                                                    style: .default,
                                                    handler: { (action) -> Void in
                                                })
                                                let alert = UIAlertController(
                                                    title: "Erro",
                                                    message: "Erro no envio do e-mail de verificação",
                                                    preferredStyle: .alert)
                                                alert.addAction(ok)
                                                self.present(alert, animated: true, completion: nil)
                                                alert.view.tintColor = UIColor.paletteBlue
                                            }
                                    })
                                } else {
                                    debugPrint("Error: \(error!.localizedDescription)")
                                    self.resetForm()
                                    Auth.auth().currentUser?.delete(completion: nil)
                                }
                            }
                            
                        } else {
                            self.resetForm()
                            Auth.auth().currentUser?.delete(completion: nil)
                        }
                    }
                    
                } else {
                    debugPrint("There is an active account")
                    let tentarNovamente = UIAlertAction(
                        title: "Tentar Novamente",
                        style: .default,
                        handler: { (action) -> Void in
                            self.emailTextField.text = ""
                            self.passwordConfirmationTextField.text = ""
                            self.passwordTextField.text = ""
                            self.nameTextField.text = ""
                            Auth.auth().currentUser?.delete(completion: nil)
                          
                    })
                    
                    let cancelar = UIAlertAction(title: "Cancelar", style: .default ) { (action) -> Void in
                        self.dismiss()
                        Auth.auth().currentUser?.delete(completion: nil)
                    }
                    
                    let alert = UIAlertController(
                        title: "Oops...",
                        message: "E-mail já usado anteriormente",
                        preferredStyle: .alert)
                    alert.addAction(tentarNovamente)
                    alert.addAction(cancelar)
                    self.present(alert, animated: true, completion: nil)
                    alert.view.tintColor = UIColor.paletteBlue
                    self.setcreateNewAccountButton(enabled: true)
                    self.createNewAccountButton.setTitle("Criar Conta", for: .normal)
                    self.activityView.stopAnimating()
                }
            }
        })
    }
    
    
    func saveProfile(username:String, completion: @escaping ((_ success:Bool)->())) {
        guard let uid = UserManager.instance.currentUser  else { return }
        AppSettings.displayName = username
        
        FBRef.users.document("\(uid)").setData(["username": username]) { err in
            if let err = err {
                debugPrint("Error writing document: \(err.localizedDescription)")
            } else {
                debugPrint("Document successfully written!")
                FBRef.users.document("\(uid)").collection("myFavoriteHotels").document("first").setData(["id" : ""])
                FBRef.users.document("\(uid)").collection("myFavoritePackages").document("first").setData(["id" : ""])
                self.performSegue(withIdentifier: "thankScreen", sender: self)
            }
        }
    }
    
    func resetForm() {
        let tentarNovamente = UIAlertAction(
            title: "Tentar Novamente",
            style: .default,
            handler: { (action) -> Void in
                self.emailTextField.text = ""
                self.passwordConfirmationTextField.text = ""
                self.passwordTextField.text = ""
                self.nameTextField.text = ""
        })
        
        let cancelar = UIAlertAction(title: "Cancelar", style: .default ) { (action) -> Void in
            self.dismiss()
        }
        
        let alert = UIAlertController(
            title: "Oops...",
            message: "Ocorreu algum erro com seus dados",
            preferredStyle: .alert)
        alert.addAction(tentarNovamente)
        alert.addAction(cancelar)
        self.present(alert, animated: true, completion: nil)
        alert.view.tintColor = UIColor.paletteBlue
        
        setcreateNewAccountButton(enabled: true)
        createNewAccountButton.setTitle("Criar Conta", for: .normal)
        activityView.stopAnimating()
    }
    
    
    
    
    @objc private func dismiss() {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    /**
     Enables or Disables the **continueButton**.
     */
    
    func setcreateNewAccountButton(enabled:Bool) {
        if enabled {
            createNewAccountButton.alpha = 1.0
            createNewAccountButton.isEnabled = true
        } else {
            createNewAccountButton.alpha = 0.5
            createNewAccountButton.isEnabled = false
        }
    }

    
    func showCreateNewAccountButton(button: UIButton) {
        button.layer.cornerRadius = 25
        button.clipsToBounds = true
        button.layer.masksToBounds = true
    }
    
    // MARK: Actions
    @IBAction func confirmButton(_ sender: Any) {
        
        if passwordTextField.text == passwordConfirmationTextField.text && nameTextField.text != nil {
            handleSignUp()
        } else {
            if passwordTextField.text != passwordConfirmationTextField.text {
                let tentarNovamente = UIAlertAction(title: "Tentar Novamente", style: .default, handler: { (action) -> Void in
                    self.passwordConfirmationTextField.text = ""
                    self.passwordTextField.text = ""
                })
                let alert = UIAlertController(title: "Oops...", message: "Erro na confirmação de senha", preferredStyle: .alert)
                alert.addAction(tentarNovamente)
                self.present(alert, animated: true, completion: nil)
                alert.view.tintColor = UIColor.paletteBlue
                
            } else {
                let ok = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in
                })
                let alert = UIAlertController(title: "Oops...", message: "Por favor, preencha todos os dados", preferredStyle: .alert)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
                alert.view.tintColor = UIColor.paletteBlue
            }
        }
   
    }
}
