//
//  HobbyViewModel.swift
//  HobbyTracker
//
//  Created by Ricky Zheng on 1/24/23.
//

import Foundation
import Firebase

class HobbyViewModel: Identifiable, ObservableObject {
    // List of Hobbies to be modified
    
    @Published var hobbyList = [Hobby]()
    @Published var userList = [Hobby]()
    @Published var searchText = ""
    
    var filteredHobby: [Hobby] {
        return searchText == "" ? hobbyList : hobbyList.filter {
            $0.name.contains(searchText)
        }
    }
    
    var filteredUserHobby: [Hobby] {
        return searchText == "" ? userList : userList.filter {
            $0.name.contains(searchText)
        }
    }
    
    init() {
        self.hobbyList = Hobby.defaultHobbyList
        for index in 0..<hobbyList.count {
            hobbyList[index].rating = [false, false, false, false, false]
        }
        
        // Fetch Existing User Data from Firebase
        let db = Firestore.firestore()

        db.collection("UserHobbyList").addSnapshotListener { (snap, err) in
            if err != nil {
                print("Error")
                return
            }
            
            for collection in snap!.documentChanges {
                var userCategory : String = ""
                var userDescription : String = ""
                var userFeedback : String = ""
                var userID : Int = 0
                var userName : String = ""
                var userImageSymbol : String = ""
                var userRating : [Bool] = []

                if let dbCategory = collection.document.get("category") as? String {
                    userCategory = dbCategory
                }
                if let dbDescription = collection.document.get("description") as? String {
                    userDescription = dbDescription
                }
                if let dbFeedback = collection.document.get("feedback") as? String {
                    userFeedback = dbFeedback
                }
                if let dbID = collection.document.get("id") as? Int {
                    userID = dbID
                }
                if let dbImageSymbol = collection.document.get("imageSymbol") as? String {
                    userImageSymbol = dbImageSymbol
                }
                if let dbName = collection.document.get("name") as? String {
                    userName = dbName
                }
                if let dbRating = collection.document.get("rating") as? [Bool] {
                    userRating = dbRating
                }
                
                DispatchQueue.main.async {
                    // Possible issue is here, we don't always want to append whenever db changes.
                    // Check if id already exists
                    // Not in list, append to userList
                    if self.searchHobbyID(id: userID) == nil { // Could not find hobby in db, appending...
                        self.userList.append(Hobby(id           : userID,
                                                   name         : userName,
                                                   description  : userDescription,
                                                   feedback     : userFeedback,
                                                   rating       : userRating,
                                                   category     : userCategory,
                                                   imageSymbol  : userImageSymbol))
                        print("[init] id: \(userID)")
                        print("[init] name: \(userName)")
                        print("[init] description: \(userDescription)")
                        print("[init] feedback: \(userFeedback)")
                        print("[init] category: \(userCategory)")
                        print("[init] imageSymbol: \(userImageSymbol)")
                        print("[init] Size of User List is: \(self.userList.count)")
                    }
                    else if snap!.documents.count < self.userList.count { // A hobby was removed on the back end
                        print("snap!.documents.count of \(snap!.documents.count) < userList.count of \(self.userList.count)")
                        if let index = self.searchHobbyID(id: userID) {
                            self.userList.remove(at: index)
                        }
                    }
                    else if snap!.documents.count == self.userList.count { // An update was detected was called
                        if let index = self.searchHobbyID(id: userID) {
                            self.saveInformation(index: index, rating: userRating, description: userDescription, feedback: userFeedback)
                        }
                    }
                }
            }
        }
    }
    
    func addHobby(hobby : Hobby) {
        print("[addHobby] Adding new hobby... ")
        
        let db = Firestore.firestore()
        db.collection("UserHobbyList").document("\(hobby.name)").setData(["id"              : hobby.id,
                                                                          "name"            : hobby.name,
                                                                          "description"     : hobby.description ?? "",
                                                                          "feedback"        : hobby.feedback ?? "",
                                                                          "rating"          : hobby.rating ?? [false,
                                                                                                               false,
                                                                                                               false,
                                                                                                               false,
                                                                                                               false],
                                                                          "category"        : hobby.category ?? "",
                                                                          "imageSymbol"     : hobby.imageSymbol ?? ""]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            }
            else {
                print("Document successfully updated")
            }
        }
    }
    
    func saveInformation(index : Int, rating : [Bool]?, description : String, feedback : String) {
        // Every time hobby saved, a new entry is created in userList
        let db = Firestore.firestore()
        
        let hobbyRef = db.collection("UserHobbyList").document("\(self.userList[index].name)")
        if let ratingArray = rating {
            hobbyRef.updateData(["description" : description, "feedback" : feedback, "rating" : ratingArray]) { err in
                if let err = err {
                    print("Error updating document: \(err) 1")
                }
                else {
                    print("Document successfully updated 1")
                }
            }
        }
        else {
            hobbyRef.updateData(["description" : description, "feedback" : feedback]) { err in
                if let err = err {
                    print("Error updating document: \(err) 2")
                }
                else {
                    print("Document successfully updated 2")
                }
            }
        }
        
        print("[SaveInformationSize] of User List is: \(self.userList.count)")
        
        // Fetch recently updated userList
        hobbyRef.getDocument { (document, err) in
            guard err == nil else {
                print("error", err ?? "")
                return
            }
            if let document = document, document.exists {
                let data = document.data()
                if let data = data {
                    print("data", data)
                    self.userList[index].description = data["description"] as? String ?? ""
                    self.userList[index].feedback = data["feedback"] as? String ?? ""
                    self.userList[index].rating = data["rating"] as? [Bool] ?? []
                }
            }
        }
    }
    
    func deleteHobby(hobby : Hobby) {
        let db = Firestore.firestore()
        db.collection("UserHobbyList").document("\(hobby.name)").delete() { err in
            if let err = err {
                print("Error updating document: \(err)")
            }
            else {
                print("Document successfully updated")
            }
        }
    }
    
    // GET FUNCTIONS
    func getDefaultHobbyList() -> [Hobby] {
        let defaultHobbyList = Hobby.defaultHobbyList
        
        return defaultHobbyList
    }
    
    func searchHobbyID(id : Int) -> Int? {
        return userList.firstIndex { $0.id == id }
    }
}
