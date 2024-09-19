//
//  ChatFlowManager.swift
//  SacrenaChat
//

import Foundation
import UIKit
import StreamChat

class ChatFlowManager {
    private let userService: UserService
    private let channelService: ChannelService
    private var members: [ChatMember] = []
    var receivedMessages: (([ChatMessage]) -> Void)?
    
    init(userService: UserService, channelService: ChannelService) {
        self.userService = userService
        self.channelService = channelService

        // Set the closure to handle member updates
        if let streamService = channelService as? StreamChannelService {
            streamService.membersUpdated = { [weak self] members in
                self?.handleMembersUpdated(members)
            }
            streamService.messagesUpdated = { [weak self] message in
                self?.receivedMessages?(message)
            }
        }
    }

    func initializeChatFlow() {
        userService.createUser { [weak self] success in
            guard let self = self else {
                print("ChatFlowManager instance is nil")
                return
            }
            guard success else { return }
            self.channelService.createChannel { success in
                guard success else { return }
            }
        }
    }
    
    
    
    private func handleMembersUpdated(_ members: [ChatMember]) {
        self.members = members
        setupChatListViewController()
    }
    
    private func setupChatListViewController() {
        let builder = ChatListViewControllerBuilder()
        if let navController = builder.withMembers(members).build() {
            if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                sceneDelegate.window?.rootViewController = navController
                sceneDelegate.window?.makeKeyAndVisible()
            }
        }
    }


    func sendMessage(_ text: String, completion: @escaping ([ChatMessage]) -> ()) {
        channelService.sendMessage(text, completion: completion)
    }
}
