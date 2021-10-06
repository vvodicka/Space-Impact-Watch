//
//  WCSessionDelegate.swift
//  Space Impact iOS
//
//  Created by Vladislav Vodicka on 07/05/2021.
//

import WatchConnectivity
import GameKit

class ConnectivityProvider: NSObject, WCSessionDelegate {
    
    private let session: WCSession
    
    var defaults: UserDefaults!
    
    init(session: WCSession = .default) {
        defaults = UserDefaults.standard
        self.session = session
        super.init()
        self.session.delegate = self
        self.connect()
    }
    
    func connect() {
        guard WCSession.isSupported() else {
            print("WCSession is not supported")
            return
        }
        
        session.activate()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        // code
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        if message["topRankedScore"] != nil {
            
            defaults.set(message["topRankedScore"], forKey: "rankedHighScore")
            
            replyHandler(["ok": true])
        }
    }
    
    func getScore() -> Int {
        return defaults.integer(forKey: "rankedHighScore")
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        // code
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        // code
    }
    
}
