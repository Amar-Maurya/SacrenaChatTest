//
//  DayLabelView.swift
//  SacrenaChat
//

import Foundation
import UIKit

class DayLabelView: UIView {
    
    let dayLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 10, weight: .light)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        // Set background color
        self.backgroundColor = UIColor.appBg
        // Rounded corners
        self.layer.cornerRadius = 12.5
        
        // Add label to view
        self.addSubview(dayLabel)
        
        // Constraints for the label to center it inside the view
        NSLayoutConstraint.activate([
            dayLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            dayLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            dayLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            dayLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -10)
        ])
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layoutIfNeeded()
    }
}
