//
//  ResetPasswordVC.swift
//  LoginPassword
//
//  Created by Анна Тибекина on 24.06.2022.
//

import UIKit

class ResetPasswordVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var resetImage: UIImageView!
    @IBOutlet weak var resetEmailTF: UITextField!
    @IBOutlet weak var resetEmailImage: UIImageView!
    @IBOutlet weak var resetEmailLabel: UILabel!
    @IBOutlet weak var resetWarningLabel: UILabel!
    @IBOutlet weak var backToLoginButton: UIButton!
    @IBOutlet weak var resetComtinueButtonOutlet: LoadingButton!
    
    let login = ["123@gmail.com"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetEmailTF.delegate = self
        createImageReset()
        showKeyboard()
  }
    func createImageReset(){
        resetImage.image = UIImage(named: "Лого")
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if resetEmailTF.hasText {
            resetEmailTF.text = "Email"
           
        }
    }
    //Keyboard
    func showKeyboard(){
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { (nt) in
            self.view.frame.origin.y = -200
            self.resetImage.image = nil
            self.resetComtinueButtonOutlet.titleLabel?.text = "Submit"
            self.resetComtinueButtonOutlet.backgroundColor = #colorLiteral(red: 0, green: 4.493939196e-05, blue: 0.4588931799, alpha: 1)
            self.backToLoginButton.titleLabel?.text = "Back to Login"
            
            
        }
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { (nt) in
                self.view.frame.origin.y = 0.0
                self.createImageReset()
        }
    }
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       resetEmailTF.resignFirstResponder()
       return true
    }
    var backgroundErrorColor = #colorLiteral(red: 0.9904245734, green: 0.8579052091, blue: 0.8648132682, alpha: 1)
    var normalBackgroundColor = #colorLiteral(red: 0.9677422643, green: 0.9727137685, blue: 0.9726259112, alpha: 1)
    
    @IBAction func resetContinButton(_ sender: Any) {
        resetComtinueButtonOutlet.showLoading()
        if login.contains(resetEmailTF.text!) {
            resetEmailImage.image = UIImage(named: "Галочка")
            resetEmailTF.backgroundColor = normalBackgroundColor
            resetWarningLabel.text = "We'll send you a letter to your email to reset password."
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newSroryboard = storyboard.instantiateViewController(withIdentifier: "succuesResetPassword") as! SuccessChangePassword
            self.present(newSroryboard, animated: true, completion: nil)
            
        } else {
            resetEmailImage.image = UIImage(named: "Крестик")
            resetEmailTF.backgroundColor = backgroundErrorColor
            resetWarningLabel.text = "Something went wrong. Please try again"
        }
        self.resetComtinueButtonOutlet.hideLoading()
    }
    
    @IBAction func resetSwitchToLoginButton(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newSroryboard = storyboard.instantiateViewController(withIdentifier: "FirstVC") as! ViewController
        self.present(newSroryboard, animated: true, completion: nil)
    }
    

}
