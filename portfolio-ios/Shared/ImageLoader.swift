//
//  ImageLoader.swift
//  portfolio-ios
//
//  Created by Wilton Costa on 07/02/19.
//  Copyright © 2019 Wilton Costa. All rights reserved.
//

import Foundation

class Imageloader {
    
    static var imageCache : Dictionary<String,Data>?
    
    init() {
        if Imageloader.imageCache == nil {
            Imageloader.imageCache = Dictionary<String,Data>()
        }
    }
    
    func getImageFromUrl(_ stringUrl : String, success : @escaping(_ imageData:Data) -> Void, fail : @escaping(_ error:Error) -> Void) {
        
        DispatchQueue.global(qos:.userInitiated).async {
                do {
                    if var cache = Imageloader.imageCache {
                        if !cache.contains(where: { (item) -> Bool in
                            item.key == stringUrl
                        }) {
                            let url = URL(string: stringUrl)!
                            let data = try Data(contentsOf: url)
                            cache[stringUrl] = data
                            success(data)
                        } else {
                            success(cache[stringUrl]!)
                        }
                    }
                } catch {
                    fail(error)
                }

        }
            
    }
    
}
