import SnapKit

class NewsViewController: UIViewController {
    private var coordinator: AppCoordinator!
    private var viewModel: NewsViewViewModel!
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        return titleLabel
    }()
    
    let newsLabel: UILabel = {
                let newsLabel = UILabel()
                newsLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
                newsLabel.textColor = .black
                newsLabel.numberOfLines = 0
                newsLabel.lineBreakMode = .byWordWrapping
                return newsLabel
            }()
            
    let linkButton: UIButton = {
        let linkButton = UIButton()
        linkButton.addTarget(self, action: Selector(("buttonPress:")), for: .touchUpInside)
        linkButton.setTitle("open in Safari", for: .normal)
        linkButton.titleLabel?.font = UIFont(name:"ArialRoundedMTBold", size: 15.0)
        linkButton.setTitleColor(.systemBlue, for: .normal)
        linkButton.backgroundColor = .white
        linkButton.clipsToBounds = true
        return linkButton
    }()
    
    let cover: UIImageView = {
        let cover = UIImageView()
        cover.contentMode = .scaleAspectFill
        cover.clipsToBounds = true
        return cover
    }()
    
        
    convenience init(viewModel: NewsViewViewModel) {
        self.init()
        self.viewModel = viewModel
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
            
        setNavigationBar()
        addConstraints()
        updateData()
            
        self.view = view
        view.backgroundColor = .white
    }
            
    
    private func setNavigationBar() {
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.24, green: 0.314, blue: 0.706, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = .white
//        navigationItem.title = presenter.data.title
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16.0), NSAttributedString.Key.foregroundColor:UIColor.white]
    }
    
    func addConstraints() {
        view.addSubview(newsLabel)
        view.addSubview(cover)
        view.addSubview(titleLabel)
        view.addSubview(linkButton)
        
        cover.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            $0.width.equalToSuperview()
            $0.height.equalTo(200)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(cover.snp.bottom).offset(10)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            $0.width.equalTo(200)
        }
        
        newsLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.leading.equalTo(titleLabel)
            $0.trailing.equalTo(titleLabel)
        }
        
        linkButton.snp.makeConstraints {
            $0.top.equalTo(newsLabel.snp.bottom)
            $0.leading.equalTo(titleLabel)
            $0.trailing.equalTo(titleLabel)
        }
        
    }
    
    func updateData() {
        titleLabel.text = viewModel.newsData.title
        newsLabel.text = viewModel.newsData.description
        let imageURL = URL(string: viewModel.newsData.urlToImage) ?? nil
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: (imageURL ?? nil)!) else { return }

            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.cover.image = image
            }
        }
    }
    
    @objc func buttonPress(_ sender: UIButton) {
        if let url = URL(string: viewModel.newsData.url),
                UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:])
        }
    }
}
