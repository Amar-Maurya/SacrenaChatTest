//
//  ReceiverMessageTVCell.swift
//  SacrenaChat
//
import UIKit

class ReceiverMessageTVCell: UITableViewCell {
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var textLbl: UILabel!
    @IBOutlet weak var timerLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        setupView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func setupView() {
        self.messageView.setCornerRadii(topLeft: 15, topRight: 15, bottomLeft: 15, bottomRight: 5)
    }
    
}
