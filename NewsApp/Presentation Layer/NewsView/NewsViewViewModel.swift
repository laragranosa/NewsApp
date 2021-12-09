class NewsViewViewModel: NewsViewViewModelProtocol {
    
    private var coordinator: AppCoordinatorProtocol!
    var newsData : News

    init(data: News) {
        self.newsData = data
    }
    
}
