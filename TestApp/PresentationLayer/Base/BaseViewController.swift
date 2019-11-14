import UIKit

/**
 Describing base View logic for MVVM implementation

 *Confirmed only by BaseViewController!!! (like NSObjectProtocol)*
 */
protocol BaseViewControllerProtocol {
    /// Concrete ViewModel type
    associatedtype ViewModelType

    /// Reference to ViewModel in current flow
    var viewModel: ViewModelType { get set }

    /// View constructor
    ///
    /// - Parameters:
    /// - viewModel: ViewModel for View initialization
    init(with viewModel: ViewModelType)

    /// Implementation of all interface setup logic (subviews, constraints etc)
    func setupUI()

    /// Setup bindings beetwen View and ViewModel
    ///
    /// - Parameter viewModel: ViewModel for bind
    func bind(viewModel: ViewModelType)
}

/**
 Base logic for all ViewController's in application

 **Don't put flow depended logic here!!!**
 */
class BaseViewController<ViewModelType: BaseViewModelProtocol>: UIViewController, BaseViewControllerProtocol {
    var viewModel: ViewModelType

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    required init(with viewModel: ViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        bind(viewModel: viewModel)
    }

    func setupUI() {}

    func bind(viewModel _: ViewModelType) {
        viewModel.screenTitle.addObserver { [weak self] title in
            self?.title = title
        }
    }
}
