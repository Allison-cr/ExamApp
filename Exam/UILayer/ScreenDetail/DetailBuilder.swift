//
//  DetailBuilder.swift
//  Exam
//
//  Created by Alexander Suprun on 13.07.2024.
//

import Foundation
import UIKit

final class DetailBuilder {
    func assembly(product: ProductModel.Product) -> DetailViewController {
        return DetailViewController(product: product)
    }
}

//final class DetailBuilder {
//    func assembly(clouser: EmptyClosure?) -> DetailViewController {
//        let viewController = DetailViewController()
//        let presenter = DetailPresenter(clouser: clouser)
//        viewController.presenter = presenter
//        return viewController
//    }
//}
