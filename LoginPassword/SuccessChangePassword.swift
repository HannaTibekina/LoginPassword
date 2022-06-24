//
//  SuccessChangePassword.swift
//  LoginPassword
//
//  Created by Анна Тибекина on 24.06.2022.
//

import UIKit

class SuccessChangePassword: UIViewController {

    @IBOutlet weak var successImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        successImage.image = UIImage(named: "Success")
   }
    


    @IBAction func emailAppButton(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newSroryboard = storyboard.instantiateViewController(withIdentifier: "changePasswordVC") as! ChangePassword
        self.present(newSroryboard, animated: true, completion: nil)
    }
}
