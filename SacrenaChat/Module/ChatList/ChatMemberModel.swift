//
//  ChatMemberModel.swift
//  SacrenaChat
//

import Foundation
import StreamChat

struct ChatMember {
    let userInfo: UserInfo
    var lastMessage: String
    var messages: [ChatMessage]
}
