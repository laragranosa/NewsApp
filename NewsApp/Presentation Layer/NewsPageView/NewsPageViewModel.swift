class NewsPageViewModel: NewsPageViewModelProtocol {
    
    private var coordinator: AppCoordinatorProtocol!
    var newsData : [News]
    var tappedCell: Int

    init(data: [News], tappedCell: Int) {
        self.newsData = data
        self.tappedCell = tappedCell
    }
    
}
