//
//  DetailViewController.swift
//  Exam
//
//  Created by Alexander Suprun on 12.07.2024.
//
import UIKit
import SnapKit
import Kingfisher

final class DetailViewController: UIViewController {
    private let product: ProductModel.Product
    
    // MARK: Properties
    
    private lazy var backButton : UIButton = settingBackButton()
    private lazy var titleLabel : UILabel = settingTitleLabel()
    private lazy var priceLabel : UILabel = settingPriceLabel()
    private lazy var descriptionLabel : UILabel = settingDescriptionLabel()
    private lazy var categoryLabel : UILabel = settingCategoryLabel()
    private lazy var imageView : UIImageView = settingImageView()
    private lazy var ratingLabel : UILabel = settingRaitingLabel()
    
    

    init(product: ProductModel.Product) {
        self.product = product
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        settingMainView()
        settingLayout()
        configure()
    }
    
    func configure() {
        titleLabel.text = product.title
        descriptionLabel.text = product.description
        priceLabel.text = String(product.price)
        categoryLabel.text = product.category
        ratingLabel.text = product.category
        if let url = URL(string: product.image) {
            imageView.kf.setImage(with: url)
        } else {
            imageView.image = UIImage(systemName: "plus")
        }
    }
}

private extension DetailViewController {
    @objc func popViewController() {
        //
    }
}

// MARK: Setting View
private extension DetailViewController {
    func settingMainView() {
        
    }
    
    func settingTitleLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24)
        label.numberOfLines = 3
        view.addSubview(label)
        return label
    }
    
    func settingPriceLabel() -> UILabel {
        let label = UILabel()
        view.addSubview(label)
        return label
    }
    
    func settingDescriptionLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 23
        view.addSubview(label)
        return label
    }
    
    func settingCategoryLabel() -> UILabel {
        let label = UILabel()
        view.addSubview(label)
        return label
    }
    
    func settingRaitingLabel() -> UILabel {
        let label = UILabel()
        view.addSubview(label)
        return label
    }
    
    func settingImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        return imageView
    }
    
    func settingBackButton() -> UIButton {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor(resource: .colorcard)
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.tintColor = .black
        button.addTarget(
            self,
            action: #selector(popViewController),
            for: .touchUpInside
        )
        return button
    }
    
    func settingLayout() {
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(64)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(Margins.screenHeight)
        }
        titleLabel.snp.makeConstraints{
            $0.top.equalTo(imageView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        categoryLabel.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        priceLabel.snp.makeConstraints{
            $0.top.equalTo(categoryLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        descriptionLabel.snp.makeConstraints{
            $0.top.equalTo(priceLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
    }
}
