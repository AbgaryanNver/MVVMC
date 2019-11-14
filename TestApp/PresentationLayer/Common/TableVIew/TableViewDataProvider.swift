import UIKit

final class TableViewDataProvider: NSObject, UITableViewDataSource, UITableViewDelegate {
    private weak var tableView: UITableView?
    private var onTapCell: ((IndexPath) -> Void)?

    var dataSource: [TableViewItem] = [] {
        didSet {
            tableView?.register(with: dataSource)
            DispatchQueue.main.async {
                self.tableView?.reloadData()
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

    func updateCell(indexPath: IndexPath) {
        let cell = tableView?.cellForRow(at: indexPath)
        if let cell = cell as? TableViewCell {
            let item = dataSource[indexPath.row]
            cell.configure(with: item)
        } else {
            print("\(type(of: cell)) should conform to TableViewCell protocol")
        }
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

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let onTapCell = onTapCell {
            onTapCell(indexPath)
        }
    }
}
