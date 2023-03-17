//
//  ContentView.swift
//  HobbyGuru
//
//  Created by Ricky Zheng on 1/24/23.
//

import SwiftUI

struct HobbyDetailView: View {
    @EnvironmentObject var HobbyVM : HobbyViewModel
    var hobby : Hobby = Hobby()
    
    var body: some View {
        VStack {
            HobbyIconView(hobby: hobby)
            
            HStack {
                Text("Rating : ")
                    .font(.system(size: 20))
                    .bold()
                Spacer()
            }
            .padding(.top, 15)
            HStack {
                Text("Category : ")
                    .font(.system(size: 20))
                    .bold()
                Spacer()
            }
            .padding(.top, 15)
            HStack {
                Text("Description :")
                    .font(.system(size: 20))
                    .bold()
                Spacer()
            }
            .padding(.top, 15)
            HStack {
                Text("Feedback :")
                    .font(.system(size: 20))
                    .bold()
                Spacer()
            }
            .padding(.top, 15)
            
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HobbyDetailView()
    }
}
