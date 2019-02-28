//
//  WorksApiClient.swift
//  portfolio-ios
//
//  Created by Wilton Costa on 14/02/19.
//  Copyright © 2019 Wilton Costa. All rights reserved.
//

import Foundation

class WorksApiClient : ApiClient {
    
    func getWorksByProfileId(_ id : Int, success:@escaping(_ skills:[WorkDone]) -> Void, fail:@escaping(_ error:Error) -> Void) {
        
        getData(resourceUrl: "/profiles/\(id)/work-done") { (data, response, error) in
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
    }
}

