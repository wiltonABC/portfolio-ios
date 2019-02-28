//
//  ApiClient.swift
//  portfolio-ios
//
//  Created by Wilton Costa on 27/02/19.
//  Copyright © 2019 Wilton Costa. All rights reserved.
//

import Foundation

class ApiClient {
    
    final let webApiUrl = Bundle.main.infoDictionary?["WEBAPI_URL"] as! String
    
    final func getData(resourceUrl : String, result:@escaping(_ data : Data?, _ response : URLResponse?, _ error : Error?) -> Void) {
        if let url = URL(string: webApiUrl + resourceUrl) {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "GET"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
            urlRequest.timeoutInterval = 7000
            
            let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                result(data, response, error)
            }
            task.resume()
            
        }
    }
    
    final func postData(resourceUrl : String, requestData : Data, result:@escaping(_ data : Data?, _ response : URLResponse?, _ error : Error?) -> Void) {
        if let url = URL(string: webApiUrl + resourceUrl) {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.timeoutInterval = 7000

            urlRequest.httpBody = requestData
            
            let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                result(data, response, error)
            }
            task.resume()
            
        }
    }
    
}
