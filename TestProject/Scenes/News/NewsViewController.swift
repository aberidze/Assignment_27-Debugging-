//
//  NewsViewController.swift
//  TestProject
//
//  Created by Nana Jimsheleishvili on 23.11.23.
//

import UIKit

final class NewsViewController: UIViewController {
    
    // MARK: - Properties
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "newsCell")
        // FIXME: ამ ეტაპზე ვერ მოხდებოდა dataSource და delegate-ის მინიჭება, რადგან ჯერ დასრულებული არ არის კლასის ინიციალიზაცია. კოდის ეს ნაწილი ჩავიტანე დაბლა setupTableView-ში.
        // tableView.dataSource = self
        // tableView.delegate = self
        return tableView
    }()
    
    private var news = [News]()
    // FIXME: ეწერა DefaultNewViewModel, უნდა ყოფილიყო DefaultNewsViewModel
    private var viewModel: NewsViewModel = DefaultNewsViewModel()

    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel.viewDidLoad()
        // FIXME: NewsViewModel-ს არ აქვს დელეგატი მითითებული
        viewModel.delegate = self
    }
    
    // MARK: - Setup TableView
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        tableView.dataSource = self
        tableView.delegate = self
    }
}

// MARK: - TableViewDataSource
extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // FIXME: ეწერა .zero
        news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // FIXME: არასწორი reuseIdentifier
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as? NewsTableViewCell else {
            fatalError("Could not dequeue NewsCell")
        }
        // FIXME: +1 არ უნდა
        cell.configure(with: news[indexPath.row])
        return cell
    }
}

// MARK: - TableViewDelegate
extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // FIXME: სიმაღლე იყო .zero
        UITableView.automaticDimension
    }
}

// MARK: - MoviesListViewModelDelegate
extension NewsViewController: NewsViewModelDelegate {
    func newsFetched(_ news: [News]) {
        self.news = news
        // FIXME: reload უნდა ხდებოდეს main thread-ზე
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showError(_ error: Error) {
        print("error")
    }
}

