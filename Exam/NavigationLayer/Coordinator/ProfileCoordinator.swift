//
//  ProfileCoordinator.swift
//  Exam
//
//  Created by Alexander Suprun on 02.07.2024.
//

import Foundation
import UIKit

final class ProfileCoordinator: ICoordinator {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        runMenuFlow()
    }
    
    func runMenuFlow() {
        let viewController = ProfileBuilder().assembly()
        viewController.presenter?.coordinator = self
        navigationController.isNavigationBarHidden = true
        navigationController.pushViewController(viewController, animated: true)
    }

    func showDetail(for product: ProductModel.Product) {
        let detailViewController = DetailBuilder().assembly(product: product)
        navigationController.isNavigationBarHidden = true

        navigationController.pushViewController(detailViewController, animated: true)
    }
}
