//
//  MenuCoordinator.swift
//  Exam
//
//  Created by Alexander Suprun on 02.07.2024.
//

import Foundation
import UIKit

final class MenuCoordinator: ICoordinator {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        runMenuFlow()
    }
    
    func runMenuFlow() {
        let viewController = MenuBuilder().assembly { [weak self] in
            self?.runCardView()
        }
        navigationController.isNavigationBarHidden = true
        navigationController.setViewControllers([viewController], animated: true)
    }
    
    func runCardView() {
       
    }
    
}
