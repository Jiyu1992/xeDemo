//
//  NSCache+Subscript.swift
//  xeDemoApp
//
//  Created by user256596 on 2/28/24.
//

import Foundation

extension NSCache where KeyType == NSString, ObjectType == CacheObject {
    subscript(_ url: URL) -> CacheEntry? {
        get {
            let key = url.absoluteString as NSString
            let value = object(forKey: key)
            return value?.entry
        }
        set {
            let key = url.absoluteString as NSString
            if let entry = newValue {
                let value = CacheObject(entry: entry)
                setObject(value, forKey: key)
            } else {
                removeObject(forKey: key)
            }
        }
    }
}
