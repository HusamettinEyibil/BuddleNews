//
//  ViewController.swift
//  BuddleNews
//
//  Created by Hüsamettin  Eyibil on 10.03.2022.
//

import UIKit

class SourcesViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemPink
        fetchData()
    }
    
    private func fetchData() {
        NetworkManager.shared.getSources { result in
            switch result {
            case .success(let response):
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }


}

