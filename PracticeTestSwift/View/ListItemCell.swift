//
//  ListItemCell.swift
//  PracticeTestSwift
//
//  Created by Sourabh Jain on 13/12/24.
//

// MARK: - ListItemCell
import UIKit

class ListItemCell: UITableViewCell {
    static let identifier = "ListItemCell"
    
    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = .systemMint.withAlphaComponent(0.2)
        return view
    }()
    
    private let iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = .zero
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        return label
    }()
    
    private let textStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        // Add iconView and textStackView to contentView
        contentView.addSubview(containerView)
        
        containerView.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 8)
        

        containerView.addSubview(iconView)
        containerView.addSubview(textStackView)
        
        // Add labels to the stack view
        textStackView.addArrangedSubview(titleLabel)
        textStackView.addArrangedSubview(subtitleLabel)
        
        iconView.anchor(left: containerView.leftAnchor, paddingLeft: 8, width: 50, height: 50)
        iconView.centerY(inView: containerView)
        
        textStackView.anchor(left: iconView.rightAnchor, right: containerView.rightAnchor,
                             paddingLeft: 16, paddingRight: 16,
                             width: 50, height: 50)
        textStackView.centerY(inView: containerView)
    }
    
    // Configure the cell with data
    func configure(icon: UIImage?, title: String, subtitle: String) {
        iconView.image = icon
        titleLabel.text = title
        subtitleLabel.text = subtitle
    }
}
