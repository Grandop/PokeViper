import UIKit

open class  PVBaseViewController: UIViewController {

    public var expandedNavigationTitle = false

    public init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    public required init?(coder: NSCoder) { return nil }

    // MARK: Life Cycle

    open override func loadView() {
        setupNavigationView()
        super.loadView()
        view = UIView()
        
        view.backgroundColor = PVColor.white.uiColor
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = expandedNavigationTitle ? .always : .never
    }

    
    open override func viewDidLoad() {
        hidesBottomBarWhenPushed = true

        super.viewDidLoad()
    }
    
    public func setupLargeTitleAdjustLabel() {
        guard let navigationBar = navigationController?.navigationBar else {
            return
        }
        
        navigationItem.setValue(true, forKey: "__largeTitleTwoLineMode")
        
        // recursively find the label
        func findLabel(in view: UIView) -> UILabel? {
            if view.subviews.count > 0 {
                for subview in view.subviews {
                    if let label = findLabel(in: subview) {
                        return label
                    }
                }
            }
            return view as? UILabel
        }

        if let label = findLabel(in: navigationBar) {
            if label.text == self.title {
                label.numberOfLines = 0
            }
        }
    }

    private func setupNavigationView() {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

