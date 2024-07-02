//
//  MenuPresenter.swift
//  Exam
//
//  Created by Alexander Suprun on 02.07.2024.
//

import Foundation

protocol IMenuPresenter: AnyObject {
    func loadData()
    func tupButtonAdd()
}

final class MenuPresenter: IMenuPresenter {
    private var clouser: EmptyClosure?
    weak var viewController: IMenuViewController?
    
    init(clouser: EmptyClosure?) {
        self.clouser = clouser
    }
    
    func loadData() {
        let work = MokData().categoryWorkModel()
        let filter = MokData().categoryFreeModel()
        viewController?.viewReady(work: work, free: filter)
    }
    func tupButtonAdd() {
        clouser?()
    }
}
