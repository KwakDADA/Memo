//
//  Memo.swift
//  Memo
//
//  Created by 곽다은 on 2/24/25.
//

import Foundation

struct Memo: Hashable, Codable {
    let id: UUID = .init()
    let content: String
}
