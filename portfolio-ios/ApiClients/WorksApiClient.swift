//
//  WorksApiClient.swift
//  portfolio-ios
//
//  Created by Wilton Costa on 14/02/19.
//  Copyright © 2019 Wilton Costa. All rights reserved.
//

import Foundation

class WorksApiClient {
    
    let webApiUrl = Bundle.main.infoDictionary?["WEBAPI_URL"] as! String
    
    func getWorksByProfileId(_ id : Int, success:@escaping(_ skills:[WorkDone]) -> Void, fail:@escaping(_ error:Error) -> Void) {
        if let url = URL(string: webApiUrl + "/profiles/\(id)/work-done") {
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
                            let works = try decoder.decode([WorkDone].self, from: jsonData) as [WorkDone]
                            success(works)
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

