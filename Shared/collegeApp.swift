//
//  collegeApp.swift
//  Shared
//
//  Created by Min Jae Lee on 2021/02/20.
//

import SwiftUI
import Firebase

@main
struct collegeApp: App {
    
    @UIApplicationDelegateAdaptor(Delegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(SessionStore())
        }
    }
}

// Connecting Firebase ...

class Delegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        NetworkService.shared.startMonitoring()
        return true
    }
}
