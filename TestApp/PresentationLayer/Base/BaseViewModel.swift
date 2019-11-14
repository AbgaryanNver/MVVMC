import Foundation

/**
 Describing base ViewModel logic for MVVM implementation

 *Confirmed only by BaseViewModel!!! (like NSObjectProtocol)*
 */
protocol BaseViewModelProtocol {
    /// Current screen title
    var screenTitle: Observable<String> { get }
}

/**
 Base logic for all ViewModel's in application

 **Don't put flow depended logic here!!!**
 */
class BaseViewModel: BaseViewModelProtocol {
    /// **Screen title, default value is empty**
    private(set) var screenTitle = Observable<String>("")

    init(title: String = "") {
        screenTitle.value = title
    }
}
