//
//  Feedback.swift
//  portfolio-ios
//
//  Created by Wilton Costa on 18/02/19.
//  Copyright © 2019 Wilton Costa. All rights reserved.
//

import Foundation



class Feedback : Codable {
    let idFeedback : Int32
    let profile : Profile?
    let author : String
    let company : String
    let text : String
    let dateCreated : Date
    
    init(idFeedback : Int32, profile : Profile, author : String, company : String, text : String, dateCreated : Date) {
        
        self.idFeedback = idFeedback
        self.profile = profile
        self.author = author
        self.company = company
        self.text = text
        self.dateCreated = dateCreated
        
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: DecodingKeys.self)
        idFeedback = try values.decode(Int32.self, forKey: .idFeedback)
        author = try values.decode(String.self, forKey: .author)
        company = try values.decode(String.self, forKey: .company)
        text = try values.decode(String.self, forKey: .text)
        dateCreated = try values.decode(Date.self, forKey: .dateCreated)
        profile = nil
    }
    
    enum DecodingKeys : String, CodingKey {
        case idFeedback
        case author
        case company
        case text
        case dateCreated
    }
}
