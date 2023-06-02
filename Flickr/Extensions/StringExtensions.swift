//
//  StringExtensions.swift
//  Flickr
//
//  Created by Артур Кулик on 02.06.2023.
//

import Foundation

extension String {
    func removeTo(symbol: String) -> String {
        var str = self
        if let colonRange = str.range(of: symbol) {
            str.removeSubrange(str.startIndex..<colonRange.upperBound)
        }
        return str
    }
}
