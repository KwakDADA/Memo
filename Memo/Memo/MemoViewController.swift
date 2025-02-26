//
//  MemoViewController.swift
//  Memo
//
//  Created by 곽다은 on 2/24/25.
//

import UIKit

final class MemoViewController: UIViewController {
    
    typealias DataSourceType = UITableViewDiffableDataSource<MemoSection, Memo>
    
    enum MemoSection: Hashable {
        case memo
    }
    
    private var memoList: MemoList = .init(list: [])
    private let memoStorage: MemoStorage = .init()
    private let memoListView: MemoListView = .init()
    private var dataSource: DataSourceType?
    
    override func loadView() {
        view = memoListView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureDataSource()
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
        memoListView.tableView.delegate = self
    }
    
    private func loadList() {
        guard let loadedList = memoStorage.load() else { return }
        memoList = loadedList
        updateSnapshot(addItems: memoList.list)
    }
    
    @objc func didTapAddButton() {
        let alert = createTextFieldAlert(
            title: AlertConstants.AddMemo.title,
            placeholder: AlertConstants.AddMemo.placeholder,
            confirmActionTitle: AlertConstants.AddMemo.addActionTitle
        ) { [weak self] content in
            guard let self = self else { return }
            let memo = Memo(content: content)
            self.memoList.add(memo)
            self.memoStorage.save(self.memoList)
            updateSnapshot(addItems: [memo])
        }
        
        present(alert, animated: true)
    }
}

// MARK: - TableViewDelegate
extension MemoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] action, view, handler in
            guard let self = self else { return }
            let deletedMemo = memoList.list[indexPath.row]
            memoList.delete(indexPath.row)
            memoStorage.save(memoList)
            updateSnapshot(deleteItem: deletedMemo)
        }
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = true
        
        return configuration
    }
}

// MARK: - DiffableDataSource
extension MemoViewController {
    private func configureDataSource() {
        dataSource = UITableViewDiffableDataSource(
            tableView: memoListView.tableView,
            cellProvider: { [weak self] tableView, indexPath, itemIdentifier in
                guard let self = self else { return UITableViewCell() }
                let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifiers.memoCell, for: indexPath)
                cell.textLabel?.text = memoList.list[indexPath.row].content
                return cell
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<MemoSection, Memo>()
        snapshot.appendSections([.memo])
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    private func updateSnapshot(addItems items: [Memo]) {
        guard let dataSource = dataSource else { return }
        var snapshot = dataSource.snapshot()
        snapshot.appendItems(items, toSection: .memo)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func updateSnapshot(deleteItem item: Memo) {
        guard let dataSource = dataSource else { return }
        var snapshot = dataSource.snapshot()
        snapshot.deleteItems([item])
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

