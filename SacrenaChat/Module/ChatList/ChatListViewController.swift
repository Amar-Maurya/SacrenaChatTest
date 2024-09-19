//
//  ChatListViewController.swift
//  SacrenaChat
//

import UIKit
import StreamChat

import UIKit

class ChatListViewController: UIViewController {
    @IBOutlet weak var chatTableView: UITableView!
    var members: [ChatMember] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadTableView()
    }

    private func setupTableView() {
        chatTableView.dataSource = self
        chatTableView.delegate = self
        registerCell()
    }

    private func registerCell() {
        let nib = UINib(nibName: "ChatTableViewCell", bundle: nil)
        chatTableView.register(nib, forCellReuseIdentifier: "ChatTableViewCell")
    }

    private func reloadTableView() {
        DispatchQueue.main.async {
            self.chatTableView.reloadData()
        }
    }
}

extension ChatListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChatTableViewCell", for: indexPath) as? ChatTableViewCell else {
            return UITableViewCell()
        }
        configureCell(cell, at: indexPath)
        return cell
    }

    private func configureCell(_ cell: ChatTableViewCell, at indexPath: IndexPath) {
        let member = members[indexPath.row]
        cell.textLbl.text = member.lastMessage
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMember = members[indexPath.row]
        navigateToDetailPage(with: selectedMember)
    }

    private func navigateToDetailPage(with member: ChatMember) {
        let detailViewModel = ChatDetailViewModel(chatMember: member)
        guard let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChatDetailViewController") as? ChatDetailViewController else { return }
        detailVC.viewModel = detailViewModel
        detailVC.viewModel?.onUpdate = { [weak self] updatedMember in
            if let index = self?.members.firstIndex(where: { $0.userInfo.id == updatedMember.userInfo.id }) {
                self?.members[index] = updatedMember
                self?.reloadTableView()
            }
        }
        navigationController?.pushViewController(detailVC, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
