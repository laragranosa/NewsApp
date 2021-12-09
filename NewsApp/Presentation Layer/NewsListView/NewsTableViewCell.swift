import UIKit
import SnapKit

class NewsTableViewCell: UITableViewCell {

    static let cellIdentifier = "searchCellId"
    
    let labelView: UIView = {
        let labelView = UIView(frame: CGRect(x: 0, y: 0, width: 265, height: 50.33))
        labelView.setContentCompressionResistancePriority(UILayoutPriority(1100), for: .vertical)
        labelView.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        labelView.setContentCompressionResistancePriority(UILayoutPriority(1), for: .horizontal)
        labelView.setContentHuggingPriority(UILayoutPriority(1000), for: .horizontal)
        return labelView
    }()
            
    let title: UILabel = {
        let title = UILabel()
        title.font = UIFont.boldSystemFont(ofSize: 16.0)
        title.textColor = .black
        title.numberOfLines = 0
        title.lineBreakMode = .byWordWrapping
        title.setContentCompressionResistancePriority(UILayoutPriority(1), for: .vertical)
        title.setContentHuggingPriority(UILayoutPriority(1000), for: .vertical)
//        title.setContentCompressionResistancePriority(UILayoutPriority(1), for: .vertical)
//        title.setContentHuggingPriority(UILayoutPriority(1000), for: .vertical)
        return title
    }()
            
            
    let news: UILabel = {
        let news = UILabel()
        news.font = UIFont.boldSystemFont(ofSize: 16.0)
        news.numberOfLines = 0
        news.lineBreakMode = .byWordWrapping
                //        news.setContentHuggingPriority(UILayoutPriority(1), for: .horizontal)
                //        news.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .horizontal)
        return news
    }()
            
    let cover: UIImageView = {
        let cover = UIImageView()
        cover.contentMode = .scaleAspectFill
        cover.clipsToBounds = true
        cover.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .horizontal)
        cover.setContentHuggingPriority(UILayoutPriority(1), for: .horizontal)
        return cover
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .white
        
        news.frame = labelView.bounds
        labelView.addSubview(news)
        contentView.addSubview(title)
        contentView.addSubview(labelView)
        contentView.addSubview(cover)
        
        addConstraints()
        }

    required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.black.cgColor, UIColor.white.cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.frame = self.labelView.bounds
        labelView.layer.addSublayer(gradient)
        labelView.mask = self.news
    }

    private func setImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }

        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }

            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.cover.image = image
                
            }
        }
    }
    
    private func addConstraints() {
        
        cover.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.width.equalTo(96)
            $0.height.equalTo(96)
        }
        
        title.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(cover.snp.trailing).offset(3)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(46)
        }

        labelView.snp.makeConstraints {
            $0.leading.equalTo(title)
            $0.top.equalTo(title.snp.bottom)
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    func set(model: News) {
        title.text = model.title
        news.text = model.description
        setImage(from: model.urlToImage)
    }
}
