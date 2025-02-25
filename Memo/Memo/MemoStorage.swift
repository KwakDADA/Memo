//
//  MemoStorage.swift
//  Memo
//
//  Created by 곽다은 on 2/25/25.
//

import Foundation

final class MemoStorage {
    func save(_ memoList: MemoList) {
        guard let encodedList = try? JSONEncoder().encode(memoList) else { return }
        UserDefaults.standard.set(encodedList, forKey: StorageConstants.memoListKey)
    }
    
    func load() -> MemoList? {
        guard let data = UserDefaults.standard.data(forKey: StorageConstants.memoListKey),
              let decodedList = try? JSONDecoder().decode(MemoList.self, from: data) else { return nil }
        return decodedList
    }
}
