//
//  ChatDetailViewController+ChatInputViewDelegate.swift
//  SacrenaChat
//

import UIKit

extension ChatDetailViewController: ChatInputViewDelegate {
    func didupdateTextViewHeight(_ height: CGFloat) {
        chatInputViewBottomConstraint.constant = height <= 77 ? 45 + height : 77 + 45
        UIView.animate(withDuration: 0.2) {
            self.chatInputView.layoutIfNeeded()
        }
    }

    func didPressSendButton(withText text: String) {
        viewModel?.sendMessage(text, completion: { [weak self] value in
            self?.setupViewModelBindings()
        })
    }

    func didPressCameraButton() {
        imagePickerHelper.openCamera()
        print("Camera button pressed")
    }
}
