import Foundation

// Dcodable, Encodable, Codable 변환 상황에 맞게 사용.

struct ArticleList: Decodable {
    let articles: [Article]
}

struct Article: Decodable {
    let title:  String
    let description: String?
}
