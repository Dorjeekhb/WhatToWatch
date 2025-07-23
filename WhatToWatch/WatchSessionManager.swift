//
//  WatchSessionManager.swift
//  WhatToWatch
//
//  Created by Dorjee on 23/7/25.
//

import Foundation
import WatchConnectivity
import UIKit
import UserNotifications

class WatchSessionManager: NSObject, WCSessionDelegate {
    static let shared = WatchSessionManager()

    private override init() {
        super.init()
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }

        UNUserNotificationCenter.current().delegate = self
    }

    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        handleTrailerMessage(message)
    }

    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        handleTrailerMessage(applicationContext)
    }

    private func handleTrailerMessage(_ message: [String: Any]) {
        guard message["action"] as? String == "openTrailerNotification",
              let id = message["id"] as? Int,
              let type = message["type"] as? String,
              let title = message["title"] as? String else { return }

        TMDbService.shared.fetchTrailer(for: type, id: id) { url in
            guard let url = url else { return }

            let content = UNMutableNotificationContent()
            content.title = "🎞️ Tráiler disponible"
            content.body = title
            content.userInfo = ["trailerURL": url.absoluteString]
            content.sound = .default

            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

            UNUserNotificationCenter.current().add(request)
        }
    }

    func sessionDidBecomeInactive(_ session: WCSession) {}
    func sessionDidDeactivate(_ session: WCSession) {
        WCSession.default.activate()
    }
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {}
}

extension WatchSessionManager: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse,
                                 withCompletionHandler completionHandler: @escaping () -> Void) {
        if let urlString = response.notification.request.content.userInfo["trailerURL"] as? String,
           let url = URL(string: urlString) {
            DispatchQueue.main.async {
                UIApplication.shared.open(url)
            }
        }

        completionHandler()
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification,
                                 withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }
}
