//
//  ChannelService.swift
//  SacrenaChat
//

import Foundation
import StreamChat

protocol ChannelService {
    func createChannel(completion: @escaping (Bool) -> ())
    func sendMessage(_ text: String, completion: @escaping ([ChatMessage]) -> ())
}

class StreamChannelService: ChannelService {
    private var controller: ChatChannelController?
    private let channelId = Constants.API.channelId
    private let aliceUserId = Constants.User.aliceUserId
    private let bobUserId = Constants.User.bobUserId

    var membersUpdated: (([ChatMember]) -> Void)?
    var messagesUpdated: (([ChatMessage]) -> Void)?
    // Create the channel and fetch messages
    func createChannel(completion: @escaping (Bool) -> ()) {
        controller = try? ChatClient.shared.channelController(
            createChannelWithId: channelId,
            name: "Friendly Chat Between Alice & Bob",
            members: [aliceUserId, bobUserId],
            messageOrdering: .bottomToTop
        )
        controller?.delegate = self
        controller?.synchronize { [weak self] error in
            if let error = error {
                print("Error creating channel: \(error.localizedDescription)")
                completion(false)
                return
            }
            print("Channel created successfully.")
            self?.fetchMessages { success in
                completion(success)
            }
        }
    }
    
    private func fetchMessages(completion: @escaping (Bool) -> ()) {
        guard let messages = controller?.messages else {
            print("No messages found.")
            completion(false)
            return
        }
        processMessages(Array(messages))
        completion(true)
    }
    
    private func fetchMessages(completion: @escaping ([ChatMessage]) -> ()) {
        guard let messages = controller?.messages else {
            print("No messages found.")
            completion([])
            return
        }
        completion(Array(messages))
    }

    private func processMessages(_ messages: [ChatMessage]) {
      
        // Create a default ChatMember with user info
        let defaultChatMember = ChatMember(
            userInfo: Constants.User.userInfoBob,
            lastMessage: Constants.User.defaultMessage,
            messages: []
        )
        
        if let message = messages.last {
            let chatMember = ChatMember(
                userInfo: UserInfo(
                    id: message.author.id,
                    name: message.author.name ?? Constants.User.userInfoBob.name,
                    imageURL: message.author.imageURL ?? Constants.User.userInfoBob.imageURL
                ),
                lastMessage: message.text,
                messages: messages
            )
            membersUpdated?([chatMember])
        } else {
            membersUpdated?([defaultChatMember])
        }
    }

    // Send message in the current channel
    func sendMessage(_ text: String, completion: @escaping ([ChatMessage]) -> ()) {
        controller?.createNewMessage(text: text) { [weak self] result in
            switch result {
            case .success:
                print("Message sent successfully")
                self?.fetchMessages(completion: completion)
            case .failure(let error):
                print("Failed to send message: \(error.localizedDescription)")
                completion([])
            }
        }
    }
    
    private func handleUpdatedMessages() {
        self.fetchMessages { [weak self] messages in
            self?.messagesUpdated?(messages)
        }
    }
}

extension StreamChannelService: ChatChannelControllerDelegate {
    func channelController(
        _ channelController: ChatChannelController,
        didUpdateMessages changes: [ListChange<ChatMessage>]
    ) {
        
        changes.forEach { change in
            switch change {
            case .insert(let message, let index):
                print("New message received at index \(index): \(message.text )")
            case .update(let message, _):
                print("Message updated: \(message.text )")
                handleUpdatedMessages()
            case .move(let message, let fromIndex, let toIndex):
                print("Message moved from \(fromIndex) to \(toIndex): \(message.text )")
            case .remove(let message, let index):
                print("Message removed at index \(index): \(message.text )")
            }
        }
    }
    
}

