//
//  HobbyDetalView.swift
//  HobbyTracker
//
//  Created by Ricky Zheng on 1/24/23.
//

import SwiftUI

struct HobbyDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var hobbyVM : HobbyViewModel
    
    @State var hobby : Hobby
    
    let backgroundGradientTop : UIColor = #colorLiteral(red: 0.02009066319, green: 0.5374554866, blue: 1, alpha: 1)
    let backgroundGradientMiddle : UIColor = #colorLiteral(red: 0.4191764474, green: 0.7535397965, blue: 1, alpha: 1)
    let backgroundGradientBottom : UIColor = #colorLiteral(red: 1, green: 0.5100870974, blue: 0.852765969, alpha: 1)
    let backgroundIconColor : UIColor = #colorLiteral(red: 0.3323447383, green: 0.6419459536, blue: 1, alpha: 1)
    
    @State var descriptionField : String = ""
    @State var feedbackField : String = ""
    
    init(hobby : Hobby) {
        self._hobby = State(initialValue: hobby)
        if let description = hobby.description {
            self._descriptionField = State(initialValue: description)
        }
        if let feedback = hobby.feedback {
            self._feedbackField = State(initialValue: feedback)
        }
    }
    
    var body: some View {
        ScrollView {
            ZStack {
                VStack {
                    iconView(hobby: hobby)
                    
                    singleTextHeaderView(headerTitle: "Rating")
                    
                    HobbyRatingView(hobby: $hobby, starColor: .white)
                    
                    singleTextHeaderView(headerTitle: "Category")
                    
                    categoryView(hobby: hobby)
                    
                    textBoxView(title: "Description", textFieldString: $descriptionField)
                    
                    textBoxView(title: "Feedback", textFieldString: $feedbackField)
                    
                    saveButton(hobby : hobby, description: descriptionField, feedback: feedbackField)
                    
                    deleteButton(hobby : hobby)
                }
            }
        }
        .scrollIndicators(.hidden)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color(backgroundGradientBottom), Color(backgroundGradientMiddle), Color(backgroundGradientTop)]), startPoint: .bottom, endPoint: .top)
        )
    }
}

struct iconView : View {
    let hobby : Hobby
    
    var body : some View {
        HobbyIconView(hobby: hobby)
            .padding(.top)
    }
}

struct categoryView : View {
    let hobby : Hobby
    
    var body : some View {
        HStack (alignment: .center) {
            if let category = hobby.category {
                Text(String(category))
                    .font(.custom("Avenir", size: 20))
                    .foregroundColor(.white)
            }
            else {
                Text("Category")
                    .font(.custom("Avenir", size: 20))
                    .foregroundColor(.white)
            }
        }
        .padding(.bottom, 4)
    }
}

struct singleTextHeaderView: View  {
    var headerTitle: String = "Placeholder Title"
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .frame(width: 360, height: 40)
                    .foregroundColor(Color.clear)
                    .overlay(
                        Rectangle()
                            .strokeBorder(.white, lineWidth: 2))
                HStack {
                    Text(headerTitle)
                        .font(.custom("Avenir", size: 20))
                        .fontDesign(.serif)
                        .foregroundColor(Color.white)
                }
            }
            .padding(.top, 15)
        }
    }
}

struct textBoxView: View {
    @EnvironmentObject var hobbyVM : HobbyViewModel
    
    var title : String = "Title"
    @State var placeholderText : String = "Write whatever you want!"
    @Binding var textFieldString : String
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .frame(width: 360, height: 40)
                    .foregroundColor(Color.clear)
                    .overlay(
                        Rectangle()
                            .strokeBorder(.white, lineWidth: 2))
                HStack {
                    Text(title)
                        .font(.custom("Avenir", size: 20))
                        .foregroundColor(Color.white)
                }
            }
            .padding(.bottom, 10)
            
            ZStack {
                if textFieldString.isEmpty {
                    TextEditor(text: $placeholderText)
                        .foregroundColor(Color.gray)
                        .font(.custom("Avenir", size: 20))
                        .scrollContentBackground(.hidden)
                        .disabled(true)
                }
                TextEditor(text: $textFieldString)
                    .foregroundColor(Color.white)
                    .font(.custom("Avenir", size: 20))
                    .scrollContentBackground(.hidden)

                Text(textFieldString)
                    .foregroundColor(Color.white)
                    .scrollContentBackground(.hidden)
                    .frame(minHeight: 40)
                    .frame(maxWidth: .infinity)
                    .opacity(0)
            }
            .padding(.leading, 12)
        }
        .padding(.bottom, 15)
    }
}

struct saveButton : View {
//    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var hobbyVM : HobbyViewModel
    
    let hobby : Hobby
    @State private var showingSaveAlert = false
    
    var description : String = ""
    var feedback : String = ""
    
    let saveButtonColor : UIColor = #colorLiteral(red: 0.3323447383, green: 0.6419459536, blue: 1, alpha: 1)
    
    var body : some View {
        Button(action: {
            // Save Hobby
            showingSaveAlert = true
        }, label: {
            ZStack {
                RoundedRectangle(cornerRadius: 50)
                    .frame(width: 250, height: 50)
                    .foregroundColor(Color(saveButtonColor))
                    .overlay(
                        RoundedRectangle(cornerRadius: 50)
                            .strokeBorder(.white, lineWidth: 4))
                
                Text("Save")
                    .font(.custom("Avenir", size: 25))
                    .foregroundColor(Color.white)
            }
        })
        .alert(isPresented: $showingSaveAlert) {
            Alert(title: Text("Are you sure you want to save hobby?"),
                  primaryButton: .destructive(Text("Cancel")),
                  secondaryButton: .default(Text("Save")) {
//                if let hobbyID = hobby.id {
                if let index = hobbyVM.searchHobbyID(id: hobby.id) {
                    hobbyVM.saveInformation(index: index,
                                            rating: hobby.rating,
                                            description: description,
                                            feedback: feedback)
                }
//                }
            })
        }
    }
}

struct deleteButton : View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var hobbyVM : HobbyViewModel
    
    @State var hobby : Hobby = Hobby()
    //    @State private var showingSaveAlert = false
    @State private var showingDeleteAlert = false
    
    let deleteButtonColor : UIColor = #colorLiteral(red: 0.9328305125, green: 0, blue: 0, alpha: 1)
    
    var body: some View {
        Button(action: {
            // Delete Hobby
            showingDeleteAlert = true
        }, label: {
            ZStack {
                RoundedRectangle(cornerRadius: 50)
                    .frame(width: 250, height: 50)
                    .foregroundColor(Color(deleteButtonColor))
                    .overlay(
                        RoundedRectangle(cornerRadius: 50)
                            .strokeBorder(.white, lineWidth: 4))
                
                Text("Delete Hobby")
                    .font(.custom("Avenir", size: 25))
                    .foregroundColor(Color.white)
            }
        })
        .padding(.top, -10)
        .alert(isPresented: $showingDeleteAlert) {
            Alert(title: Text("Are you sure you want to delete hobby? This will be permanent."),
                  primaryButton: .destructive(Text("Delete")) {
                hobbyVM.deleteHobby(hobby: hobby)
                presentationMode.wrappedValue.dismiss()
            },
                  secondaryButton: .cancel())
        }
    }
}

struct HobbyDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HobbyDetailView(hobby: Hobby())
    }
}
