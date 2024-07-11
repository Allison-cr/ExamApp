//
//  Model.swift
//  Exam
//
//  Created by Alexander Suprun on 02.07.2024.
//

import Foundation
import UIKit

enum CategoryModel: Hashable {
    
    enum Section: Int, CaseIterable {
        case work
        case education
        case news
    }
    
    struct Filter: Hashable {
        let title: String
    }
    
    struct Card: Hashable {
        let id = UUID()
        let name: String
        let image: UIImage
    }
}

