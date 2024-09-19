//
//  ChatDetailViewController+ProfileNavigationDelegate.swift
//  SacrenaChat
//

import UIKit

extension ChatDetailViewController: ProfileNavigationDelegate {
    func didTapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }

    func didTapMenuButton() {
        print("Menu button tapped")
    }
}
