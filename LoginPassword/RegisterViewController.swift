//
//  RegisterViewController.swift
//  LoginPassword
//
//  Created by Анна Тибекина on 24.06.2022.
//

import UIKit

class RegisterViewController: UIViewController {

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
 }
    

    @IBAction func registerContinueButton(_ sender: Any) {
        if registerEmailTF.text != regLogin {
            regisretEmailImage.image = UIImage(named: "Галочка")
        }
    }
    
    @IBAction func switchToLoginButton(_ sender: Any) {
    }
    
    
}
/* @IBAction func Continue(_ sender: Any) {
 if loginTF.text == login && passwordTF.text == password{
     imageLogin.image = UIImage(named: "Галочка")
     imagePassword.image = UIImage(named: "Галочка")
     loginTF.backgroundColor = normalBackgroundColor
     passwordTF.backgroundColor = normalBackgroundColor
     worningLabel.text = ""
     // переход к successVC
     let successStoryboard = storyboard?.instantiateViewController(withIdentifier: "SuccessView")
     present(successStoryboard!, animated: false, completion: nil)
} else {
     imageLogin.image = UIImage(named: "Крестик")
     imagePassword.image = UIImage(named: "Крестик")
     worningLabel.text = "Incorrect email or password. Please try again"
     loginTF.backgroundColor = backgroundErrorColor
     passwordTF.backgroundColor = backgroundErrorColor
 }
}*/
