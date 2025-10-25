//
//  Item.swift
//  SplitKar
//
//  Created by Raj Raval on 25/10/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
