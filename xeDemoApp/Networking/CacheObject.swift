//
//  CacheObject.swift
//  xeDemoApp
//
//  Created by user256596 on 2/28/24.
//

import Foundation

final class CacheObject {
    let entry: CacheEntry
    init(entry: CacheEntry) { self.entry = entry }
}

enum CacheEntry {
    case inProgress(Task<LocationModel, Error>)
    case ready(LocationModel)
}
