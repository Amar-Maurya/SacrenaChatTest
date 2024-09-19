//
//  ChatTableViewCell.swift
//  AmarAssign
//
//  Created by Apple on 9/15/24.
//

import UIKit

class ChatTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var statuslbl: UILabel!
    @IBOutlet weak var textLbl: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupUI() {
        userImg.clipsToBounds = true
        userImg.layer.cornerRadius = userImg.frame.size.width / 2
        
        statuslbl.clipsToBounds = true
        statuslbl.layer.cornerRadius = statuslbl.frame.size.width / 2
    }
}
