//
//  HomeIconView.swift
//  HobbyTracker
//
//  Created by Ricky Zheng on 1/24/23.
//

import SwiftUI

struct HobbyIconView: View {
    @EnvironmentObject var HobbyVM : HobbyViewModel
    
    let hobby: Hobby
    let backgroundIconColor : UIColor = #colorLiteral(red: 0.3323447383, green: 0.6419459536, blue: 1, alpha: 1)
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(Color(backgroundIconColor))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .strokeBorder(.white, lineWidth: 2))
                
                VStack (alignment: .center) {
                    if let imageString = hobby.imageSymbol {
                        Image(systemName: imageString)
                            .resizable()
                            .frame(width: 80, height: 90)
                            .foregroundColor(.white)
                        
                    }
                    else {
                        Image(systemName: "photo")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.white)
                    }
                    HStack (alignment: .center) {
                        Text(hobby.name)
                            .font(.custom("Avenir", size: 16))
                            .foregroundColor(.white)
                    }
                }
            }
            .frame(width: 170, height: 160)
        }
    }
}

struct HobbyIconView_Previews: PreviewProvider {
    static var previews: some View {
        HobbyIconView(hobby: Hobby.sampleHobby)
    }
}
