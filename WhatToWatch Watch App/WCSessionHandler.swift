//
//  WCSessionHandler.swift
//  WhatToWatch
//
//  Created by Dorjee on 23/7/25.
//


import Foundation
import WatchConnectivity

class WCSessionHandler: NSObject, WCSessionDelegate {
    static let shared = WCSessionHandler()

    private override init() {
        super.init()
    }

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("✅ Watch WCSession activated: \(activationState.rawValue)")
    }

    func sessionReachabilityDidChange(_ session: WCSession) {
        print("🔄 Reachability changed: \(session.isReachable)")
    }

    // Requerido aunque no hagas nada aquí
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {}
}
