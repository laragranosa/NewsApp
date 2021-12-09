import RxSwift
import RxCocoa

class NewsListViewModel: NewsListViewModelProtocol {
    
    private var coordinator: NewsListCoordinator!
    private var newsDataSource: NewsAppNetworkDataSource!
    
    var tableData = BehaviorRelay<[News]>.init(value: [])
    var loaderSubject = ReplaySubject<Bool>.create(bufferSize: 1)
    var loadDataSubject = ReplaySubject<()>.create(bufferSize: 1)

    init(newsDataSource: NewsAppNetworkDataSource, coordinator: NewsListCoordinator) {
        self.coordinator = coordinator
        self.newsDataSource = newsDataSource
    }
    
    func fetchNews() {
        self.loaderSubject.onNext(true)
        let newsResponseObservable: Observable<AllNews> = newsDataSource.fetchNews()
        newsResponseObservable
            .observeOn(MainScheduler.instance)
            .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .background))
            .subscribe(onNext: { (newsResponse) in
                let news = newsResponse.articles
                self.loaderSubject.onNext(false)
                self.tableData.accept(news)
    })
    }
}
