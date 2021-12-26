//
//  FoldersViewModel.swift
//  Tredo
//
//  Created by Alexander Lee on 26.12.2021.
//


class FoldersPresenter {
    
    var delegate : DataManagerDelegate?
    
    func getFolders() {
        let urlString = "https://jsonplaceholder.typicode.com/albums"
        ApiConnector.shared.performAPICall(url: urlString, expectingReturnType: [Folders].self, completion: {result in
            switch result {
            case .success(let list):
                let foldersList : [Folders] = list
                self.delegate?.didParsedData(foldersList)
            case .failure(let error):
                print(error)
            }
        })
    }
    
}
