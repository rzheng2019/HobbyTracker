//
//  HobbyTrackerApp.swift
//  HobbyTracker
//
//  Created by Ricky Zheng on 1/24/23.
//

import SwiftUI
import Firebase

@main
struct HobbyTrackerApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            HobbySplashScreen()
                .environmentObject(HobbyViewModel())
        }
    }
}
