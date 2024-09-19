//
//  ChatDetailViewModel.swift
//  SacrenaChat
//

import Foundation
import StreamChat
import UIKit


class ChatDetailViewModel {
    private var chatMember: ChatMember
    private var mesageShortestList: [MesageShortestList] = []
    var receivedMessages: (([MesageShortestList]) -> Void)?
    var onUpdate: ((ChatMember) -> Void)?
    init(chatMember: ChatMember) {
        self.chatMember = chatMember
        filterMessages(chatMember.messages)
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            let chatFlowManager = sceneDelegate.chatFlowManager
            chatFlowManager?.receivedMessages = { [weak self] message in
                self?.handleReceivedMessages(message)
            }
        }
    }
    
    private func handleReceivedMessages(_ messages: [ChatMessage]) {
           filterMessages(messages)
       }

    private func filterMessages(_ messages: [ChatMessage])  {
        mesageShortestList = MesageShortestList.groupMessagesByDate(messages: messages)
        chatMember.messages = messages
        chatMember.lastMessage = messages.last?.text ?? ""
        onUpdate?(chatMember)
        receivedMessages?(mesageShortestList)
    }
    
    func getUpdatedMessage(completion: @escaping ([MesageShortestList]) -> Void) {
        completion(self.mesageShortestList)
    }
    
    func sendMessage(_ newMessage: String, completion: @escaping (Bool) -> ()) {
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            let chatFlowManager = sceneDelegate.chatFlowManager
            chatFlowManager?.sendMessage(newMessage, completion: { [weak self] value in
                self?.filterMessages(value)
                completion(true)
            })
        }
    }
}
