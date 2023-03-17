//
//  HobbySplashScreen.swift
//  HobbyTracker
//
//  Created by Ricky Zheng on 2/9/23.
//

import SwiftUI

struct HobbySplashScreen: View {
    
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    let backgroundGradientTop    : UIColor     = #colorLiteral(red: 0.02009066319, green: 0.5374554866, blue: 1, alpha: 1)
    let backgroundGradientMiddle : UIColor     = #colorLiteral(red: 0.4191764474, green: 0.7535397965, blue: 1, alpha: 1)
    let backgroundGradientBottom : UIColor     = #colorLiteral(red: 1, green: 0.5100870974, blue: 0.852765969, alpha: 1)
    
    var body: some View {
        if isActive {
            HobbyHomeView()
        } else {
            ZStack {
                HStack {
                    Text("Hobby Tracker")
                        .font(.custom("Avenir", size: 55))
                        .foregroundColor(Color.white)
                }
            }
            .ignoresSafeArea()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                LinearGradient(gradient: Gradient(colors: [Color(backgroundGradientBottom), Color(backgroundGradientMiddle), Color(backgroundGradientTop)]), startPoint: .bottom, endPoint: .top)
            )
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

struct HobbySplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        HobbySplashScreen()
    }
}
