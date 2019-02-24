//
//  ProfileApiClient.swift
//  portfolio-ios
//
//  Created by Wilton Costa on 03/02/19.
//  Copyright © 2019 Wilton Costa. All rights reserved.
//

import Foundation



class ProfileApiClient {
    
    let webApiUrl = Bundle.main.infoDictionary?["WEBAPI_URL"] as! String
    
    func getProfileById(_ id : Int, success:@escaping(_ profile:Profile) -> Void, fail:@escaping(_ error:Error) -> Void) {
        if let url = URL(string: webApiUrl + "/profiles/\(id)") {
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
                            let profile = try decoder.decode(Profile.self, from: jsonData) as Profile
                            success(profile)
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
