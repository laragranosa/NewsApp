protocol NewsAppRepositoryProtocol {
    func fetchNews(completion: @escaping ([News])-> Void)
}

