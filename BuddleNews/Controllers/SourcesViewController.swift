//
//  ViewController.swift
//  BuddleNews
//
//  Created by Hüsamettin  Eyibil on 10.03.2022.
//

import UIKit

class SourcesViewController: UIViewController {
    
    private var collectionView: UICollectionView?
    private var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Sources"
        view.backgroundColor = .systemBackground
        configureCollectionView()
        configureTableView()
        getSources()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.width, height: 35)
        tableView.frame = CGRect(x: 0, y: view.safeAreaInsets.top + 50, width: view.width, height: 200)
    }
    
    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = CGSize(width: 100, height: 35)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.backgroundColor = .systemBackground
        collectionView?.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
        guard let collectionView = collectionView else {
            return
        }
        view.addSubview(collectionView)
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .systemPink
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
    }
    
    private func getSources() {
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

// MARK: - Collection View
extension SourcesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Category.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as? CategoryCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: Category.allCases[indexPath.row].rawValue)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = Category.allCases[indexPath.row].rawValue
        let width = self.estimatedFrame(text: text, font: UIFont.systemFont(ofSize: 14)).width
        return CGSize(width: width+50, height: 35.0)
    }

    private func estimatedFrame(text: String, font: UIFont) -> CGRect {
        let size = CGSize(width: 200, height: 1000) // temporary size
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size,
                                                   options: options,
                                                   attributes: [NSAttributedString.Key.font: font],
                                                   context: nil)
    }
}

extension SourcesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .systemBlue
        return cell
    }
}

