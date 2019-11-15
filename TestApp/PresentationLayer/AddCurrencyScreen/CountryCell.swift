import UIKit

class CountryCell: UITableViewCell, TableViewCell {
    private lazy var countryFlagImageView = UIImageView {
        $0.layer.borderWidth = 1
        $0.layer.masksToBounds = false
        $0.layer.borderColor = UIColor.systemGray.cgColor
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
            $0.leading.top.equalToSuperview(16)
            $0.bottom.equalToSuperview(-16)
            $0.height.width.equalTo(24)
        }

        contentView.addSubview(abbreviationNameLabel)
        abbreviationNameLabel.makeAnchors {
            $0.leading.equalTo(countryFlagImageView, anchor: .trailing, 16)
            $0.centerY.equalTo(countryFlagImageView)
        }

        contentView.addSubview(moneyNameLabel)
        moneyNameLabel.makeAnchors {
            $0.leading.equalTo(abbreviationNameLabel, anchor: .trailing, 18)
            $0.centerY.equalTo(countryFlagImageView)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func configure(with item: TableViewItem) {
        guard let item = item as? CountryItem else {
            assertionFailure("item isn't of CountryItem type")
            return
        }
        countryFlagImageView.layer.cornerRadius = countryFlagImageView.frame.height / 2
        moneyNameLabel.text = item.country.currency
        abbreviationNameLabel.text = item.country.cur
        countryFlagImageView.image = UIImage(named: item.country.imageName)
    }
}
