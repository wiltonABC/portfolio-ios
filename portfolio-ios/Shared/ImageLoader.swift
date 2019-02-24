//
//  ImageLoader.swift
//  portfolio-ios
//
//  Created by Wilton Costa on 07/02/19.
//  Copyright © 2019 Wilton Costa. All rights reserved.
//

import Foundation

class Imageloader {
    
    static var imageCache = Dictionary<String,Data>()
    
    func getImageFromUrl(_ stringUrl : String, success : @escaping(_ imageData:Data) -> Void, fail : @escaping(_ error:Error) -> Void) {
        
        DispatchQueue.global(qos:.userInitiated).async {
                do {

                    if !Imageloader.imageCache.contains(where: { (item) -> Bool in
                        item.key == stringUrl
                    }) {
                        let url = URL(string: stringUrl)!
                        let data = try Data(contentsOf: url)
                        Imageloader.imageCache[stringUrl] = data
//                        print("Downloading image")
                        success(data)
                    } else {
//                        print("Loading image from cache")
                        success(Imageloader.imageCache[stringUrl]!)
                    }

                } catch {
                    fail(error)
                }

        }
            
    }
    
}
