//
//  BottomSheetViewController.swift
//  PracticeTestSwift
//
//  Created by Sourabh Jain on 13/12/24.
//

import UIKit

// MARK: - BottomSheetViewController
class BottomSheetViewController: UIViewController {
    var items: [ListModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let label = UILabel()
        label.text = "Statistics\nTotal Items: \(items.count)"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .bold)
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
