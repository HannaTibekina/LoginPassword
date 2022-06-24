//
//  ChangePassword.swift
//  LoginPassword
//
//  Created by Анна Тибекина on 24.06.2022.
//

import UIKit

class ChangePassword: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var chPImage: UIImageView!
    @IBOutlet weak var chPPasswordTF: UITextField!
    @IBOutlet weak var chPConfirmPasswordTF: UITextField!
    @IBOutlet weak var chPPasswordLabel: UILabel!
    @IBOutlet weak var chPConfirmPasswordLabel: UILabel!
    @IBOutlet weak var chPWarningLabel: UILabel!
    @IBOutlet weak var chpPasswordImage: UIImageView!

    @IBOutlet weak var chpConfirmImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createLogoCp()
        chPPasswordTF.delegate = self
        chPConfirmPasswordTF.delegate = self
        showKeyboard()
    }
    func createLogoCp(){
        chPImage.image = UIImage(named: "Лого")
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if chPPasswordTF.hasText || chPConfirmPasswordTF.hasText {
            chPPasswordLabel.text = "Password"
            chPConfirmPasswordLabel.text = "Confirm password"
        }
    }
    
    func showKeyboard(){
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { (nt) in
            self.view.frame.origin.y = -200
            self.chPImage.image = nil
        }
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { (nt) in
                self.view.frame.origin.y = 0.0
                self.createLogoCp()
        }
    }
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       chPPasswordTF.resignFirstResponder()
       chPConfirmPasswordTF.resignFirstResponder()
        return true
    }
    var backgroundErrorColor = #colorLiteral(red: 0.9904245734, green: 0.8579052091, blue: 0.8648132682, alpha: 1)
    var normalBackgroundColor = #colorLiteral(red: 0.9677422643, green: 0.9727137685, blue: 0.9726259112, alpha: 1)
    
    @IBAction func chpContinueButton(_ sender: Any) {
        if chPPasswordTF.text == chPConfirmPasswordTF.text{
            // Добавить в базу
            chpPasswordImage.image = UIImage(named: "Галочка")
            chpConfirmImage.image = UIImage(named: "Галочка")
            chPPasswordTF.backgroundColor = normalBackgroundColor
            chPConfirmPasswordTF.backgroundColor = normalBackgroundColor
            chPWarningLabel.text = ""
            // переход
            let successStoryboard = storyboard?.instantiateViewController(withIdentifier: "SuccessView") as! SuccessVC
            present(successStoryboard, animated: false, completion: nil)
        } else {
            chpPasswordImage.image = UIImage(named: "Крестик")
            chpConfirmImage.image = UIImage(named: "Крестик")
            chPPasswordTF.backgroundColor = backgroundErrorColor
            chPConfirmPasswordTF.backgroundColor = backgroundErrorColor
            chPWarningLabel.text = "Somethig went wrong. Please try again"
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newSroryboard = storyboard.instantiateViewController(withIdentifier: "FirstVC") as! ViewController
        self.present(newSroryboard, animated: true, completion: nil)
    }
    

}
