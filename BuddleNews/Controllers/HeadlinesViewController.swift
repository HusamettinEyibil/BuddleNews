//
//  HeadlinesViewController.swift
//  BuddleNews
//
//  Created by Hüsamettin  Eyibil on 10.03.2022.
//

import UIKit

class HeadlinesViewController: UIViewController {
    
    private var tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Headlines"
        view.backgroundColor = .systemBackground
        configureTableView()

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.safeAreaLayoutGuide.layoutFrame
        tableView.reloadData()
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .systemBackground
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        tableView.separatorColor = .systemGray.withAlphaComponent(0.4)
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(HeadlinesTableViewCell.self, forCellReuseIdentifier: HeadlinesTableViewCell.identifier)
        view.addSubview(tableView)
    }
    


}

// MARK: - Table View
extension HeadlinesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HeadlinesTableViewCell.identifier, for: indexPath) as? HeadlinesTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: String(indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
