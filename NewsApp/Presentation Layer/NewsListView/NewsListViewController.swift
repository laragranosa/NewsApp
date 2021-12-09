import UIKit
import SnapKit
import Alamofire
import RxSwift
import RxCocoa

class NewsListTableViewController: UIViewController {
    
    private var viewModel: NewsListViewModel!
    private var coordinator: NewsListCoordinator!
    private var titleLabel: UILabel!
    let disposeBag = DisposeBag()

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 96.0
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.cellIdentifier)
        tableView.isUserInteractionEnabled = true
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    let progressView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        return view
    }()
    
    init(viewModel: NewsListViewModel, coordinator: NewsListCoordinator) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        self.coordinator = coordinator
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
        view.addSubview(tableView)
        view.addSubview(progressView)
        view.bringSubviewToFront(progressView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        setNavigationBar()
        addConstraints()
        
        bindTableData()
        initializeLoaderObservable(subject: viewModel.loaderSubject).disposed(by: disposeBag)
        initializeScreenDataObservable(subject: viewModel.tableData).disposed(by: disposeBag)
        viewModel.loadDataSubject.onNext(())
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func setNavigationBar() {
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.24, green: 0.314, blue: 0.706, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = .white
        let titleLabel: UILabel = {
            let titleLabel = UILabel()
            titleLabel.font = UIFont.boldSystemFont(ofSize: 25.0)
            titleLabel.textColor = .white
            titleLabel.textAlignment = .center
            titleLabel.text = "Factory News"
            return titleLabel
        }()
        navigationItem.titleView = titleLabel
    }
    
    func initializeScreenDataObservable(subject: BehaviorRelay<[News]>) -> Disposable {
        return subject
            .observeOn(MainScheduler.instance)
            .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .background))
            .subscribe(onNext: { [unowned self] (items) in
                if !items.isEmpty {
                    print(items)
                    self.tableView.reloadData()
                }
            })
    }
    
    func bindTableData() {
        tableView.rx
            .itemSelected
            .subscribe({ indexSelected in
                self.showNews(indexSelected.element!)
        }).disposed(by: disposeBag)
        
        viewModel.fetchNews()
    }
    
    func initializeLoaderObservable(subject: ReplaySubject<Bool>) -> Disposable {
        return subject
            .observeOn(MainScheduler.instance)
            .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .background))
            .subscribe(onNext: { [unowned self] (status) in
                if status {
                    self.showLoader()
                } else {
                    self.hideLoader()
                }
            })
    }
    
    private func showNews(_ indexSelected: IndexPath){
        self.coordinator.openNewsPage(data: viewModel.tableData.value, pageIndex: indexSelected.row)
    }

    private func addConstraints() {
        
        tableView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        progressView.snp.makeConstraints{
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension NewsListTableViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tableData.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.cellIdentifier, for: indexPath) as? NewsTableViewCell ?? NewsTableViewCell(
            style: .default, reuseIdentifier: NewsTableViewCell.cellIdentifier)
        cell.selectionStyle = .blue
        let data = viewModel.tableData.value[indexPath.row]
        cell.title.text = data.title
        cell.news.text = data.description
        let imageURL = URL(string: data.urlToImage) ?? nil

        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: (imageURL ?? nil)!) else { return }

            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                cell.cover.image = image

            }
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return UITableView.automaticDimension
    }
}

extension NewsListTableViewController {
    
    func showLoader() {
        progressView.isHidden = false
        progressView.startAnimating()
    }
    
    func hideLoader() {
        progressView.isHidden = true
        progressView.stopAnimating()
    }
}


