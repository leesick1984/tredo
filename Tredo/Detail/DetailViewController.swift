//
//  DetailViewController.swift
//  Tredo
//
//  Created by Alexander Lee on 26.12.2021.
//
import UIKit
import CoreData

class DetailViewController : UIViewController {
    
    
    @IBOutlet weak var folderName: UILabel!
    @IBOutlet weak var table: UITableView!
    
    let listData = DetailPresenter()
    var data: [Detail] = []
    var id : Int = 0
    var folderTitle : String = ""
    var items = [Items]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        folderName.text = folderTitle
        listData.delegate = self
        listData.getList(ofAlbum: id)
        table.dataSource = self
        table.delegate = self
    }
    
}

//MARK: - Delegate

extension DetailViewController : DataManagerDelegate {
    func didParsedData<T>(_ apiData: T) where T : Decodable {
        DispatchQueue.main.async {
            self.data.append(contentsOf: apiData as! [Detail])
            self.table.reloadData()
        }
    }
    func didFailWithError(error: Error) {
        print(error)
    }
}

//MARK: - TableView extension

extension DetailViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let list = data[indexPath.row]
        
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DetailTableViewCell
        
        cell.label.text = list.title
        cell.tag = list.id
        
        cell.imageURL = URL(string: list.thumbnailUrl)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    //MARK: - Add New Items
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newItem = Items(context: self.context)
            newItem.folderTitle = self.folderTitle
            newItem.folderId = Int64(self.id)
            
            self.items.append(newItem)
            
            self.saveItems()
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
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


