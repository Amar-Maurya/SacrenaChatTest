//
//  Constants.swift
//  SacrenaChat
//

import Foundation
import StreamChat

struct Constants {
    struct API {
        static let apiKeyString = "3yj885j8qctk"
        static let nonExpiringToken: Token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiYWxpY2UifQ.wo8L0ns26VaOxeQ_P3xjGsVWBSEhRnGNOZFkB6uyPYM"
        static let channelId = ChannelId(type: .messaging, id: "alice_bob_chat_channel")
    }

    struct User {
        static let aliceUserId = "alice"
        static let bobUserId = "bob"
        
        static let userInfoAlice = UserInfo(
            id: aliceUserId,
            name: "Alice",
            imageURL: URL(string: "https://cutt.ly/SmeFRfC")
        )
        
        static let userInfoBob = UserInfo(
            id: bobUserId,
            name: "Bob",
            imageURL: URL(string: "https://example.com/bob_image") // Provide Bob's image URL
        )
        
        static let defaultMessage = "Send a message an embark on a journey of discovery together."
    }
}

