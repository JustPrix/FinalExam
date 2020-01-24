//
//  ViewController.swift
//  FinalExamProject
//
//  Created by COE-14 on 24/01/20.
//  Copyright © 2020 COE-14. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    
    var dbObj:ManageDB!
    @IBOutlet weak var txtFldName: UITextField!
    @IBOutlet weak var txtFldDepartment: UITextField!
    @IBOutlet weak var pickerViewDept: UIPickerView!
    
    let dptArray = ["Computer","Civil","Mechanical","Pharmacy"]
    var dept = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        dbObj = ManageDB()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnSave(_ sender: UIButton) {
        saveSalesman()
    }
    
    func saveSalesman(){
        let cmdText = "Insert into Salesman(sname,deptname) values('\(txtFldName.text!)','\(txtFldDepartment.text)')"
        
        if (dbObj.ExecCommand(with: cmdText)) {
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
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dptArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //dept = dptArray[ro]
        return dptArray[row]
    }
    

}

