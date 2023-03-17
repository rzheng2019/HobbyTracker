//
//  HomeView.swift
//  HobbyGuru
//
//  Created by Ricky Zheng on 1/24/23.
//

import SwiftUI

struct HobbyIconView: View {
    @EnvironmentObject var HobbyVM : HobbyViewModel
    
    let hobby: Hobby
    let cardBackgroundColor : UIColor = #colorLiteral(red: 0.8340291252, green: 0.9201762253, blue: 1, alpha: 1)
    
    var body: some View {
        VStack {
            ZStack {
                Color(cardBackgroundColor)
                    .ignoresSafeArea()
                VStack (alignment: .center) {
                    VStack {
                        Image(systemName: hobby.imageSymbol)
                            .resizable()
                        .frame(width: 100, height: 100)
                        Text(hobby.name)
                            .font(.system(size: 30))
                            .bold()                    }
                }
            }
            .frame(width: 175, height: 180)
            
            VStack {
                Text(hobby.description)
                    .font(.system(size: 20))
            }
        }
    }
}

struct HobbyView_Previews: PreviewProvider {
    static var previews: some View {
        HobbyIconView(hobby: Hobby.sampleHobby)
    }
}
