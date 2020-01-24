//
//  LoginViewController.swift
//  FinalExamProject
//
//  Created by COE-14 on 24/01/20.
//  Copyright © 2020 COE-14. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var dbObj:ManageDB!
    var value = [Any]()
    
    @IBOutlet weak var txtFldEmail: UITextField!
    @IBOutlet weak var txtFldPassword: UITextField!
    @IBOutlet weak var lblErrorText: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        dbObj = ManageDB()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnLogin(_ sender: UIButton) {
        value = [Any]()
        if (txtFldEmail.text != "" && txtFldPassword.text != "") {
            lblErrorText.text = ""
            let queryTxt = "SELECT userID from UserInfo where emailID = \"\(txtFldEmail.text!)\" AND userpassword = \"\(txtFldPassword.text!)\""
            
            
            let id = dbObj.ExecQuery(with: queryTxt)
            
            if (id.count == 0){
                let alert = UIAlertController.init(title: "Error", message: "Details not found, please try again or register a new user!", preferredStyle: .alert)
                let continueAction = UIAlertAction.init(title: "Continue", style: .default, handler: { (alert) in
                    self.dismiss(animated: true, completion: nil)
                })
                alert.addAction(continueAction)
                self.present(alert, animated: true, completion: nil)
                return
            }
            fetch()
            for key in id[0].keys{
                value.append(id[0][key]!)
            }
            print(value[4])
            performSegue(withIdentifier: "profileSegue", sender: sender)
        }
        else{
            lblErrorText.text = "Please enter username and password!"
        }
    }
    
    func fetch() {
        let userQuery = dbObj.ExecQuery(with: "SELECT username from UserInfo where emailID = \"\(txtFldEmail.text!)\" AND userpassword = \"\(txtFldPassword.text!)\"")
        let genderQuery = dbObj.ExecQuery(with: "SELECT gender from UserInfo where emailID = \"\(txtFldEmail.text!)\" AND userpassword = \"\(txtFldPassword.text!)\"")
        let imgQuery = dbObj.ExecQuery(with: "SELECT userImage from UserInfo where emailID = \"\(txtFldEmail.text!)\" AND userpassword = \"\(txtFldPassword.text!)\"")
        //let queryTxt = dbObj.ExecQuery(with: "SELECT userID from UserInfo where emailID = \"\(txtFldEmail.text!)\" AND userpassword = \"\(txtFldPassword.text!)\"")
        
        for key in imgQuery[0].keys{
            value.append(imgQuery[0][key]!)
        }
        for key in userQuery[0].keys{
            value.append(userQuery[0][key]!)
        }
        value.append(txtFldPassword.text!)
        value.append(txtFldEmail.text!)
        for key in genderQuery[0].keys{
            value.append(genderQuery[0][key]!)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as? EditProfileViewController
        vc?.finalValue = value
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
