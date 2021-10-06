//
//  WatchConnectivityProvider.swift
//  Space Impact watchOS App Extension
//
//  Created by Vladislav Vodicka on 18/05/2021.
//

import WatchConnectivity
import GameKit

class WatchConnectivityProvider: NSObject, WCSessionDelegate {
    
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
    
    func sendScore(score: Int, completion: @escaping (Bool)->()) {
        session.sendMessage(["topRankedScore": score], replyHandler: { reply in
            if reply["ok"] != nil {
                completion(true)
            } else {
                completion(false)
            }
        }) { (error) in
            print(error.localizedDescription)
            completion(false)
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        // code
    }
    
}

