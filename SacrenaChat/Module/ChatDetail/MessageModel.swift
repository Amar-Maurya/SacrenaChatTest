//
//  MessageModel.swift
//  SacrenaChat
//

import Foundation
import StreamChat

struct MesageShortestList {
    var timeLbl: String
    var messageList: [MessageModel]
    var userInfo: UserInfo
}

struct MessageModel {
    let id: String
    let text: String
    let msgDate: String
    let isSendMyCurrentUser: Bool
}


extension MesageShortestList {
    
    static func groupMessagesByDate(messages: [ChatMessage]) -> [MesageShortestList] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        
        // Get current calendar and current date
        let calendar = Calendar.current
        let currentDate = Date()
        
        // Dictionary to group messages by date
        var groupedMessages = [String: [MessageModel]]()
        var dateMapping = [String: Date]()  // Store the actual date for each key
        
        for message in messages {
            let messageDate = message.createdAt
            let dateString: String
            
            // Check if the message date is today
            if calendar.isDateInToday(messageDate) {
                dateString = "Today"
            }
            // Check if the message date is yesterday
            else if calendar.isDateInYesterday(messageDate) {
                dateString = "Yesterday"
            }
            // Check if the message date is within the current week
            else if calendar.isDate(messageDate, equalTo: currentDate, toGranularity: .weekOfYear) {
                let weekdayFormatter = DateFormatter()
                weekdayFormatter.dateFormat = "EEEE" // Day of the week
                dateString = weekdayFormatter.string(from: messageDate)
            }
            // Otherwise, format it as 'dd MMM yyyy'
            else {
                dateString = dateFormatter.string(from: messageDate)
            }
            
            // Track the date associated with each string key
            dateMapping[dateString] = messageDate
            
            // Add messages to the appropriate group
            let messageModel = MessageModel(id: message.id, text: message.text, msgDate: message.createdAt.to12HourClockFormat(), isSendMyCurrentUser: message.isSentByCurrentUser)
            if groupedMessages[dateString] != nil {
                groupedMessages[dateString]?.append(messageModel)
            } else {
                groupedMessages[dateString] = [messageModel]
            }
        }
        
        // Sort the keys based on the actual date, but with "Today" last and "Yesterday" second to last
        let sortedKeys = groupedMessages.keys.sorted { (dateKey1, dateKey2) -> Bool in
            if dateKey1 == "Today" {
                return false // "Today" should come last
            }
            if dateKey2 == "Today" {
                return true
            }
            if dateKey1 == "Yesterday" {
                return false // "Yesterday" should come second to last
            }
            if dateKey2 == "Yesterday" {
                return true
            }
            // Compare the actual dates for the rest
            return dateMapping[dateKey1]! > dateMapping[dateKey2]!
        }
        
        // Create MesageShortestList for each date
        let mesageShortestLists = sortedKeys.map { dateKey in
            let messagesForDate = groupedMessages[dateKey]!
            return MesageShortestList(timeLbl: dateKey, messageList: messagesForDate, userInfo: Constants.User.userInfoBob)
        }
        
        return mesageShortestLists
    }
}
