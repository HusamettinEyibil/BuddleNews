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
    
    private var sources = [SourcesViewModel]() {
        didSet {
            filteredSources = sources
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private var filteredSources = [SourcesViewModel]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private var selectedCategories = [Category]()
    
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
        tableView.frame = CGRect(x: 0, y: view.safeAreaInsets.top + 50, width: view.width, height: view.safeAreaLayoutGuide.layoutFrame.size.height - 50)
        navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .bold)
        ]
        tableView.reloadData()
    }
    
    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = CGSize(width: 100, height: 40)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 10)
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
        tableView.backgroundColor = .systemBackground
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        tableView.separatorColor = .systemGray.withAlphaComponent(0.4)
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(SourcesTableViewCell.self, forCellReuseIdentifier: SourcesTableViewCell.identifier)
        view.addSubview(tableView)
    }
    
    private func getSources() {
        SourcesViewModel.getFilteredSources { [weak self] sources, error in
            guard let self = self else {return}
            if let sources = sources, error == nil {
                self.sources = sources
            } else {
                print(error?.localizedDescription ?? "Failed to get data.")
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
        let category = Category.allCases[indexPath.row]
        cell.configure(with: category.rawValue, selectedCategories.contains(category))
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CategoryCell {
            let category = Category.allCases[indexPath.row]
            let isAlreadySelected = selectedCategories.contains(category)
            cell.setSelected(!isAlreadySelected)
            if !isAlreadySelected {
                selectedCategories.append(category)
            } else {
                selectedCategories.removeAll { $0 == category }
            }
        }
        var filtered = [SourcesViewModel]()
        for category in selectedCategories {
            filtered.append(contentsOf: sources.filter({ $0.category == category }))
        }
        filteredSources = selectedCategories.isEmpty ? sources : filtered
    }
}

// MARK: - Table View
extension SourcesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredSources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SourcesTableViewCell.identifier, for: indexPath) as? SourcesTableViewCell else
        {
            return UITableViewCell()
        }
        cell.configure(with: filteredSources[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let headlinesVC = HeadlinesViewController()
        headlinesVC.modalPresentationStyle = .fullScreen
        headlinesVC.modalTransitionStyle = .coverVertical
        navigationController?.pushViewController(headlinesVC, animated: true)
    }
}

