//
//  ChatClient.swift
//  SacrenaChat
//


import Foundation
import StreamChat

extension ChatClient {
    static let shared: ChatClient = {
        let config = ChatClientConfig(apiKeyString: "3yj885j8qctk")
        return ChatClient(config: config)
    }()
}
