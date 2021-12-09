class NewsAppRepository : NewsAppRepositoryProtocol {
    private let networkDataSource: NewsAppNetworkServiceProtocol
    //private let coreDataSource: NewsAppCoreDataProtocol

//    init(networkDataSource: NewsAppNetworkServiceProtocol, coreDataSource: NewsAppCoreDataProtocol) {
//        self.networkDataSource = networkDataSource
//        self.coreDataSource = coreDataSource
//    }
    
    init (networkDataSource: NewsAppNetworkServiceProtocol) {
        self.networkDataSource = networkDataSource
    }
    
    func fetchNews(completion: @escaping ([News])-> Void) {
        networkDataSource.fetchNews()  { data in
            completion(data)
       }
    }
    
}
