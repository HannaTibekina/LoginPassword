//
//  ViewController.swift
//  LoginPassword
//
//  Created by Анна Тибекина on 23.06.2022.
//

import UIKit
import SwiftUI

class ViewController: UIViewController, UITextFieldDelegate {
    
    var backgroundErrorColor = #colorLiteral(red: 0.9904245734, green: 0.8579052091, blue: 0.8648132682, alpha: 1)
    var normalBackgroundColor = #colorLiteral(red: 0.9677422643, green: 0.9727137685, blue: 0.9726259112, alpha: 1)
   // Начала построение первого экрана примерно в 17:40, закончила(вместе с констрейнтами) в 18:50. Начинаю программировать аутлеты. 20:00 закончила с проверкой пароля и логина, все лейблы настроены, бэкграунд колор настроен. Проблема былв с колорЛитерал& 23:12 начала разбираться с клавитатурой. Проблема: при тапе на тф нужно поменять его бекграунд
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var loginTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var imageLogin: UIImageView!
    @IBOutlet weak var imagePassword: UIImageView!
    @IBOutlet weak var worningLabel: UILabel!
    @IBOutlet weak var loginLabe: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    
    
    
    let login = "123@gmail.com"
    let password = "qwerty"
    
    // ImageView
    func createlogoImage() {
        logoImage.image = UIImage(named: "Лого")
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
       createlogoImage()
        loginTF.delegate = self
        passwordTF.delegate = self
        showKeyboard()
        
 }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if loginTF.hasText || passwordTF.hasText {
            loginLabe.text = "Email"
            passwordLabel.text = "Password"
        }
    }
    //Keyboard
    func showKeyboard(){
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { (nt) in
            self.view.frame.origin.y = -200
            self.logoImage.image = nil
        }
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { (nt) in
                self.view.frame.origin.y = 0.0
                self.createlogoImage()
        }
    }
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        loginTF.resignFirstResponder()
        passwordTF.resignFirstResponder()
        return true
    }
   
    

    @IBAction func Continue(_ sender: Any) {
        if loginTF.text == login && passwordTF.text == password{
            imageLogin.image = UIImage(named: "Галочка")
            imagePassword.image = UIImage(named: "Галочка")
            loginTF.backgroundColor = normalBackgroundColor
            passwordTF.backgroundColor = normalBackgroundColor
            worningLabel.text = ""
            // переход к successVC
            let successStoryboard = storyboard?.instantiateViewController(withIdentifier: "SuccessView") as! SuccessVC
            present(successStoryboard, animated: false, completion: nil)
       } else {
            imageLogin.image = UIImage(named: "Крестик")
            imagePassword.image = UIImage(named: "Крестик")
            worningLabel.text = "Incorrect email or password. Please try again"
            loginTF.backgroundColor = backgroundErrorColor
            passwordTF.backgroundColor = backgroundErrorColor
        }
    }
    
}

