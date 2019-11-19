import UIKit

class RateCell: UITableViewCell, TableViewCell {
    enum Constants {
        static let height: CGFloat = 24
        static let offset: CGFloat = 16
    }

    private lazy var fromAbbreviationLable = UILabel {
        $0.textAlignment = .left
        $0.textColor = .black
        $0.font = UIFont.sfProTextBold22
    }

    private lazy var fromCurrencyLabel = UILabel {
        $0.textAlignment = .left
        $0.textColor = .systemGray
        $0.font = UIFont.sfProTextRegular14
    }

    private lazy var rateValueLable = UILabel {
        $0.textAlignment = .right
        $0.textColor = .black
        $0.font = UIFont.sfProTextBold22
    }

    private lazy var toCurrencyLabel = UILabel {
        $0.textAlignment = .right
        $0.textColor = .systemGray
        $0.font = UIFont.sfProTextRegular14
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = UITableViewCell.SelectionStyle.none
        contentView.addSubview(fromAbbreviationLable)
        fromAbbreviationLable.makeAnchors {
            $0.leading.top.equalToSuperview(Constants.offset)
            $0.height.equalTo(Constants.height)
        }

        contentView.addSubview(fromCurrencyLabel)
        fromCurrencyLabel.makeAnchors {
            $0.leading.equalTo(fromAbbreviationLable, anchor: .leading)
            $0.top.equalTo(fromAbbreviationLable, anchor: .bottom)
            $0.height.equalTo(Constants.height)
            $0.bottom.equalToSuperview()
        }

        contentView.addSubview(rateValueLable)
        rateValueLable.makeAnchors {
            $0.trailing.equalToSuperview(-Constants.offset)
            $0.centerY.equalTo(fromAbbreviationLable, anchor: .centerY)
        }

        contentView.addSubview(toCurrencyLabel)
        toCurrencyLabel.makeAnchors {
            $0.trailing.equalTo(rateValueLable, anchor: .trailing)
            $0.centerY.equalTo(fromCurrencyLabel, anchor: .centerY)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        toCurrencyLabel.text = nil
        rateValueLable.text = nil
    }

    func configure(with item: TableViewItem) {
        guard let item = item as? RateItem else {
            assertionFailure("item isn't of RateItem type")
            return
        }

        fromAbbreviationLable.text = "1" + " " + item.fromCurrencyKey.keyName
        fromCurrencyLabel.text = item.fromCurrencyKey.currency
        toCurrencyLabel.text = item.toCurrencyKey.currency + " " + item.toCurrencyKey.keyName
        rateValueLable.text = item.rateValue

        let attributedString = NSMutableAttributedString(string: item.rateValue)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor,
                                      value: UIColor.systemGray,
                                      range: NSRange(location: item.rateValue.count - 2, length: 2))
        rateValueLable.attributedText = attributedString
    }
}
