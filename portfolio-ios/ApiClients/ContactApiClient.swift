//
//  ContactApiClient.swift
//  portfolio-ios
//
//  Created by Wilton Costa on 16/02/19.
//  Copyright © 2019 Wilton Costa. All rights reserved.
//

import Foundation

class ContactApiClient : ApiClient {
    
    func sendMessage(message : Message, success:@escaping(_ statusCode : Int) -> Void, fail:@escaping(_ error : Error) -> Void) {
        
        var entity : Data
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .millisecondsSince1970
            entity = try encoder.encode(message)
        } catch {
            fail(error)
            return
        }
        
        postData(resourceUrl : "/messages", requestData : entity) { (data, response, error) in
            let httpResponse = response as! HTTPURLResponse
            if error == nil {
                success(httpResponse.statusCode)
            } else {
                if let requestError = error {
                    fail(requestError)
                }
            }
        }

    }
    
}
