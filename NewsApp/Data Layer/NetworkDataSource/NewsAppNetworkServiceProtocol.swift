import RxSwift

protocol NewsAppNetworkServiceProtocol {
    func fetchNews<T: Codable>() -> Observable<T>
}
