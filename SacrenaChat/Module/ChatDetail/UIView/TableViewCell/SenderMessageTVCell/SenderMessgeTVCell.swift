//
//  SenderMessgeTVCell.swift
//  SacrenaChat
//

import UIKit

class SenderMessgeTVCell: UITableViewCell {
    
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var textLbl: UILabel!
    @IBOutlet weak var timerLbl: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        setupView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupView() {
        self.messageView.setCornerRadii(topLeft: 15, topRight: 15, bottomLeft: 5, bottomRight: 15)
    }
}

