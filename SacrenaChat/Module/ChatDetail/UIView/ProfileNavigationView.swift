//
//  ProfileNavigationView.swift
//  SacrenaChat
//

import UIKit

// Protocol for the delegate
protocol ProfileNavigationDelegate: AnyObject {
    func didTapBackButton()
    func didTapMenuButton()
}

class ProfileNavigationView: UIView {
    
    // Delegate variable
    weak var delegate: ProfileNavigationDelegate?
    
    // Back Button
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // Profile Image View
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Bob") // Replace with your image
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true
        imageView.backgroundColor = .red
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // Name Label
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Bob"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Menu Button
    private let menuButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let bottomSepratorLbl: UILabel = {
        let lbl = UILabel()
        lbl.backgroundColor = UIColor.border
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    // Init from code or storyboard
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // Setup the view components and layout
    private func setupView() {
        self.backgroundColor = .clear
        addSubview(backButton)
        addSubview(profileImageView)
        addSubview(nameLabel)
        addSubview(menuButton)
        addSubview(bottomSepratorLbl)
        
        NSLayoutConstraint.activate([
            // Back Button Constraints
            backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            backButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            backButton.widthAnchor.constraint(equalToConstant: 30),
            backButton.heightAnchor.constraint(equalToConstant: 30),
            
            // Profile Image Constraints
            profileImageView.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 8),
            profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 50),
            profileImageView.heightAnchor.constraint(equalToConstant: 50),
            
            // Name Label Constraints
            nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(equalTo: menuButton.leadingAnchor, constant: -8),
//            nameLabel.centerXAnchor.constraint(equalTo: self.profileImageView.centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: self.profileImageView.centerYAnchor),
            
            // Menu Button Constraints
            menuButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            menuButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            menuButton.widthAnchor.constraint(equalToConstant: 30),
            menuButton.heightAnchor.constraint(equalToConstant: 25),
            
            bottomSepratorLbl.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            bottomSepratorLbl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            bottomSepratorLbl.heightAnchor.constraint(equalToConstant: 1),
            bottomSepratorLbl.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 5)
        ])
        
        // Set actions for buttons
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        menuButton.addTarget(self, action: #selector(menuButtonTapped), for: .touchUpInside)
    }
    
    // Actions for the buttons
    @objc private func backButtonTapped() {
        delegate?.didTapBackButton()
    }
    
    @objc private func menuButtonTapped() {
        delegate?.didTapMenuButton()
    }
}
