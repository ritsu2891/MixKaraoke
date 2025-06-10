//
//  Item.swift
//  MixKaraoke
//
//  Created by 小久保 律樹 on 2025/06/10.
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
