import Foundation

struct News: Codable {
    let title: String
    let description : String
    let urlToImage: String
    let publishedAt: String?
    let url : String
}
