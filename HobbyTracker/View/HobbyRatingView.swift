//
//  RatingView.swift
//  HobbyTracker
//
//  Created by Ricky Zheng on 1/27/23.
//

import SwiftUI

struct HobbyRatingView: View {
    @EnvironmentObject var hobbyVM : HobbyViewModel
    
    // Take in a hobby
    @Binding var hobby : Hobby
    
    // Preview purposes
    @State var starOneStatus    = false
    @State var starTwoStatus    = false
    @State var starThreeStatus  = false
    @State var starFourStatus   = false
    @State var starFiveStatus   = false
    
    var starColor : Color = Color.black
    
    var body: some View {
        HStack {
            // Use id to find right index instead of index itself
            if let userRating = hobby.rating {
                // userRating doesn't change because hobby.rating hasn't changed yet
                if userRating[0] == false {
                    Image(systemName: "star")
                        .resizable()
                        .foregroundColor(starColor)
                        .frame(width: 45, height: 45)
                        .onTapGesture {
                            starOneStatus       = true
                            starTwoStatus       = false
                            starThreeStatus     = false
                            starFourStatus      = false
                            starFiveStatus      = false
                            
                            hobby.rating = [true, false, false, false, false]
                        }
                }
                else {
                    Image(systemName: "star.fill")
                        .resizable()
                        .foregroundColor(starColor)
                        .foregroundColor(.white)
                        .frame(width: 45, height: 45)
                        .onTapGesture {
                            if ((userRating[1]      == false)
                                && (userRating[2]   == false)
                                && (userRating[3]   == false)
                                && (userRating[4]   == false)) {
                                starOneStatus       = false
                                
                                hobby.rating = [false, false, false, false, false]
                            }
                            else {
                                starOneStatus       = true
                                starTwoStatus       = false
                                starThreeStatus     = false
                                starFourStatus      = false
                                starFiveStatus      = false
                                
                                hobby.rating = [true, false, false, false, false]
                            }
                        }
                }
                
                if userRating[1] == false {
                    Image(systemName: "star")
                        .resizable()
                        .foregroundColor(starColor)
                        .frame(width: 45, height: 45)
                        .onTapGesture {
                            starOneStatus       = true
                            starTwoStatus       = true
                            starThreeStatus     = false
                            starFourStatus      = false
                            starFiveStatus      = false
                            
                            hobby.rating = [true, true, false, false, false]
                        }
                }
                else {
                    Image(systemName: "star.fill")
                        .resizable()
                        .foregroundColor(starColor)
                        .frame(width: 45, height: 45)
                        .onTapGesture {
                            starOneStatus       = true
                            starTwoStatus       = true
                            starThreeStatus     = false
                            starFourStatus      = false
                            starFiveStatus      = false
                            
                            hobby.rating = [true, true, false, false, false]
                        }
                }
                
                if userRating[2] == false {
                    Image(systemName: "star")
                        .resizable()
                        .foregroundColor(starColor)
                        .frame(width: 45, height: 45)
                        .onTapGesture {
                            starOneStatus       = true
                            starTwoStatus       = true
                            starThreeStatus     = true
                            starFourStatus      = false
                            starFiveStatus      = false
                            
                            hobby.rating = [true, true, true, false, false]
                        }
                }
                else {
                    Image(systemName: "star.fill")
                        .resizable()
                        .foregroundColor(starColor)
                        .frame(width: 45, height: 45)
                        .onTapGesture {
                            starOneStatus       = true
                            starTwoStatus       = true
                            starThreeStatus     = true
                            starFourStatus      = false
                            starFiveStatus      = false
                            
                            hobby.rating = [true, true, true, false, false]
                        }
                }
                
                if userRating[3] == false {
                    Image(systemName: "star")
                        .resizable()
                        .foregroundColor(starColor)
                        .frame(width: 45, height: 45)
                        .onTapGesture {
                            starOneStatus       = true
                            starTwoStatus       = true
                            starThreeStatus     = true
                            starFourStatus      = true
                            starFiveStatus      = false
                            
                            hobby.rating = [true, true, true, true, false]
                        }
                }
                else {
                    Image(systemName: "star.fill")
                        .resizable()
                        .foregroundColor(starColor)
                        .frame(width: 45, height: 45)
                        .onTapGesture {
                            starOneStatus       = true
                            starTwoStatus       = true
                            starThreeStatus     = true
                            starFourStatus      = true
                            starFiveStatus      = false
                            
                            hobby.rating = [true, true, true, true, false]
                        }
                }
                
                if userRating[4] == false {
                    Image(systemName: "star")
                        .resizable()
                        .foregroundColor(starColor)
                        .frame(width: 45, height: 45)
                        .onTapGesture {
                            starOneStatus       = true
                            starTwoStatus       = true
                            starThreeStatus     = true
                            starFourStatus      = true
                            starFiveStatus      = true
                            
                            hobby.rating = [true, true, true, true, true]
                        }
                }
                else {
                    Image(systemName: "star.fill")
                        .resizable()
                        .foregroundColor(starColor)
                        .frame(width: 45, height: 45)
                        .onTapGesture {
                            starOneStatus       = true
                            starTwoStatus       = true
                            starThreeStatus     = true
                            starFourStatus      = true
                            starFiveStatus      = true
                            
                            hobby.rating = [true, true, true, true, true]
                        }
                }
            }
        }
    }
}

//struct HobbyRatingView_Previews: PreviewProvider {
//    static var previewHobby = Hobby()
//
//    static var previews: some View {
//        HobbyRatingView(hobby: previewHobby)
//    }
//}
