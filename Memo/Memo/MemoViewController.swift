//
//  MemoViewController.swift
//  Memo
//
//  Created by 곽다은 on 2/24/25.
//

import UIKit

final class MemoViewController: UIViewController {
    
    private var memoList: MemoList = .init(list: [])
    private let memoStorage: MemoStorage = .init()
    private let memoListView: MemoListView = .init()
    
    override func loadView() {
        view = memoListView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadList()
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
    
    private func loadList() {
        guard let loadedList = memoStorage.load() else { return }
        memoList = loadedList
    }
    
    @objc func didTapAddButton() {
        let alert = createTextFieldAlert(
            title: AlertConstants.AddMemo.title,
            placeholder: AlertConstants.AddMemo.placeholder,
            confirmActionTitle: AlertConstants.AddMemo.addActionTitle
        ) { [weak self] content in
            guard let self = self else { return }
            self.memoList.add(Memo(content: content))
            self.memoStorage.save(self.memoList)
            self.memoListView.tableView.reloadData()
        }
        
        present(alert, animated: true)
    }
}

extension MemoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        if editingStyle == .delete {
            memoList.delete(indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            self.memoStorage.save(self.memoList)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memoList.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: ReuseIdentifiers.memoCell,
            for: indexPath
        )
        cell.textLabel?.text = memoList.list[indexPath.row].content

        return cell
    }
}
