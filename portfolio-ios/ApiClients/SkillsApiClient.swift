//
//  SkillsApiClient.swift
//  portfolio-ios
//
//  Created by Wilton Costa on 10/02/19.
//  Copyright © 2019 Wilton Costa. All rights reserved.
//

import Foundation

class SkillsApiClient : ApiClient {
    
    func getSkillsByProfileId(_ id : Int, success:@escaping(_ skills:[Skill]) -> Void, fail:@escaping(_ error:Error) -> Void) {
            
        getData(resourceUrl: "/profiles/\(id)/skills") { (data, response, error) in
            if error == nil {
                if let jsonData = data {
                    do {
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .millisecondsSince1970
                        let skills = try decoder.decode([Skill].self, from: jsonData) as [Skill]
                        success(skills)
                    } catch {
                        fail(error)
                    }
                }
            } else {
                if let requestError = error {
                    fail(requestError)
                }
            }
        }
        
    }
}
