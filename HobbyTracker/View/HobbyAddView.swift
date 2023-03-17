//
//  AddHobbyView.swift
//  HobbyTracker
//
//  Created by Ricky Zheng on 1/25/23.
//

import SwiftUI

struct HobbyAddView: View {
    @EnvironmentObject var hobbyVM : HobbyViewModel
    
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    let backgroundGradientTop : UIColor = #colorLiteral(red: 0.02009066319, green: 0.5374554866, blue: 1, alpha: 1)
    let backgroundGradientMiddle : UIColor = #colorLiteral(red: 0.4191764474, green: 0.7535397965, blue: 1, alpha: 1)
    let backgroundGradientBottom : UIColor = #colorLiteral(red: 1, green: 0.5100870974, blue: 0.852765969, alpha: 1)
    let backgroundIconColor : UIColor = #colorLiteral(red: 0.3323447383, green: 0.6419459536, blue: 1, alpha: 1)
    
    @State private var showingAddedAlert = false
    @State private var showingExistedAlert = false
    
    var body: some View {
        ScrollView {
            HStack (alignment: .center){
                Text("Find a Hobby")
                    .font(.system(size: 40))
                    .foregroundColor(.white)
                    .bold()
                    .fontDesign(.serif)
            }
            
            LazyVGrid(columns: adaptiveColumns, spacing: 20) {
                ForEach(hobbyVM.filteredHobby) { hobby in
                    VStack {
                        HobbyIconView(hobby: hobby)
                        Button("Add +") {
                            // Only add if it already doesn't exist in userList
                            if !checkExistingHobbyList(hobbyName: hobby.name, userList: hobbyVM.userList) {
                                // Add to Firebase
                                hobbyVM.addHobby(hobby: hobby)
                                showingAddedAlert = true
                            }
                            else {
                                showingExistedAlert = true
                            }
                        }
                        .alert("Added Hobby!", isPresented: $showingAddedAlert) {
                            Button("OK") {}
                        }
                        .alert("Hobby Already Added!", isPresented: $showingExistedAlert) {
                            Button("OK") {}
                        }
                    }
                }
                .animation(.easeIn(duration: 0.3), value: hobbyVM.filteredHobby.count)
            }
            .padding(.bottom, 40)
        }
        .searchable(text: $hobbyVM.searchText)
        .foregroundColor(Color.white)
        .scrollIndicators(.hidden)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color(backgroundGradientBottom), Color(backgroundGradientMiddle), Color(backgroundGradientTop)]), startPoint: .bottom, endPoint: .top)
        )
        
    }
}

func checkExistingHobbyList(hobbyName : String, userList : [Hobby]) -> Bool {
    for hobby in userList {
        if hobbyName == hobby.name {
            return true
        }
    }
    return false
}

struct HobbyAddView_Previews: PreviewProvider {
    static var previews: some View {
        HobbyAddView()
            .environmentObject(HobbyViewModel())
    }
}
