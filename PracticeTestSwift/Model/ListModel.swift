//
//  ListModel.swift
//  PracticeTestSwift
//
//  Created by Sourabh Jain on 13/12/24.
//

import Foundation

struct ListModel {
    let image: String
    let title: String
    let subTitle: String
    
    init(image: String, title: String, subTitle: String) {
        self.image = image
        self.title = title
        self.subTitle = subTitle
    }
}

enum TableSectionEnum: Int, CaseIterable {
    case searchBar
    case details
}
