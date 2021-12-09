import Foundation

struct NewsListModel: Codable {
    let title: String
    let description : String
    let urlToImage: String
    
    init(model: News){
        title = model.title
        description = model.description
        urlToImage = model.urlToImage
    }
}
