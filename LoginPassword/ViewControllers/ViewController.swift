//
//  ViewController.swift
//  LoginPassword
//
//  Created by Анна Тибекина on 23.06.2022.
//

import UIKit
import SwiftUI
import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
  
        
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var loginTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var imageLogin: UIImageView!
    @IBOutlet weak var imagePassword: UIImageView!
    @IBOutlet weak var worningLabel: UILabel!
    @IBOutlet weak var loginLabe: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var continueOutlet: LoadingButton!
    
    
    func createlogoImage() {
        logoImage.image = UIImage(named: "Лого")
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        createlogoImage()
        loginTF.delegate = self
        passwordTF.delegate = self
        showKeyboard()
        Colors()
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
        if loginTF.text == "" || passwordTF.text == "" {
            worningLabel.text = "Passwords are not similar"
        }
        continueOutlet.showLoading()
        guard let url = URL(string: "https://pfl.hasitschka.at/auth/signup") else { return }
        let parametrs = ["login": loginTF.text, "password": passwordTF.text]
        print(parametrs)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parametrs, options: []) else { return }
        request.httpBody = httpBody
        let session = URLSession.shared
        session.dataTask(with: request) { [self] (data, response, error) in
            if let response = response {
            guard let data = data else { return }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
            } catch {
                print(error)
            }
            if let httpResponse = response as? HTTPURLResponse {
                print("STATUC CODE")
                print(httpResponse.statusCode)
                print("STATUC CODE")
                if httpResponse.statusCode == 200 {
                    DispatchQueue.main.async { [self] in
                    imageLogin.image = UIImage(named: "Галочка")
                    imagePassword.image = UIImage(named: "Галочка")
                        loginTF.backgroundColor = Colors().normalBackgroundColor
                        passwordTF.backgroundColor = Colors().normalBackgroundColor
                    worningLabel.text = ""
                    let successStoryboard = storyboard?.instantiateViewController(withIdentifier: "SuccessView") as! SuccessVC
                    present(successStoryboard, animated: false, completion: nil)
                    }
                } else {
                    DispatchQueue.main.async { [self] in
                        imageLogin.image = UIImage(named: "Крестик")
                        imagePassword.image = UIImage(named: "Крестик")
                        worningLabel.text = "Incorrect email or password. Please try again"
                        loginTF.backgroundColor = Colors().backgroundErrorColor
                        passwordTF.backgroundColor = Colors().backgroundErrorColor
                        }
                    }
                }
            }
        }.resume()
        self.continueOutlet.hideLoading()
    }
    @IBAction func registerButton(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newSroryboard = storyboard.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterViewController
        self.present(newSroryboard, animated: true, completion: nil)
    }
    
    @IBAction func resetPasswordButton(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newSroryboard = storyboard.instantiateViewController(withIdentifier: "ResetVC") as! ResetPasswordVC
        self.present(newSroryboard, animated: true, completion: nil)
    }
    
    
}

