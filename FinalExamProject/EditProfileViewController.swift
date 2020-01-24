//
//  EditProfileViewController.swift
//  FinalExamProject
//
//  Created by COE-14 on 24/01/20.
//  Copyright © 2020 COE-14. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {

    var finalValue = [Any]()
    var dbObj:ManageDB!
    let genderArray = ["Male","Female","Other"]
    
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var txtFldUsername: UITextField!
    @IBOutlet weak var txtFldPassword: UITextField!
    @IBOutlet weak var txtFldEmail: UITextField!
    @IBOutlet weak var sgmtGender: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        dbObj = ManageDB()
        let decodedData = Data(base64Encoded: finalValue[0] as! String, options: .ignoreUnknownCharacters)
        let decodedImage = UIImage(data: decodedData!)!
        
        imgUser.image = decodedImage
        txtFldUsername.text = finalValue[1] as? String
        txtFldPassword.text = finalValue[2] as? String
        txtFldEmail.text = finalValue[3] as? String
        sgmtGender.selectedSegmentIndex = genderArray.index(of: finalValue[4] as! String)!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnUpdate(_ sender: UIButton) {
        let imgData = UIImageJPEGRepresentation(imgUser.image!, 1.0)!
        let strBase64 = imgData.base64EncodedString(options: .lineLength64Characters)
        let updateText = "UPDATE UserInfo SET username = '\(txtFldUsername.text!)', emailID = '\(txtFldEmail.text!)', userpassword = '\(txtFldPassword.text!)', gender = '\(genderArray[sgmtGender.selectedSegmentIndex])', userImage = '\(strBase64)' WHERE userid = \(finalValue[5])"
        
        if(dbObj.ExecCommand(with: updateText))
        {
            print("\n\n\tExecuted!")
            let alert = UIAlertController.init(title: "Success", message: "You updated successfuly, you can now login with these details", preferredStyle: .alert)
            let continueAction = UIAlertAction.init(title: "Continue", style: .default, handler: { (alert) in
                self.dismiss(animated: true, completion: nil)
                self.reloadInputViews()
                self.navigationController?.popViewController(animated: true)
            })
            alert.addAction(continueAction)
            self.present(alert, animated: true, completion: nil)
            
        }
        else{
            print("\n\n\t\tError!")
            let alert = UIAlertController.init(title: "Error", message: "Some mistake has occurred, please try again", preferredStyle: .alert)
            let continueAction = UIAlertAction.init(title: "Continue", style: .default, handler: { (alert) in
                self.dismiss(animated: true, completion: nil)
            })
            alert.addAction(continueAction)
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }
    @IBAction func registerSalesman(_ sender: UIButton) {
        performSegue(withIdentifier: "salesmanSegue", sender: sender)
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
