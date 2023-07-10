//
//  HobbyModel.swift
//  HobbyTracker
//
//  Created by Ricky Zheng on 1/24/23.ow
//

import Foundation

struct Hobby : Identifiable, Codable, Hashable {
    var id          : Int
    var name        : String
    var description : String?
    var feedback    : String?
    var rating      : [Bool]?   = [false, false, false, false, false]
    var category    : String?
    var imageSymbol : String?
    var isSelected  : Bool?     = nil
    
    init(id: Int                = 0,
         name: String           = "Hobby",
         description: String?   = "",
         feedback: String?      = "",
         rating: [Bool]?        = [false, false, false, false, false],
         category : String      = "Category",
         imageSymbol: String    = "photo")
    {
            self.id             = id
            self.name           = name
            self.description    = description
            self.feedback       = feedback
            self.rating         = rating
            self.category       = category
            self.imageSymbol    = imageSymbol
    }
    
    static var sampleHobby = Hobby(name:        "Basketball",
                                   description: "Type a Description Here",
                                   feedback:    "Sometimes I go play, most of the times I don't.",
                                   imageSymbol: "figure.basketball")
    
    static let defaultHobbyList: [Hobby] = Bundle.main.decode([Hobby].self, from: "hobbyList.json")
}

extension Bundle {
    func decode<T: Decodable>(_ type: T.Type,
                              from file: String,
                              dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
                              keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("[DECODE] Failed to find \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("[DECODE] Failed to find \(file) from bundle.")
        }

        let decoder = JSONDecoder()
        
        decoder.dateDecodingStrategy = dateDecodingStrategy
        decoder.keyDecodingStrategy = keyDecodingStrategy

        do {
            return try decoder.decode(T.self, from: data)
        } catch DecodingError.keyNotFound(let key, let context) {
            fatalError("[DECODE] Failed to decode \(file) from bundle due to missing key '\(key.stringValue)' not found – \(context.debugDescription)")
        } catch DecodingError.typeMismatch(_, let context) {
            fatalError("[DECODE] Failed to decode \(file) from bundle due to type mismatch – \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context) {
            fatalError("[DECODE] Failed to decode \(file) from bundle due to missing \(type) value – \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(_) {
            fatalError("[DECODE] Failed to decode \(file) from bundle because it appears to be invalid JSON")
        } catch {
            fatalError("[DECODE] Failed to decode \(file) from bundle: \(error.localizedDescription)")
        }
    }
}
