import Foundation

class WebService {
    let HOST = "https://newsapi.org/"
    let API = "v2/top-headlines"
    let apiKey: String

    init() {
        guard let path = Bundle.main.url(forAuxiliaryExecutable: "API_KEY") else {
            fatalError("API KEY Path not found")
        }

        // 간단하게 구현하기 위해 Unforce로 구현...
        apiKey = try! JSONDecoder()
            .decode(String.self,
                    from: try! Data(contentsOf: path))
    }

    func getArticles(country: String = "us",
                     completion: @escaping ([Article]?) -> ())
    {
        let query = [
            "country": country,
            "apiKey": apiKey
        ]
        var components = URLComponents(string: HOST + API)!
        components.queryItems = query.map {
            URLQueryItem(name: $0, value: $1)
        }
        let url = components.url!

        URLSession.shared.dataTask(with: url) {
            data, _, error in
            if let error {
                print(error.localizedDescription)
                completion(nil)
            } else if let data {
                let articleList = try? JSONDecoder()
                    .decode(ArticleList.self, from: data)

                if let articleList {
                    completion(articleList.articles)
                }

                print(articleList?.articles ?? "nil")
            }
        }.resume()
    }
}
