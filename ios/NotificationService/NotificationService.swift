//
//  NotificationService.swift
//  NotificationService
//
//  Created by Baris Arslan on 16.06.2021.
//
import UserNotifications
import Euromsg

class NotificationService: UNNotificationServiceExtension {

        var contentHandler: ((UNNotificationContent) -> Void)?
        var bestAttemptContent: UNMutableNotificationContent?

        override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
                self.contentHandler = contentHandler
                bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
                Euromsg.didReceive(bestAttemptContent, withContentHandler: contentHandler)
        }
        
        override func serviceExtensionTimeWillExpire() {
                // Called just before the extension will be terminated by the system.
                // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
                if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
                        Euromsg.didReceive(bestAttemptContent, withContentHandler: contentHandler)
                }
        }

}
