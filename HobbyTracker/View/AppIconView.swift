//
//  AppIconView.swift
//  HobbyTracker
//
//  Created by Ricky Zheng on 2/9/23.
//

import SwiftUI

struct AppIconView: View {
    let backgroundGradientTop    : UIColor     = #colorLiteral(red: 0.02009066319, green: 0.5374554866, blue: 1, alpha: 1)
    let backgroundGradientMiddle : UIColor     = #colorLiteral(red: 0.4191764474, green: 0.7535397965, blue: 1, alpha: 1)
    let backgroundGradientBottom : UIColor     = #colorLiteral(red: 1, green: 0.5100870974, blue: 0.852765969, alpha: 1)
    let backgroundIconColor : UIColor = #colorLiteral(red: 0.3323447383, green: 0.6419459536, blue: 1, alpha: 1)
    
    var body: some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: 20)
                .fill(                    LinearGradient(gradient: Gradient(colors: [Color(backgroundGradientBottom), Color(backgroundGradientTop)]), startPoint: .bottom, endPoint: .top))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .strokeBorder(.white, lineWidth: 2))
            
            VStack (alignment: .center) {
                HStack (alignment: .center) {
                    VStack {
                        Text("Hobby")
                            .font(.custom("Avenir", size: 40))
                            .foregroundColor(.white)
                        Text("Tracker")
                            .font(.custom("Avenir", size: 40))
                            .foregroundColor(.white)
                    }
                }
            }
        }
        .frame(width: 170, height: 160)
    }
}

struct AppIconView_Previews: PreviewProvider {
    static var previews: some View {
        AppIconView()
    }
}
