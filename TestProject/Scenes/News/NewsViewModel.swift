//
//  NewsViewModel.swift
//  TestProject
//
//  Created by Nana Jimsheleishvili on 23.11.23.
//

import Foundation

// FIXME: უნდა იყოს AnyObject
protocol NewsViewModelDelegate: AnyObject {
    func newsFetched(_ news: [News])
    func showError(_ error: Error)
}

protocol NewsViewModel {
    var delegate: NewsViewModelDelegate? { get set }
    func viewDidLoad()
}

final class DefaultNewsViewModel: NewsViewModel {
    
    // MARK: - Properties
    // FIXME: API-ში წელია შესასწორებელი
    private let newsAPI = "https://newsapi.org/v2/everything?q=tesla&from=2023-11-11&sortBy=publishedAt&apiKey=ce67ca95a69542b484f81bebf9ad36d5"
    
    private var newsList = [News]()

    // FIXME: უნდა იყოს weak var
    weak var delegate: NewsViewModelDelegate?

    // MARK: - Public Methods
    func viewDidLoad() {
        // FIXME: ჩაკომენტარებული იყო
        fetchNews()
    }
    
    // MARK: - Private Methods
    private func fetchNews() {
        NetworkManager.shared.get(url: newsAPI) { [weak self] (result: Result<Article, Error>) in
            switch result {
            case .success(let article):
                // FIXME: newsList-თან საჭიროა self მითითება და default-ად მივუთითე ცარიელი მასივი
                // კოდის ხაზები უნდა იყოს პირიქით.
                self?.newsList.append(contentsOf: article.articles)
                self?.delegate?.newsFetched(self?.newsList ?? [])
            case .failure(let error):
                self?.delegate?.showError(error)
            }
        }
    }
}

