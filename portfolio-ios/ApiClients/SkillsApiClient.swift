//
//  SkillsApiClient.swift
//  portfolio-ios
//
//  Created by Wilton Costa on 10/02/19.
//  Copyright © 2019 Wilton Costa. All rights reserved.
//

import Foundation



class SkillsApiClient {
    
    let webApiUrl = Bundle.main.infoDictionary?["WEBAPI_URL"] as! String
    
    func getSkillsByProfileId(_ id : Int, success:@escaping(_ skills:[Skill]) -> Void, fail:@escaping(_ error:Error) -> Void) {
        if let url = URL(string: webApiUrl + "/profiles/\(id)/skills") {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "GET"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
            urlRequest.timeoutInterval = 7000
            
            let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
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
            task.resume()
            
        }
    }
}
