//
//  ViewController+Extension.swift
//  PracticeTestSwift
//
//  Created by Sourabh Jain on 13/12/24.
//

import UIKit

// MARK: - UISearchBar Delegate
extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
        filteredList = searchText.isEmpty
        ? ListViewModel.shared.listItems
        : ListViewModel.shared.listItems.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        tableView.reloadData()
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let stickyHeader = self.stickyHeader else { return }
        let safeTop = view.safeAreaInsets.top
        let offsetY = scrollView.contentOffset.y
        let headerHeight = self.headerHeight
        if offsetY > headerHeight {
            self.topCustomView.removeFromSuperview()
            self.isCustomViewAdded = false
            DispatchQueue.main.async {
                self.topCustomView = self.firstSectionHeader ?? UIView()
                self.topCustomView.frame = CGRect(x: 0, y: safeTop, width: self.view.frame.width, height: 50 + safeTop)
                self.view.addSubview(self.topCustomView)
                self.isCustomViewAdded = true
            }
        } else {
            if isCustomViewAdded {
                DispatchQueue.main.async {
                    self.topCustomView.removeFromSuperview()
                    self.isCustomViewAdded = false
                }
            }
        }
    }
    
    func setupStickyHeader() {
        DispatchQueue.main.async {
            if let header = self.tableView(self.tableView, viewForHeaderInSection: .zero) {
                self.stickyHeader = header
                self.headerHeight = self.tableView(self.tableView, heightForHeaderInSection: .zero) + (self.tableView.tableHeaderView?.bounds.size.height ?? .zero)
            }
        }
    }
}

