class NewsDataUseCase {
    private let newsAppRepository: NewsAppRepositoryProtocol

    init(newsAppRepository: NewsAppRepositoryProtocol) {
        self.newsAppRepository = newsAppRepository
    }
    
    func fetchNews(completion: @escaping ([News])-> Void) {
        newsAppRepository.fetchNews()  { data in
            completion(data)
       }
    }
}
