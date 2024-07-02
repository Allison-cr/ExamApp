//
//  MenuBuilder.swift
//  Exam
//
//  Created by Alexander Suprun on 02.07.2024.
//

import Foundation

final class MenuBuilder {
    func assembly(clouser: EmptyClosure?) -> MenuViewController {
        let viewController = MenuViewController()
        let presenter = MenuPresenter(clouser: clouser)
        presenter.viewController = viewController
        viewController.presenter = presenter
        return viewController
    }
}
