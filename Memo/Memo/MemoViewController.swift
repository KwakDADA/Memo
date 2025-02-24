//
//  MemoViewController.swift
//  Memo
//
//  Created by 곽다은 on 2/24/25.
//

import UIKit

final class MemoViewController: UIViewController {
    
    private var memoList: MemoList = .init(list: [])
    
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
        let alert = UIAlertController(
            title: AlertConstants.AddMemo.addActionTitle,
            message: nil,
            preferredStyle: .alert
        )
        alert.addTextField { $0.placeholder = AlertConstants.AddMemo.placeholder }
        
        let addAction = UIAlertAction(
            title: AlertConstants.AddMemo.addActionTitle,
            style: .default
        ) { _ in
            guard let content = alert.textFields?.first?.text, !content.isEmpty else { return }
            self.memoList.add(Memo(content: content))
            self.memoListView.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(
            title: AlertConstants.AddMemo.cancelActionTitle,
            style: .cancel
        )
        
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
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
