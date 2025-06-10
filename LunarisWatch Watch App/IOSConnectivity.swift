//
//  IOSConnectivity.swift
//  LunarisWatch Watch App
//
//  Created by Christianto Elvern Haryanto on 11/06/25.
//

import Foundation
import WatchConnectivity

// MARK: - IOSConnectivity Class
class IOSConnectivity: NSObject, WCSessionDelegate, ObservableObject {
    
    var session: WCSession

    init(session: WCSession = .default) {
        self.session = session
        super.init()
        session.delegate = self
        session.activate()
    }
    
    // Session activation callback
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: (any Error)?) {
        if let error = error {
            print("Error activating WCSession: \(error.localizedDescription)")
        } else {
            print("WCSession activated with state: \(activationState.rawValue)")
        }
    }

    // Send any model conforming to WatchTransferable
    func sendToiOS(data: WatchTransferable) {
        if session.isReachable {
            session.sendMessage(data.dictionaryRepresentation, replyHandler: { response in
                print("Data sent successfully: \(response)")
            }, errorHandler: { error in
                print("Error sending message: \(error.localizedDescription)")
            })
        } else {
            print("WCSession is not reachable.")
        }
    }
}
