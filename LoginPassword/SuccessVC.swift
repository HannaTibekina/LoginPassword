//
//  SuccessVC.swift
//  LoginPassword
//
//  Created by Анна Тибекина on 24.06.2022.
//

import UIKit

class SuccessVC: UIViewController {

    @IBOutlet weak var spinerLoading: UIActivityIndicatorView!
    @IBOutlet weak var successImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        createSuccessImege()
        spinerLoading.startAnimating()
    }
    
    func createSuccessImege(){
        successImage.image = UIImage(named: "Галочка")
    }
   

    @IBAction func buttonWithLoading(_ sender: Any) {
       
     //   spinerLoading.hidesWhenStopped = true
    }
}
