//
//  LoginViewController.swift
//  Vicinity (iOS)
//
//  Created by Kyle Grosman on 7/7/22.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var InvalidLoginLabel: UILabel!
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBOutlet weak var LoginButton: UIButton!
    
    
    @IBOutlet weak var ForgotPassWordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    func setUpElements() {
        InvalidLoginLabel.alpha = 0
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func LoginPressed(_ sender: Any) {
    }
    
    
    @IBAction func ForgotPressed(_ sender: Any) {
    }
    
}
