//
//  AddLoungeViewController.swift
//  Inventory Of Lounge
//
//  Created by 朱志明 on 2017/3/20.
//  Copyright © 2017年 朱志明. All rights reserved.
//

import UIKit
import CoreData

class AddLoungeViewController: UIViewController,UITextFieldDelegate{
    
    @IBOutlet var nameTextField: UITextField!
    
    @IBOutlet var adressTextField: UITextField!
    
    @IBOutlet var contactTextField: UITextField!
    
    let context = CoreDataController.getContext()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.placeholder = "Enter Lounge Name"
        adressTextField.placeholder = "Enter Lounge Adress"
        contactTextField.placeholder = "Enter the Number"
        
        //设置delegate，代理方法才会有效
        nameTextField.delegate = self
        adressTextField.delegate = self
        contactTextField.delegate = self
        
        //The text string displayed in the Return key of a keyboard.
        nameTextField.returnKeyType = .done
        adressTextField.returnKeyType = .done
        contactTextField.returnKeyType = .done
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapHander))
        view.addGestureRecognizer(tap)
    }
    
    @objc func tapHander(){

        view.endEditing(true)
    }
    
    //点击Add按钮的作用1.向CoreData 检测是否有相同的lounge(Name)
    //               2.context.save
    //                3.pop回tableView页面
    @IBAction func addButtonTabbed(_ sender: Any) {
        let alert = UIAlertController(title: "Alter!!", message: "The lounge you register now is exsit.", preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        
        //1.向CoreData 检测是否有相同的lounge(Name),弹出警告
        if isExsit() {
            present(alert, animated: true, completion: nil)
            nameTextField.text = nil
            adressTextField.text = nil
            contactTextField.text = nil
            return
        }else{
            let entity = Lounges(entity: NSEntityDescription.entity(forEntityName: EntityName.lounge.rawValue, in: context)!, insertInto: context)
            entity.loungeName = nameTextField.text
            entity.address = adressTextField.text
            entity.contactNumber = contactTextField.text
            entity.items = 0
            
            guard CoreDataController.save(with: context) else{
                alert.message = "save the Lounge Info Fail!!"
                present(alert, animated: true, completion: nil)
                nameTextField.text = nil
                adressTextField.text = nil
                contactTextField.text = nil
                return
            }
        }
        let _ = navigationController?.popViewController(animated: true)
    }
    
    private func isExsit () -> Bool{
        let resultForCheck = CoreDataController.fetch(with: context, with: nil) 
        for tmp in resultForCheck {
            if tmp.loungeName == nameTextField.text {
                return true
            }
        }
        return false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         //隐藏键盘
        textField.resignFirstResponder()
        return true
    }
  

    
}
