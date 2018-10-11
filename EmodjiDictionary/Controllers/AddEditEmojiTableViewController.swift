//
//  AddEditEmojiTableViewController.swift
//  EmodjiDictionary
//
//  Created by Александр Макаров on 11.10.2018.
//  Copyright © 2018 Александр Макаров. All rights reserved.
//

import UIKit

class AddEditEmojiTableViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var symbolTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var usageTextField: UITextField!
    
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
//    var emoji: Emoji?
    var emoji = Emoji(symbol: "", name: "", description: "", usage: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        symbolTextField.delegate = self
        updateUI()
        updateSaveButtonState()
        
//        if let emoji = emoji {
//            update(emoji)
//        }
    }
    
//    func update(_ emoji: Emoji) {
//        symbolTextField.text = emoji.symbol
//        nameTextField.text = emoji.name
//        descriptionTextField.text = emoji.description
//        usageTextField.text = emoji.usage
//    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let length = !string.isEmpty ? symbolTextField.text!.count + 1 : symbolTextField.text!.count - 1
        
        if length > 1 {
            return false
        }
        
        return true
    }
    
    func updateUI() {
        symbolTextField.text = emoji.symbol
        nameTextField.text = emoji.name
        descriptionTextField.text = emoji.description
        usageTextField.text = emoji.usage
    }
    
    func updateSaveButtonState() {
        let symbolText = symbolTextField.text ?? ""
        let nameText = nameTextField.text ?? ""
        let descriptionText = descriptionTextField.text ?? ""
        let usageText = usageTextField.text ?? ""
        saveButton.isEnabled = !symbolText.isEmpty && !nameText.isEmpty && !descriptionText.isEmpty && !usageText.isEmpty
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "saveUnwind" else { return }
        
        let symbol = symbolTextField.text ?? ""
        let name = nameTextField.text ?? ""
        let description = descriptionTextField.text ?? ""
        let usage = usageTextField.text ?? ""
        
        emoji = Emoji(symbol: symbol, name: name, description: description, usage: usage)
    }

}
