//
//  ProfilePresenter.swift
//  Exam
//
//  Created by Alexander Suprun on 02.07.2024.
//

import Foundation
import RxSwift

protocol IProfilePresenter: AnyObject {
    var coordinator: ProfileCoordinator? { get set }
    func loadInitialData()
    func loadNextPage()
    func showDetail(for product: ProductModel.Product)
}

class ProfilePresenter: IProfilePresenter {
    
    // MARK: - Properties
    var coordinator: ProfileCoordinator?
    weak var view: IProfileViewController?
    private var productService: ProductService
    private var disposeBag = DisposeBag()
    private var allProducts: [ProductModel.Product] = []
    /// Pagination
    private var currentPage = 1
    private let pageSize = 6
    private var isLoading = false
    
    init(view: IProfileViewController, productService: ProductService) {
        self.view = view
        self.productService = productService
    }
    
    func loadInitialData() {
        loadProducts(page: currentPage) { [weak self] products in
            self?.view?.appendProducts(products)
        }
    }
    
    func loadNextPage() {
        loadProducts(page: currentPage) { [weak self] products in
            guard let self = self else { return }
            self.view?.appendProducts(products)
            self.currentPage += 1
        }
    }
    
    private func loadProducts(page: Int, completion: @escaping ([ProductModel.Product]) -> Void) {
        let limit = page * pageSize
        let offset = (page-1) * pageSize
        //  print(" \(limit) \(offset) ")
        productService.fetchProducts(limit: limit, offset: offset)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { products in
                completion(products)
            }, onError: { error in
                // Handle error if necessary
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Detail View
    func showDetail(for product: ProductModel.Product) {
           coordinator?.showDetail(for: product)
       }
}
