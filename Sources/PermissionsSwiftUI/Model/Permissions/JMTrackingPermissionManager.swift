//
//  JMTrackingPermissionManager.swift
//  
//
//  Created by Jevon Mao on 2/2/21.
//

import Foundation
import AppTrackingTransparency
import AdSupport

@available(iOS 14.5, *)
struct JMTrackingPermissionManager: PermissionManager {

    static var shared: PermissionManager = JMTrackingPermissionManager()
    var authorizationStatus: AuthorizationStatus{
        switch ATTrackingManager.trackingAuthorizationStatus{
        case .authorized:
            return .authorized
        case .notDetermined:
            return .notDetermined
        default:
            return .denied
        }
    }
    
    public static var advertisingIdentifier:UUID{
        ASIdentifierManager.shared().advertisingIdentifier
    }
    func requestPermission(_ completion: @escaping (Bool) -> Void) {
        ATTrackingManager.requestTrackingAuthorization { status in
                  switch status {
                  case .authorized:
                      completion(true)
                  case .notDetermined:
                      break
                  default:
                      completion(false)
                  }
              }
    }
}
