//
//  RegisterViewController.swift
//  FinalExamProject
//
//  Created by COE-14 on 24/01/20.
//  Copyright © 2020 COE-14. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    
    var dbObj:ManageDB!
    let genderArray = ["Male","Female","Other"]
    
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var txtFldUsername: UITextField!
    @IBOutlet weak var txtFldPassword: UITextField!
    @IBOutlet weak var txtFldEmail: UITextField!
    @IBOutlet weak var smtGender: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        dbObj = ManageDB()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnRegister(_ sender: UIButton) {
        save()
    }
    
    func save() {
        let imgData = UIImageJPEGRepresentation(imgUser.image!, 1.0)!
        let strBase64 = imgData.base64EncodedString(options: .lineLength64Characters)
        //print(type(of: imgData))
        let cmdText = "Insert into UserInfo(userImage,username,emailID,userpassword,gender) values('\(strBase64)','\(txtFldUsername.text!)','\(txtFldEmail.text!)','\(txtFldPassword.text!)','\(genderArray[smtGender.selectedSegmentIndex])')"
        
        
        //print(genderArray[sgmtGender.selectedSegmentIndex])
        //print(sgmtGender.selectedSegmentIndex)
        
        if(dbObj.ExecCommand(with: cmdText))
        {
            print("\n\n\tExecuted!")
            let alert = UIAlertController.init(title: "Success", message: "Registry Complete!", preferredStyle: .alert)
            let continueAction = UIAlertAction.init(title: "Continue", style: .default, handler: { (alert) in
                self.dismiss(animated: true, completion: nil)
                self.navigationController?.popViewController(animated: true)
            })
            alert.addAction(continueAction)
            self.present(alert, animated: true, completion: nil)
        }
        else{
            print("\n\n\t\tError!")
            let alert = UIAlertController.init(title: "Error", message: "Some mistake has occurred, please try again", preferredStyle: .alert)
            let retryAction = UIAlertAction.init(title: "Retry", style: .default, handler: { (alert) in
                self.dismiss(animated: true, completion: nil)
            })
            let cancelAction = UIAlertAction.init(title: "Cancel", style: .cancel, handler: { (alert) in
                self.dismiss(animated: true, completion: nil)
                self.reloadInputViews()
            })
            alert.addAction(retryAction)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func swtchSecurePassword(_ sender: Any) {
        txtFldPassword.isSecureTextEntry = !(txtFldPassword.isSecureTextEntry)
    }
    
    //Image Picker Funtions
    var imgPicker:UIImagePickerController!
    @IBAction func PickImageOnTapAction(_ sender: UITapGestureRecognizer) {
        
        imgPicker = UIImagePickerController()
        imgPicker.sourceType = .photoLibrary
        imgPicker.delegate = self
        //self.navigationController?.pushViewController(imgPicker, animated: true)
        self.present(imgPicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let img = info[UIImagePickerControllerOriginalImage] as! UIImage!
        imgUser.image = img
        self.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
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
