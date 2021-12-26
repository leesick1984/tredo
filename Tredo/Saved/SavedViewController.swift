//
//  SavedViewController.swift
//  Tredo
//
//  Created by Alexander Lee on 26.12.2021.
//
import UIKit
import CoreData

class SavedViewController: UITableViewController {
    
    var items = [Items]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadItems()
    }
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = items[indexPath.row].folderTitle
        
        return cell
        
    }
    
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func loadItems() {
        
        let request : NSFetchRequest<Items> = Items.fetchRequest()
        
        do{
            items = try context.fetch(request)
        } catch {
            print("Error loading items \(error)")
        }
        
        tableView.reloadData()
        
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            context.delete(items[indexPath.row])
            saveItems()
            self.items.remove(at: indexPath.row)
            tableView.reloadData()
        }
        
    }
    
    //MARK: - Data Manipulation Methods
    
    func saveItems() {
        do {
            try context.save()
        } catch {
            print("Error saving item \(error)")
        }
        
    }
}
