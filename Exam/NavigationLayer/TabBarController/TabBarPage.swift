//
//  TabBarPage.swift
//  Exam
//
//  Created by Alexander Suprun on 02.07.2024.
//

import Foundation
import UIKit

enum TabbarPage {
    case menu
    case profile
    
    func pageTitleValue() -> String {
        switch self {
        case .menu:
            return "Menu"
        case .profile:
            return "Profile"
        }
    }
    
    func pageIconValue() -> UIImage {
        switch self {
        case .menu:
            return UIImage(systemName: "plus") ?? UIImage()
        case .profile:
            return UIImage(systemName:  "plus") ?? UIImage()
        }
    }
    //
    static let allTabbarPages: [TabbarPage] = [.menu, .profile]
    static let firstTabbarPage: TabbarPage = .menu
    
    var pageOrderNumber: Int {
        guard let num = TabbarPage.allTabbarPages.firstIndex(of: self) else { return .zero }
        return num
    }
    
}
