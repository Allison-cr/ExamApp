//
//  Cell.swift
//  Exam
//
//  Created by Alexander Suprun on 02.07.2024.
//
import UIKit
import SnapKit

final class MenuViewCell: UICollectionViewCell {
    
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
    
    
    func configure(title: String, image: UIImage) {
        label.text = title
        imageView.image = image
    }
}

private extension MenuViewCell {
    func settingMainView() {
        contentView.backgroundColor = UIColor(resource: .colorcard)
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
    }
    
    func settingLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 2
        contentView.addSubview(label)
        return label
    }
    
    func settingImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        contentView.addSubview(imageView)
        return imageView
    }
    

    func settingLayout() {
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(30)
        }
        
        label.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        
    }
}
