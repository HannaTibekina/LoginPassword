//
//  RegisterViewController.swift
//  LoginPassword
//
//  Created by Анна Тибекина on 24.06.2022.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {

    
    var backgroundErrorColor = #colorLiteral(red: 0.9904245734, green: 0.8579052091, blue: 0.8648132682, alpha: 1)
    var normalBackgroundColor = #colorLiteral(red: 0.9677422643, green: 0.9727137685, blue: 0.9726259112, alpha: 1)
        
    @IBOutlet weak var registerImage: UIImageView!
    @IBOutlet weak var registerEmailTF: UITextField!
    @IBOutlet weak var registerPasswordYF: UITextField!
    @IBOutlet weak var registerConfirmPasswordTF: UITextField!
    @IBOutlet weak var registerTmailLabel: UILabel!
    @IBOutlet weak var registerPasswordKabel: UILabel!
    @IBOutlet weak var registerConfirmLabel: UILabel!
    @IBOutlet weak var regisretEmailImage: UIImageView!
    @IBOutlet weak var registerPasswordImage: UIImageView!
    @IBOutlet weak var registerConfirmImage: UIImageView!
    @IBOutlet weak var registerWarningLabel: UILabel!
    
    
    let regLogin = "fgh@gmail.com"
  
    override func viewDidLoad() {
        super.viewDidLoad()
        createImageRegister()
        showKeyboard()
        registerEmailTF.delegate = self
        registerPasswordYF.delegate = self
        registerConfirmPasswordTF.delegate = self
        
 }
    func createImageRegister(){
        registerImage.image = UIImage(named: "Лого")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if registerEmailTF.hasText || registerPasswordYF.hasText {
            registerTmailLabel.text = "Email"
            registerPasswordKabel.text = "Password"
            registerConfirmLabel.text = "Confirm password"
            
        }
    }
    func showKeyboard(){
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { (nt) in
            self.view.frame.origin.y = -200
            self.registerImage.image = nil
        }
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { (nt) in
                self.view.frame.origin.y = 0.0
                self.createImageRegister()
        }
    }
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       registerEmailTF.resignFirstResponder()
       registerPasswordYF.resignFirstResponder()
       registerConfirmPasswordTF.resignFirstResponder()
        return true
    }
    
    
    
    
    @IBAction func registerContinueButton(_ sender: Any) {
        if registerEmailTF.text != regLogin && registerPasswordYF.text == registerConfirmPasswordTF.text {
            regisretEmailImage.image = UIImage(named: "Галочка")
            registerPasswordImage.image = UIImage(named: "Галочка")
            registerConfirmImage.image = UIImage(named: "Галочка")
            registerEmailTF.backgroundColor = normalBackgroundColor
            registerPasswordYF.backgroundColor = normalBackgroundColor
            registerConfirmPasswordTF.backgroundColor = normalBackgroundColor
            registerWarningLabel.text = ""
            let successStoryboard = storyboard?.instantiateViewController(withIdentifier: "SuccessView") as! SuccessVC
            present(successStoryboard, animated: false, completion: nil)
        } else if registerEmailTF.text == regLogin{
            registerWarningLabel.text = "This email is already used by another user"
            regisretEmailImage.image = UIImage(named: "Крестик")
            registerPasswordImage.image = UIImage(named: "Крестик")
            registerConfirmImage.image = UIImage(named: "Крестик")
            registerEmailTF.backgroundColor = backgroundErrorColor
            registerPasswordYF.backgroundColor = backgroundErrorColor
            registerConfirmPasswordTF.backgroundColor = backgroundErrorColor
        } else if registerEmailTF.text != regLogin && registerPasswordYF.text != registerConfirmPasswordTF.text{
            registerWarningLabel.text = "Password is incorrect"
            regisretEmailImage.image = UIImage(named: "Галочка")
            registerPasswordImage.image = UIImage(named: "Крестик")
            registerConfirmImage.image = UIImage(named: "Крестик")
            registerEmailTF.backgroundColor = normalBackgroundColor
            registerPasswordYF.backgroundColor = backgroundErrorColor
            registerConfirmPasswordTF.backgroundColor = backgroundErrorColor
        }
    }
    
    @IBAction func switchToLoginButton(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newSroryboard = storyboard.instantiateViewController(withIdentifier: "FirstVC") as! ViewController
        self.present(newSroryboard, animated: true, completion: nil)
    }
    
    
}
