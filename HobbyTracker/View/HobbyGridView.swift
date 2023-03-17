//
//  HobbyGridView.swift
//  HobbyTracker
//
//  Created by Ricky Zheng on 1/26/23.
//

import SwiftUI

struct HobbyGridView: View {
    @EnvironmentObject var hobbyVM : HobbyViewModel
    
    let backgroundIconColor : UIColor = #colorLiteral(red: 0.3323447383, green: 0.6419459536, blue: 1, alpha: 1)
    
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    let backgroundGradientTop : UIColor = #colorLiteral(red: 0.02009066319, green: 0.5374554866, blue: 1, alpha: 1)
    let backgroundGradientMiddle : UIColor = #colorLiteral(red: 0.4191764474, green: 0.7535397965, blue: 1, alpha: 1)
    let backgroundGradientBottom : UIColor = #colorLiteral(red: 1, green: 0.5100870974, blue: 0.852765969, alpha: 1)
    
    var body: some View {
        ScrollView {
            VStack {
                HStack (alignment: .center){
                    Text("My Hobby List")
                        .font(.custom("Avenir", size: 40))
                        .foregroundColor(.white)
                }
                .padding(.bottom, 5)
            }
            
            LazyVGrid(columns: adaptiveColumns, spacing: 20) {
                // Need index of list too for saving purposes
                ForEach(hobbyVM.userList, id: \.id) { hobby in
                    // FUTURE TASK: Fix issue where multiple views are using the same hobby.id
                    NavigationLink {
                        HobbyDetailView(hobby: hobby)
                    } label: {
                        HobbyIconView(hobby: hobby)
                    }
//                    HobbyIconView(hobby: hobby)
                }
            }
            .padding(.bottom, 35)
            
            NavigationLink(destination: HobbyAddView(),
                           label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 50)
                        .frame(width: 250, height: 50)
                        .foregroundColor(Color(backgroundIconColor))
                        .overlay(
                            RoundedRectangle(cornerRadius: 50)
                                .strokeBorder(.white, lineWidth: 4))

                    Text("Add New Hobby +")
                        .font(.custom("Avenir", size: 17))
                        .foregroundColor(Color.white)
                }
            })
        }
        .scrollIndicators(.hidden)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color(backgroundGradientBottom), Color(backgroundGradientMiddle), Color(backgroundGradientTop)]), startPoint: .bottom, endPoint: .top)
        )
    }
}

struct HobbyGridView_Previews: PreviewProvider {
    static var previews: some View {
        HobbyGridView()
            .environmentObject(HobbyViewModel())
    }
}
