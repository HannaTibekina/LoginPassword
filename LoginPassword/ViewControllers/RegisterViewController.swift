//
//  RegisterViewController.swift
//  LoginPassword
//
//  Created by Анна Тибекина on 24.06.2022.
//

import UIKit
import Foundation

class RegisterViewController: UIViewController, UITextFieldDelegate {

        
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
    @IBOutlet weak var registerContinueButtonOutlet: LoadingButton!
    
  
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
    
    @IBAction func registerContinueButton(_ sender: UIButton) {
        
        if registerPasswordYF.text != registerConfirmPasswordTF.text {
            registerWarningLabel.text = "Passwords are not similar"
            return
        } else if registerPasswordYF.text == "" || registerConfirmPasswordTF.text == "" || registerEmailTF.text == "" {
            registerWarningLabel.text = "Fill in all the fields"
            return
        }
        
        registerContinueButtonOutlet.showLoading()
        
        guard let url = URL(string: "https://pfl.hasitschka.at/auth/signup") else { return }
        let parametrs = ["login": registerEmailTF.text, "password": registerPasswordYF.text]
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
                    regisretEmailImage.image = UIImage(named: "Галочка")
                    registerPasswordImage.image = UIImage(named: "Галочка")
                    registerConfirmImage.image = UIImage(named: "Галочка")
                    registerEmailTF.backgroundColor = Colors().normalBackgroundColor
                    registerPasswordYF.backgroundColor = Colors().normalBackgroundColor
                    registerConfirmPasswordTF.backgroundColor = Colors().normalBackgroundColor
                    registerWarningLabel.text = ""
                    let successStoryboard = storyboard?.instantiateViewController(withIdentifier: "succuesResetPassword") as! SuccessChangePassword
                    present(successStoryboard, animated: false, completion: nil)
                        
                    }
                } else {
                    DispatchQueue.main.async { [self] in
                        registerWarningLabel.text = ""
                    regisretEmailImage.image = UIImage(named: "Крестик")
                    registerPasswordImage.image = UIImage(named: "Крестик")
                    registerConfirmImage.image = UIImage(named: "Крестик")
                        registerEmailTF.backgroundColor = Colors().backgroundErrorColor
                    registerPasswordYF.backgroundColor = Colors().backgroundErrorColor
                    registerConfirmPasswordTF.backgroundColor = Colors().backgroundErrorColor
                    }
                }
            }
        }
        }.resume()
        self.registerContinueButtonOutlet.hideLoading()
    }
    
    @IBAction func switchToLoginButton(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newSroryboard = storyboard.instantiateViewController(withIdentifier: "FirstVC") as! ViewController
        self.present(newSroryboard, animated: true, completion: nil)
    }
    
    
}

