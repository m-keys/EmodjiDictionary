//
//  EmojiTableViewController.swift
//  EmodjiDictionary
//
//  Created by Александр Макаров on 10.10.2018.
//  Copyright © 2018 Александр Макаров. All rights reserved.
//

import UIKit

class EmojiTableViewController: UITableViewController {
    
    var selectedEmoji: Emoji?
    var emojis: [[Emoji]] = [[
        Emoji(symbol: "🐢", name: "Черепаха", description: "Зеленая черепаха", usage: "медленное движение"),
        Emoji(symbol: "🐰", name: "Заяц", description: "Заяц с ушами", usage: "быстрое движение"),
        Emoji(symbol: "🐱", name: "Кошка", description: "Желтый кот", usage: "хитрое поведение"),
        Emoji(symbol: "🐶", name: "Собака", description: "Типичный пес", usage: "открытое поведение")], [
        Emoji(symbol: "😀", name: "Смайлик", description: "Улыбающаяся мордочка", usage: "полное счастье"),
        Emoji(symbol: "😇", name: "Ангел", description: "Мордочка с нимбом", usage: "хорошие поступки"),
        Emoji(symbol: "😍", name: "Влюбленный", description: "Влюбленная мордочка", usage: "состояние влюбленности")], []
    ]
    var headerTitles = ["Животные", "Смайлики", "Новое"]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        dataRetrieval()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        navigationItem.leftBarButtonItem = editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return emojis.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 || section == 1 || section == 2 {
            return emojis[section].count
        } else {
            // not implemented
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmojiTableViewCell", for: indexPath) as! EmojiTableViewCell

        let emoji = emojis[indexPath.section][indexPath.row]
        
//        cell.textLabel?.text = "\(emoji.symbol) - \(emoji.name)"
//        cell.detailTextLabel?.text = emoji.description
        
        cell.update(with: emoji)
        
//        cell.showsReorderControl = true

        return cell
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedEmoji = emojis[sourceIndexPath.section].remove(at: sourceIndexPath.row)
        emojis[destinationIndexPath.section].insert(movedEmoji, at: destinationIndexPath.row)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section < headerTitles.count {
            return headerTitles[section]
        }
        return nil
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
//            emojis.remove(at: indexPath.row)
            emojis[indexPath.section].remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
//            saveData()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditEmoji" {
            let indexPath = tableView.indexPathForSelectedRow!
            let emoji = emojis[indexPath.section][indexPath.row]
            let navigationController = segue.destination as! UINavigationController
            let addEditEmojiTableViewController = navigationController.topViewController! as! AddEditEmojiTableViewController
            addEditEmojiTableViewController.navigationItem.title = "Edit"
            addEditEmojiTableViewController.emoji = emoji
        }
    }

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "EditEmoji" {
//            if let indexPath = tableView.indexPathForSelectedRow {
//                let NC = segue.destination as! UINavigationController
//                let DVC = NC.topViewController as! AddEditEmojiTableViewController
//                DVC.emoji = emojis[indexPath.section][indexPath.row]
//            }
//        }
//    }

    //MARK: UITableViewDelegate
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let emoji = emojis[indexPath.section][indexPath.row]
//
//        print("\(emoji.symbol) - \(indexPath)")
//    }
    
    @IBAction func unwindToEmogiTableViewController(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind" else { return }
        let sourceViewController = segue.source as! AddEditEmojiTableViewController
        let emoji = sourceViewController.emoji
        print(sourceViewController.emoji)
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            emojis[selectedIndexPath.section][selectedIndexPath.row] = emoji
            tableView.reloadRows(at: [selectedIndexPath], with: .none)
        } else {
//            let newIndexPath = IndexPath(row: emojis.count, section: 0)
//            emojis[newIndexPath.section].append(emoji)
//            tableView.insertRows(at: [newIndexPath], with: .automatic)
            emojis[2].append(emoji)
            tableView.reloadData()
        }
        
        saveData()
    }
    
    func dataRetrieval() {
        // Создание адреса для записи/чтения файла
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentDirectory.appendingPathComponent("emojis").appendingPathExtension("plist")
//        print(archiveURL.absoluteString)
        
        // Получение данных из файла
        let propertyListDecoder = PropertyListDecoder()
        if let data = try? Data(contentsOf: archiveURL),
            // Декодирование полученных данных в заметку
            let decodedEmojis = try? propertyListDecoder.decode([[Emoji]].self, from: data) {
            emojis = decodedEmojis
//            print(decodedEmojis)
        }
    }
    
    func saveData() {
        // Создание адреса для записи/чтения файла
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentDirectory.appendingPathComponent("emojis").appendingPathExtension("plist")
        print(archiveURL.absoluteString)
        
        // Кодирование заметки
        let propertyListEncoder = PropertyListEncoder()
        let encodereEmojis = try? propertyListEncoder.encode(emojis)
        
        //Запись заметки в файл
        try? encodereEmojis?.write(to: archiveURL, options: .noFileProtection)
    }

}
