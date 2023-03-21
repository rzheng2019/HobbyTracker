//
//  HomeView.swift
//  HobbyTracker
//
//  Created by Ricky Zheng on 1/25/23.
//

import SwiftUI

struct HobbyHomeView: View {
    @EnvironmentObject var hobbyVM : HobbyViewModel

    let backgroundGradientTop    : UIColor     = #colorLiteral(red: 0.02009066319, green: 0.5374554866, blue: 1, alpha: 1)
    let backgroundGradientMiddle : UIColor     = #colorLiteral(red: 0.4191764474, green: 0.7535397965, blue: 1, alpha: 1)
    let backgroundGradientBottom : UIColor     = #colorLiteral(red: 1, green: 0.5100870974, blue: 0.852765969, alpha: 1)
    let backgroundIconColor      : UIColor     = #colorLiteral(red: 0.3323447383, green: 0.6419459536, blue: 1, alpha: 1)
    
    var body: some View {
        NavigationView {
            if (hobbyVM.userList.isEmpty) {
                ZStack {
                    VStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 100)
                                .frame(width: 350, height: 80)
                                .foregroundColor(Color(backgroundIconColor))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 100)
                                        .strokeBorder(Color(.white), lineWidth: 2))
                            
                            Text("Hobby Tracker")
                                .font(.custom("Avenir", size: 45))
                                .foregroundColor(.white)
                                .italic()
                        }
                        .padding(.bottom, 15)
                        
                        Text("\" Check Out Random Hobbies of the Day! \"")
                            .font(.custom("Avenir", size: 19))
                            .italic()
                            .padding(.bottom, 50)
                            .foregroundColor(Color.white)
                            .padding(.bottom, -30)
                        
                        HStack (alignment: .center, spacing: 10) {
                            ForEach(0..<2) { num in
                                ZStack {
                                    RoundedRectangle(cornerRadius: 20)
                                        .foregroundColor(Color(backgroundIconColor))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 20)
                                                .strokeBorder(.white, lineWidth: 2))
                                    VStack {
                                        if let randomHobby = hobbyVM.getDefaultHobbyList().randomElement() {
                                            if let randomImage = randomHobby.imageSymbol {
                                                Image(systemName: randomImage)
                                                    .resizable()
                                                    .background(Color(.clear))
                                                    .foregroundColor(.white)
                                                    .frame(width: 100, height: 100)
                                                Text(randomHobby.name)
                                                    .font(.custom("Avenir", size: 20))
                                                    .foregroundColor(.white)
                                            }
                                        }
                                    }
                                }
                            }
                            .frame(width: 160, height: 180)
                        }
                        .padding(.leading, 10)
                        .padding(.trailing, 10)
                        
                        HStack (alignment: .center, spacing: 10) {
                            ForEach(0..<2) { num in
                                ZStack {
                                    RoundedRectangle(cornerRadius: 20)
                                        .foregroundColor(Color(backgroundIconColor))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 20)
                                                .strokeBorder(.white, lineWidth: 2))
                                    VStack {
                                        if let randomHobby = hobbyVM.getDefaultHobbyList().randomElement() {
                                            if let randomImage = randomHobby.imageSymbol {
                                                Image(systemName: randomImage)
                                                    .resizable()
                                                    .background(Color(.clear))
                                                    .foregroundColor(.white)
                                                    .frame(width: 100, height: 100)
                                                Text(randomHobby.name)
                                                    .font(.custom("Avenir", size: 20))
                                                    .foregroundColor(.white)
                                            }
                                        }
                                    }
                                }
                            }
                            .frame(width: 160, height: 180)
                        }
                        .padding(.leading, 10)
                        .padding(.trailing, 10)
                        .padding(.bottom, 30)
                        
                        // Can be a new quote upon every load in screen
                        Text("\" A New Passion Awaits \"")
                            .font(.custom("Avenir", size: 25))
                            .italic()
                            .padding(.bottom, 50)
                            .foregroundColor(Color.white)
                        
                        NavigationLink(destination: HobbyAddView(),
                                       label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 50)
                                    .frame(width: 250, height: 50)
                                    .foregroundColor(Color(backgroundIconColor))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 50)
                                            .strokeBorder(.white, lineWidth: 4))
                                
                                Text("Get Started!")
                                    .font(.custom("Avenir", size: 30))
                                    .foregroundColor(Color.white)
                            }
                        })
                       
                        Spacer()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color(backgroundGradientBottom), Color(backgroundGradientMiddle), Color(backgroundGradientTop)]), startPoint: .bottom, endPoint: .top)
                )
            }
            else {
                HobbyGridView()
            }
        }
        .accentColor(Color(backgroundGradientBottom))
    }
}

struct HobbyHomeView_Previews: PreviewProvider {
    static var previews: some View {
        HobbyHomeView()
            .environmentObject(HobbyViewModel())
    }
}
