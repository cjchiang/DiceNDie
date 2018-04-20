//
//  CreationViewController.swift
//  DiceNDie
//
//  Created by Chonjou Chiang on 2018-04-19.
//  Copyright © 2018 Nate Chiang. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CreationViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var txtMod: UITextField!
    @IBOutlet weak var txtD4: UITextField!
    @IBOutlet weak var txtD6: UITextField!
    @IBOutlet weak var txtD8: UITextField!
    @IBOutlet weak var txtD10: UITextField!
    @IBOutlet weak var txtD12: UITextField!
    @IBOutlet weak var txtD20: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var txtName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Tapping out of input closes the keypad
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
        // Handle the text field’s user input through delegate callbacks.
        txtName.delegate = self
        
        // Enable the Save button only if the text field has a valid Meal name.
        updateSaveButtonState()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelSave(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = textField.text
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            return
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let mod = Int(txtMod.text!)!
        var dices = [
            "d4" : txtD4.text,
            "d6" : txtD6.text,
            "d8" : txtD8.text,
            "d10" : txtD10.text,
            "d12"  : txtD12.text,
            "d20"  : txtD20.text
        ]
        
        var desc = "\(dices["d4"]!! != "0" ? dices["d4"]!!+"d4 ": "")"
        desc += "\(dices["d6"]!! != "0" ? dices["d6"]!!+"d6 ": "")"
        desc += "\(dices["d8"]!! != "0" ? dices["d8"]!!+"d8 ": "")"
        desc += "\(dices["d10"]!! != "0" ? dices["d10"]!!+"d10 ": "")"
        desc += "\(dices["d12"]!! != "0" ? dices["d12"]!!+"d12 ": "")"
        desc += "\(dices["d20"]!! != "0" ? dices["d20"]!!+"d20 ": "")"
        desc += "+\(mod != 0 ? String(mod) : "")"
        
        let entity = NSEntityDescription.entity(forEntityName: "Rolls", in: context)
        let newRoll = NSManagedObject(entity: entity!, insertInto: context)
        
        newRoll.setValue(desc, forKey: "desc")
        newRoll.setValue(txtName.text, forKey: "name")
        newRoll.setValue(mod, forKey: "mod")
        newRoll.setValue(dices, forKey: "dice")

        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
    
    @IBAction func addDiceTap(_ sender: UIButton) {
        // There is probably a more elegant solution
        switch sender.tag   {
        case 4:
            txtD4.text = String(Int(txtD4.text!)! + 1)
            break;
        case 6:
            txtD6.text = String(Int(txtD6.text!)! + 1)
            break;
        case 8:
            txtD8.text = String(Int(txtD8.text!)! + 1)
            break;
        case 10:
            txtD10.text = String(Int(txtD10.text!)! + 1)
            break;
        case 12:
            txtD12.text = String(Int(txtD12.text!)! + 1)
            break;
        case 20:
            txtD20.text = String(Int(txtD20.text!)! + 1)
            break;
        default:
            break;
        }
    }

    @IBAction func addModTap(_ sender: UIButton) {
        txtMod.text = String(Int(txtMod.text!)! + 1)
    }
    
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let text = txtName.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
}
