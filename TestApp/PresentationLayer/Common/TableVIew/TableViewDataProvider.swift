import UIKit

final class TableViewDataProvider: NSObject, UITableViewDataSource, UITableViewDelegate {
    var canRemoveRow = true
    private weak var tableView: UITableView?
    private var onTapCell: ((IndexPath) -> Void)?

    var dataSource: [TableViewItem] = [] {
        didSet {
            if oldValue.count == dataSource.count {
                guard let indexPaths = tableView?.indexPathsForVisibleRows else {
                    return
                }
                indexPaths.forEach { indexPath in
                    guard let visibleCell = tableView?.cellForRow(at: indexPath) as? TableViewCell else {
                        return
                    }
                    let item = dataSource[indexPath.row]
                    DispatchQueue.main.async {
                        visibleCell.configure(with: item)
                    }
                }
            } else {
                tableView?.register(with: dataSource)
                DispatchQueue.main.async {
                    self.tableView?.reloadData()
                }
            }
        }
    }

    func configure(tableView: UITableView, onTapCell: ((IndexPath) -> Void)? = nil) {
        self.tableView = tableView

        tableView.separatorStyle = .none
        tableView.alwaysBounceVertical = false
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        tableView.delegate = self
        self.onTapCell = onTapCell
    }

    // MARK: - UITableViewDataSource

    func numberOfSections(in _: UITableView) -> Int {
        1
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = dataSource[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(item.cellClassIdentifier)", for: indexPath)

        if let cell = cell as? TableViewCell {
            cell.configure(with: item)
        } else {
            assertionFailure("\(type(of: cell)) should conform to TableViewCell protocol")
        }

        return cell
    }

    func tableView(_: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if let _ = dataSource[indexPath.row] as? CountryItem {
            return .none
        }
        return .delete
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            dataSource.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let onTapCell = onTapCell {
            onTapCell(indexPath)
        }
    }
}
