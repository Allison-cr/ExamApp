//
//  ProductCollectionViewCell.swift
//  Exam
//
//  Created by Alexander Suprun on 09.07.2024.
//
import UIKit
import SnapKit
import Kingfisher

final class ProductCollectionViewCell: UICollectionViewCell {
    
    private lazy var label: UILabel = settingLabel()
    private lazy var imageView: UIImageView = settingImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        settingMainView()
        settingLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(title: String, imageUrl: String) {
        label.text = title
        if let url = URL(string: imageUrl) {
            imageView.kf.setImage(with: url)
        } else {
            imageView.image = UIImage(systemName: "plus")
        }
    }
    
    // clear for reuse
    override func prepareForReuse() {
            super.prepareForReuse()
            imageView.image = nil
            label.text = nil
        }
}

private extension ProductCollectionViewCell {
    func settingMainView() {
        contentView.backgroundColor = UIColor(resource: .colorcard)
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
    }
    
    func settingLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 3
        contentView.addSubview(label)
        return label
    }
    
    func settingImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        contentView.addSubview(imageView)
        return imageView
    }
    
    
    func settingLayout() {
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview().offset(-80)
        }
        
        label.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)

        }
    }
}

