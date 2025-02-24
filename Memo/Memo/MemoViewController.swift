//
//  MemoViewController.swift
//  Memo
//
//  Created by 곽다은 on 2/24/25.
//

import UIKit

final class MemoViewController: UIViewController {
    
    var memoList: MemoList = .init(list: [Memo(content: "hello!")])
    
    private let memoListView: MemoListView = .init()
    
    override func loadView() {
        view = memoListView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNaviBar()
        setTableView()
    }
    
    private func setNaviBar() {
        title = "Memo List"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(didTapAddButton)
        )
    }
    
    private func setTableView() {
        memoListView.tableView.dataSource = self
        memoListView.tableView.delegate = self
    }
    
    @objc func didTapAddButton() {
        
    }
}

extension MemoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memoList.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemoCell", for: indexPath)
        cell.textLabel?.text = memoList.list[indexPath.row].content

        return cell
    }
}
