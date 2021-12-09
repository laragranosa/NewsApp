import UIKit

//struct NewsListViewModel {
//
//    var dataList : [(String,String)]
//    let count: Int
//    let all: [News]
    
//    init(_ data: News) {
//        self.dataList = [(String,String)]()
//        self.dataList.append(("Title:", data.title))
//        self.dataList.append(("News:", data.content))
//    }
//    enum CodingKeys: String, CodingKey {
//        case count
//        case all = "result"
//    }
//}

struct NewsListViewModel: Decodable {
    let all: [News]
  
    init(_ data: [News]){
        self.all = data
    }
    enum CodingKeys: String, CodingKey {
        case all = "articles"
    }
}
