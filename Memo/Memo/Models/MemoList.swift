//
//  MemoList.swift
//  Memo
//
//  Created by 곽다은 on 2/24/25.
//

struct MemoList {
    var list: [Memo]
    
    mutating func add(_ memo: Memo) {
        list.append(memo)
    }
    
    mutating func delete(_ index: Int) {
        list.remove(at: index)
    }
}
