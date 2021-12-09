import UIKit
import Alamofire
import RxSwift

class NewsAppNetworkDataSource : NewsAppNetworkServiceProtocol {
    
    func fetchNews<T: Codable>() -> Observable<T>{
        
        return Observable.create{ observer in
           let request = AF.request("https://newsapi.org/v1/articles?source=bbc-news&sortBy=top&apiKey=49f8b6ccc9f549209f4b5c21851457ab").validate().responseDecodable(of: T.self) { networkResponse in
                switch networkResponse.result{
                case .success:
                    do{
                        guard let response = networkResponse.value else { return }
                        observer.onNext(response)
                        observer.onCompleted()
                    }
                    catch(let error){
                        observer.onError(error)
                    }
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
//    func fetchNews(completion: @escaping ([News]) -> Void) {
//        AF.request("https://newsapi.org/v1/articles?source=bbc-news&sortBy=top&apiKey=49f8b6ccc9f549209f4b5c21851457ab")
//        .response { response in
//            debugPrint(response)
//        }
//        .responseDecodable(of: AllNews.self) { (response) in
//          guard let news = response.value else { return }
//            print(news)
//            completion(news.articles)
//        }
//    }
}
