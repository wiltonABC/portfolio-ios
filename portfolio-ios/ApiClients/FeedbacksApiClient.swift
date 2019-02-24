//
//  FeedbacksApiClient.swift
//  portfolio-ios
//
//  Created by Wilton Costa on 18/02/19.
//  Copyright © 2019 Wilton Costa. All rights reserved.
//

import Foundation

class FeedbacksApiClient {
    
    let webApiUrl = Bundle.main.infoDictionary?["WEBAPI_URL"] as! String
    
    func sendFeedback(feedback : Feedback, success:@escaping(_ statusCode : Int) -> Void, fail:@escaping(_ error : Error) -> Void) {
        if let url = URL(string: webApiUrl + "/feedbacks") {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.timeoutInterval = 7000
            do {
                let encoder = JSONEncoder()
                encoder.dateEncodingStrategy = .millisecondsSince1970
                urlRequest.httpBody = try encoder.encode(feedback)
            } catch {
                fail(error)
                return
            }
            
            let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                let httpResponse = response as! HTTPURLResponse
                if error == nil {
                    success(httpResponse.statusCode)
                } else {
                    if let requestError = error {
                        fail(requestError)
                    }
                }
            }
            task.resume()
            
        }
    }
    
    func getFeedbacksByProfileId(_ id : Int, success:@escaping(_ feedbacks:[Feedback]) -> Void, fail:@escaping(_ error:Error) -> Void) {
        if let url = URL(string: webApiUrl + "/profiles/\(id)/feedbacks") {
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
                            let feedbacks = try decoder.decode([Feedback].self, from: jsonData) as [Feedback]
                            success(feedbacks)
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
