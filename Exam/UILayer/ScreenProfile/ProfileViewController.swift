//
//  ProfileViewController.swift
//  Exam
//
//  Created by Alexander Suprun on 02.07.2024.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

protocol IProfileViewController: AnyObject {
    func appendProducts(_ products: [ProductModel.Product])
}

final class ProfileViewController: UIViewController {
    var presenter: IProfilePresenter?
    private lazy var collectionView: UICollectionView = settingCollectionView()
    var dataSource: ProductCollectionDataSource?
    private var modelProduct = [ProductModel.Product]()
    private var lastContentOffset: CGFloat = 0


    override func viewDidLoad() {
        super.viewDidLoad()
        settingMainView()
        presenter?.loadInitialData()
    }
}

//extension ProfileViewController: UICollectionViewDelegate {
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//           let offsetY = scrollView.contentOffset.y
//           let contentHeight = scrollView.contentSize.height
//           let height = scrollView.frame.size.height
//           
//           if offsetY > contentHeight - height * 2 {
//               presenter?.loadNextPage()
//           }
//       }
//}
//for exampple 
extension ProfileViewController:  UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if offsetY - lastContentOffset > 200 {
            presenter?.loadNextPage()
            lastContentOffset = offsetY
        }
    }
}


extension ProfileViewController: IProfileViewController {
    func appendProducts(_ products: [ProductModel.Product]) {
        let uniqueProducts = products.filter { newProduct in
            !modelProduct.contains { existingProduct in
                existingProduct.id == newProduct.id
            }
        }
        
        modelProduct.append(contentsOf: uniqueProducts)
        reloadData()
    }
}

private extension ProfileViewController {
    func settingMainView() {
        view.backgroundColor = UIColor(.cyan)
        settingDataSource()
        settingLayout()
        reloadData()
    }
    
    func settingCollectionView() -> UICollectionView {
        let collection = UICollectionView(
            frame: .zero,
            collectionViewLayout: settingCollectionLayout()
        )
        collection.backgroundColor = UIColor(.white)
        collection.register(
            ProductCollectionViewCell.self,
            forCellWithReuseIdentifier: "\(ProductCollectionViewCell.self)"
        )
        collection.showsVerticalScrollIndicator = false
        collection.delegate = self 
        view.addSubview(collection)
        return collection
    }
    
    func settingLayout() {
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(32)
            $0.leading.equalToSuperview().offset(8)
            $0.trailing.equalToSuperview().offset(-8)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}


// MARK: Setting CollectionView
private extension ProfileViewController {
    
    // MARK: DataSourceSnapshot
    func reloadData() {
        var snapshot = ProductCollectionSnapShot()
        
        snapshot.appendSections([.product])
        
        snapshot.appendItems(
            modelProduct,
            toSection: .product
        )
        dataSource?.apply(snapshot,animatingDifferences: true)
    }
    
    func settingDataSource() {
        dataSource = ProductCollectionDataSource(
            collectionView: collectionView,
            cellProvider: {
                collectionView,
                indexPath,
                itemIdentifier in
                
                let section = ProductModel.Section.allCases[indexPath.section]
                switch section {
                case .product:
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: "\(ProductCollectionViewCell.self)",
                        for: indexPath
                    ) as! ProductCollectionViewCell
                    cell.configure(
                        title: itemIdentifier.title,
                        imageUrl: itemIdentifier.image
                    )
                    return cell
                
                }
            }
        )
        settingSupplementaryView()
    }
    
    // MARK: SupplementaryView
    func settingSupplementaryView() {
        let supplementaryProduct = UICollectionView.SupplementaryRegistration<TitleSupplementaryView>(elementKind: "product") {  (supplementaryView: TitleSupplementaryView, elementKind: String, indexPath: IndexPath) in
            supplementaryView.label.text = "Product"
            supplementaryView.label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        }
        
        dataSource?.supplementaryViewProvider = { (collectionView, kind, indexPath) in
            switch kind {
            case "product":
                return collectionView.dequeueConfiguredReusableSupplementary(using: supplementaryProduct, for: indexPath)
            default:
                return nil
            }
        }
    }
    
    // MARK: CollectionViewLayout
    func settingCollectionLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [unowned self]
            (sectionIndex, environment) -> NSCollectionLayoutSection? in
            let section = ProductModel.Section.allCases[sectionIndex]
            switch section {
            case .product:
                return createLayoutProduct()
            }
        }
        return layout
    }
    
    // MARK: LayoutWork
    private func createLayoutProduct() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0 / 2),
                heightDimension: .fractionalHeight(1.0)
            )
        )

        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(0.4)
            ),
            repeatingSubitem: item,
            count: 2
        )

        group.interItemSpacing = NSCollectionLayoutSpacing.fixed(10)

        let section = NSCollectionLayoutSection(group: group)

        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 8,
            bottom: 20,
            trailing: 8
        )

        section.interGroupSpacing = 10

        let sectionProdct = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(44)
            ),
            elementKind: "product",
            alignment: .top
        )

        section.boundarySupplementaryItems = [sectionProdct]

        return section
    }

 }

