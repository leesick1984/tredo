//
//  ViewController.swift
//  Tredo
//
//  Created by Alexander Lee on 25.12.2021.
//

import UIKit

class FoldersViewController: UIViewController {
    
    @IBOutlet weak var table: UITableView!
    let foldersData = FoldersPresenter()
    var data : [Folders] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        foldersData.delegate = self
        foldersData.getFolders()
        table.dataSource = self
        table.delegate = self
    }
}

//MARK: - Delegate

extension FoldersViewController : DataManagerDelegate {
    func didParsedData<T>(_ apiData: T) where T : Decodable {
        DispatchQueue.main.async {
            self.data = apiData as! [Folders]
            self.table.reloadData()
        }
    }
    func didFailWithError(error: Error) {
        print(error)
    }
}


//MARK: - TableView extension

extension FoldersViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let folders = data[indexPath.row]
        
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FoldersTableViewCell
        
        cell.label.text = folders.title
        cell.tag = folders.id
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let indexPath = tableView.indexPathForSelectedRow
        
        let currentCell = tableView.cellForRow(at: indexPath!) as! FoldersTableViewCell?
        
        let displayVC : DetailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        displayVC.id = currentCell!.tag
        displayVC.folderTitle = currentCell!.label.text!
        
        self.present(displayVC, animated: true, completion: nil)
        
    }
}
