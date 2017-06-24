//
//  RecentTweets.swift
//  Smashtag
//
//  Created by Kevin Green on 6/23/17.
//  Copyright © 2017 Stanford University. All rights reserved.
//

import Foundation

let key = "recentSearches"

class RecentTweets
{
    private let maxCount = 8
    var stack = UserDefaults.standard.stringArray(forKey: key) ?? [String]()
    
    var recentSearch: String? {
        didSet {
            stack.insert(recentSearch!, at: 0)
            stack = Array(stack.prefix(maxCount))
            stack = stack.unique()
            UserDefaults.standard.set(stack, forKey: key)
        }
     }
}

extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: [Iterator.Element: Bool] = [:]
        return self.filter { seen.updateValue(true, forKey: $0) == nil }
    }
}
