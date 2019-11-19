import UIKit

extension UIView {
    /**
     Create constraint from this view to the second view using anchors

     - Parameters:
        - anchorPath: this view anchor
        - to view: second view
        - viewAnchorPath: second view anchor
        - constant: new constraint constant
     */
    func anchor<Anchor, ViewAnchor, AnchorType>(_ anchorPath: KeyPath<UIView, Anchor>,
                                                to view: UIView,
                                                _ viewAnchorPath: KeyPath<UIView, ViewAnchor>,
                                                constant: CGFloat = 0,
                                                identifier: String) where Anchor: NSLayoutAnchor<AnchorType>, ViewAnchor: NSLayoutAnchor<AnchorType> {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = self[keyPath: anchorPath].constraint(equalTo: view[keyPath: viewAnchorPath], constant: constant)
        constraint.isActive = true
        constraint.identifier = identifier
    }

    /**
     In this block can describe view constraint setting using AnchorMaker abstractions

     - note: nextButton.makeAnchors { $0.leading.trailing.equalToSuperview(16) }
     */
    func makeAnchors(_ completion: AnchorMakerCompletion) {
        AnchorMaker.prepareAnchors(view: self, completion: completion)
    }
}
