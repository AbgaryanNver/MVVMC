import UIKit

class CountryCell: UITableViewCell, TableViewCell {
    enum Constants {
        static let imageViewHeight: CGFloat = 24
        static let offset: CGFloat = 16
    }

    private lazy var countryFlagImageView = UIImageView {
        $0.layer.borderWidth = 1
        $0.layer.masksToBounds = false
        $0.layer.borderColor = UIColor.systemGray.cgColor
        $0.layer.cornerRadius = Constants.imageViewHeight / 2
        $0.clipsToBounds = true
    }

    private lazy var moneyNameLabel = UILabel {
        $0.textAlignment = .center
        $0.textColor = .black
        $0.font = UIFont.sfProTextRegular16
    }

    private lazy var abbreviationNameLabel = UILabel {
        $0.textAlignment = .center
        $0.textColor = .systemGray
        $0.font = UIFont.sfProTextBold16
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = UITableViewCell.SelectionStyle.none
        contentView.addSubview(countryFlagImageView)
        countryFlagImageView.makeAnchors {
            $0.leading.top.equalToSuperview(Constants.offset)
            $0.bottom.equalToSuperview(-Constants.offset)
            $0.height.width.equalTo(Constants.imageViewHeight)
        }

        contentView.addSubview(abbreviationNameLabel)
        abbreviationNameLabel.makeAnchors {
            $0.leading.equalTo(countryFlagImageView, anchor: .trailing, Constants.offset)
            $0.centerY.equalTo(countryFlagImageView)
        }

        contentView.addSubview(moneyNameLabel)
        moneyNameLabel.makeAnchors {
            $0.leading.equalTo(abbreviationNameLabel, anchor: .trailing, Constants.offset)
            $0.centerY.equalTo(countryFlagImageView)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        moneyNameLabel.textColor = .black
        abbreviationNameLabel.textColor = .systemGray
    }

    func configure(with item: TableViewItem) {
        guard let item = item as? CountryItem else {
            assertionFailure("item isn't of CountryItem type")
            return
        }

        moneyNameLabel.textColor = .black
        abbreviationNameLabel.textColor = .systemGray
        if item.isMainItem {
            setTextColor(.blue)
        } else if item.isSelected {
            setTextColor(.gray)
        }

        moneyNameLabel.text = item.key.currency
        abbreviationNameLabel.text = item.key.keyName
        countryFlagImageView.image = UIImage(named: item.key.imageName)
    }

    private func setTextColor(_ color: UIColor) {
        moneyNameLabel.textColor = color
        abbreviationNameLabel.textColor = color
    }
}
