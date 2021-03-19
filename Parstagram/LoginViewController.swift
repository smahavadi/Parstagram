//
//  LoginViewController.swift
//  Parstagram
//
//  Created by Suma Valli on 3/17/21.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        let user = PFUser ();
        user.username = usernameField.text;
        user.password = passwordField.text;
        
        user.signUpInBackground { (success, error) in
            if success {
                self.performSegue(withIdentifier: "successSegue", sender: nil)
                print("Successfully signed up");
                self.defaults.setValue(user.username, forKey: "currentUser");
            } else {
                print("Error in signing up: \(error?.localizedDescription)")
            }
        }
    }
    
    @IBAction func onLogIn(_ sender: Any) {
        let username = usernameField.text!
        let password = passwordField.text!
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
            if (user != nil) {
                self.performSegue(withIdentifier: "successSegue", sender: nil)
                print("Successfully logged in");
                self.defaults.setValue(username, forKey: "currentUser");
            } else {
                print("Error in logging in: \(error?.localizedDescription)")
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
    }
*/

}
