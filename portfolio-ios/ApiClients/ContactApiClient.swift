//
//  ContactApiClient.swift
//  portfolio-ios
//
//  Created by Wilton Costa on 16/02/19.
//  Copyright © 2019 Wilton Costa. All rights reserved.
//

import Foundation

class ContactApiClient {
    
    let webApiUrl = Bundle.main.infoDictionary?["WEBAPI_URL"] as! String
    
    func sendMessage(message : Message, success:@escaping(_ statusCode : Int) -> Void, fail:@escaping(_ error : Error) -> Void) {
        if let url = URL(string: webApiUrl + "/messages") {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.timeoutInterval = 7000
            do {
                let encoder = JSONEncoder()
                encoder.dateEncodingStrategy = .millisecondsSince1970
                urlRequest.httpBody = try encoder.encode(message)
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
    
}
