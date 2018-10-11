//
//  AddEditEmojiTableViewController.swift
//  EmodjiDictionary
//
//  Created by Александр Макаров on 11.10.2018.
//  Copyright © 2018 Александр Макаров. All rights reserved.
//

import UIKit

class AddEditEmojiTableViewController: UITableViewController {

    @IBOutlet weak var symbolTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var usageTextField: UITextField!
    
//    var emoji: Emoji?
    var emoji = Emoji(symbol: "", name: "", description: "", usage: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
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
    
    func updateUI() {
        symbolTextField.text = emoji.symbol
        nameTextField.text = emoji.name
        descriptionTextField.text = emoji.description
        usageTextField.text = emoji.usage
    }

}
