//
//  FeedbacksApiClient.swift
//  portfolio-ios
//
//  Created by Wilton Costa on 18/02/19.
//  Copyright © 2019 Wilton Costa. All rights reserved.
//

import Foundation

class FeedbacksApiClient : ApiClient {
    
    func sendFeedback(feedback : Feedback, success:@escaping(_ statusCode : Int) -> Void, fail:@escaping(_ error : Error) -> Void) {
        
        var entity : Data
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .millisecondsSince1970
            entity = try encoder.encode(feedback)
        } catch {
            fail(error)
            return
        }
        
        postData(resourceUrl : "/feedbacks", requestData : entity) { (data, response, error) in
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
    
    func getFeedbacksByProfileId(_ id : Int, success:@escaping(_ feedbacks:[Feedback]) -> Void, fail:@escaping(_ error:Error) -> Void) {
            
        getData(resourceUrl : "/profiles/\(id)/feedbacks") { (data, response, error) in
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
        
    }
}
