//
//  DetailPresenter.swift
//  Tredo
//
//  Created by Alexander Lee on 26.12.2021.
//

import Foundation

class DetailPresenter {
    
    var delegate : DataManagerDelegate?
    
    func getList(ofAlbum id : Int) {
        let urlString = "https://jsonplaceholder.typicode.com/photos?albumId=\(id)"
        ApiConnector.shared.performAPICall(url: urlString, expectingReturnType: [Detail].self, completion: {result in
            switch result {
            case .success(let list):
                let detail : [Detail] = list
                self.delegate?.didParsedData(detail)
            case .failure(let error):
                print(error)
            }
        })
    }
    
}
