import UIKit

class CountryCell: UITableViewCell, TableViewCell {
    private lazy var countryFlagImageView = UIImageView {
        $0.layer.cornerRadius = frame.height / 2.0
        $0.clipsToBounds = true
    }

    private lazy var countryNameLabel = UILabel {
        $0.textAlignment = .center
        $0.textColor = .black
        $0.text = L10n.enterPhoneNumberKey
        $0.font = UIFont.sfProTextRegular16
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = UITableViewCell.SelectionStyle.none
        contentView.addSubview(countryFlagImageView)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func configure(with item: CountryItem) {
        guard let item = item as? CountryItem else {
            assertionFailure("item isn't of CountryItem type")
            return
        }

        countryNameLabel.text = item.country.name
        countryFlagImageView.image = UIImage(name: item.country.image)
    }
}
