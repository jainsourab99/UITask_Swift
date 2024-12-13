//
//  ViewController.swift
//  PracticeTestSwift
//
//  Created by Sourabh Jain on 13/12/24.
//
import UIKit

class ViewController: UIViewController {
    
    var filteredList: [ListModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    var searchText: String = ""
    
    // UI Components
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        // Set up table view
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ListItemCell.self, forCellReuseIdentifier: ListItemCell.identifier)
        tableView.backgroundColor = .white
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.separatorColor = .clear
        return tableView
    }()
    
    
    lazy var collectionView: UICollectionView = {
        // Set up collection view layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 60, height: 200)
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ImageCarouselCell.self,
                                forCellWithReuseIdentifier: ImageCarouselCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.decelerationRate = .fast
        return collectionView
    }()
    
    lazy var topCustomView: UIView = {
        let customView = UIView()
        customView.backgroundColor = .white
        customView.frame = CGRect(x: 0, y: 0,
                                  width: view.frame.width, height: 50)
        return customView
    }()
    
    private lazy var floatingButton: UIButton = {
        let button = UIButton(type: .custom)
        if let ellipsisImage = UIImage(named: "ellipsis")?.withRenderingMode(.alwaysTemplate) {
            button.setImage(ellipsisImage, for: .normal)
        }
        button.imageView?.tintColor = .white
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 28
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowRadius = 4
        
        // Ensure the image fits and is centered
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        button.addTarget(self, action: #selector(didTapFloatingButton), for: .touchUpInside)
        return button
    }()
    
    let searchBar = UISearchBar()
    let bottomSheetViewController = BottomSheetViewController()
    var firstSectionHeader: UIView?
    var stickyHeader: UIView?
    var headerHeight: CGFloat = 0
    var isCustomViewAdded: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        filteredList = ListViewModel.shared.listItems
        
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        // Set up search bar
        searchBar.delegate = self
        searchBar.placeholder = "Search..."
        searchBar.sizeToFit()
        // Add subviews
        view.addSubview(tableView)
        view.addSubview(floatingButton)
    }
    
    private func setupTableViewHeader() {
        let safeTop = view.safeAreaInsets.top
        let headerView = UIView(frame: CGRect(x: 0, y: 0,
                                              width: self.view.bounds.width,
                                              height: 220 + safeTop))
        headerView.addSubview(collectionView)
        
        collectionView.anchor(top: headerView.topAnchor,
                              left: headerView.leftAnchor,
                              right: headerView.rightAnchor,
                              paddingTop: safeTop,
                              height: 200)
        
        tableView.tableHeaderView = headerView
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setupTableViewHeader()
    }
    
    private func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        floatingButton.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.anchor(top: view.topAnchor, left: view.leftAnchor,
                         bottom: view.bottomAnchor, right: view.rightAnchor)
        floatingButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor,
                              right: view.rightAnchor, paddingBottom: 20,
                              paddingRight: 20, width: 56, height: 56)
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.setupStickyHeader()
        }
    }
    
    @objc private func didTapFloatingButton() {
        // Present bottom sheet
        bottomSheetViewController.items = ListViewModel.shared.listItems
        bottomSheetViewController.modalPresentationStyle = .pageSheet
        present(bottomSheetViewController, animated: true, completion: nil)
    }
}

// MARK: - UICollectionView DataSource & Delegate
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ListViewModel.shared.sliderImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCarouselCell.identifier, for: indexPath) as? ImageCarouselCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: ListViewModel.shared.sliderImages[indexPath.item])
        return cell
    }
}

// MARK: - UITableView DataSource & Delegate
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return TableSectionEnum.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = TableSectionEnum(rawValue: section)
        switch section {
        case .searchBar:
            return 1
        case .details:
            return filteredList.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = TableSectionEnum(rawValue: indexPath.section)
        if section == .searchBar {
            return UITableViewCell()
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListItemCell.identifier, for: indexPath) as? ListItemCell else {
            return UITableViewCell()
        }
        let item = filteredList[indexPath.row]
        cell.configure(icon: UIImage(named: item.image), title: item.title, subtitle: item.subTitle)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let section = TableSectionEnum(rawValue: section)
        if section == .searchBar {
            let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 50))
            headerView.addSubview(searchBar)
            firstSectionHeader = headerView
            return headerView
        } else {
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = TableSectionEnum(rawValue: indexPath.section)
        if section == .details {
            return 100
        } else {
            return .zero
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let section = TableSectionEnum(rawValue: section)
        if section == .searchBar {
            return 50
        } else {
            return .zero
        }
    }
}
