import Foundation
import UIKit

class NewsListTableViewController: UITableViewController {
    
    private var articleListVM: ArticleListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        self.navigationController?
            .navigationBar
            .prefersLargeTitles = true
        
        WebService().getArticles(country: "kr") {
            [weak self] articles in
            guard let self else { return }
            if let articles {
                self.articleListVM = ArticleListViewModel(articles: articles)
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let articleListVM else { return 0 }
        return articleListVM.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        guard let articleListVM else { return 0 }
        return articleListVM.numberOfRowsInSection(section)
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath)
    -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell else {
            fatalError("ArticleTableViewCell not found")
        }
        
        cell.titleLabel.text = articleListVM.articles[indexPath.row].title
        cell.descriptionLable.text = articleListVM.articles[indexPath.row].description
        
        return cell
    }
}
