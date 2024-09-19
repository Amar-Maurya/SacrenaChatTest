//
//  ChatDetailViewController+TableView.swift
//  SacrenaChat
//


import UIKit

extension ChatDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return messageList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageList[section].messageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = messageList[indexPath.section].messageList[indexPath.row]
        let cellIdentifier = item.isSendMyCurrentUser ? "SenderMessgeTVCell" : "ReceiverMessageTVCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        if let cell = cell as? SenderMessgeTVCell {
            cell.textLbl.text = item.text
            cell.timerLbl.text = item.msgDate
        } else if let cell = cell as? ReceiverMessageTVCell {
            cell.textLbl.text = item.text
            cell.timerLbl.text = item.msgDate
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let dayLabelView = DayLabelView(frame: CGRect(x: 0, y: 10, width: 120, height: 25))
        dayLabelView.translatesAutoresizingMaskIntoConstraints = false
        dayLabelView.dayLabel.text = messageList[section].timeLbl.uppercased()
        headerView.addSubview(dayLabelView)
        NSLayoutConstraint.activate([
            dayLabelView.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            dayLabelView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            dayLabelView.widthAnchor.constraint(equalToConstant: 120),
            dayLabelView.heightAnchor.constraint(equalToConstant: 25)
        ])
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
}

