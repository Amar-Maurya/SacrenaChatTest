//
//  ChatListViewControllerBuilder.swift
//  SacrenaChat
//

import UIKit

class ChatListViewControllerBuilder {
    
    private var members: [ChatMember] = []

    func withMembers(_ members: [ChatMember]) -> ChatListViewControllerBuilder {
        self.members = members
        return self
    }

    func build() -> UINavigationController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let navController = storyboard.instantiateViewController(withIdentifier: "ChatListNavigationController") as? UINavigationController,
           let chatListVC = navController.viewControllers.first as? ChatListViewController {
            chatListVC.members = members
            return navController
        }
        return nil
    }
}
