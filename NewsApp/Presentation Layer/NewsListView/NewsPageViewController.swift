import UIKit
import SnapKit

class NewsPageViewController: UIPageViewController {
    private var index: Int!
    private var displayedIndex = 0
    private var controllers: [UIViewController] = []
    private var viewModel: NewsPageViewModel!
    private var coordinator: NewsPageCoordinator!
    
    init(viewModel: NewsPageViewModel, coordinator: NewsPageCoordinator) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.viewModel = viewModel
        self.coordinator = coordinator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.newsData.forEach() {elem in
            let vm = NewsViewViewModel(data: elem as News)
            let newView = NewsViewController(viewModel: vm)
            controllers.append(newView)
        }
        
        view.backgroundColor = .white
        dataSource = self
        setViewControllers([controllers[viewModel.tappedCell]], direction: .forward, animated: false,completion: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        coordinator.parentCoordinator?.removeChild(index: coordinator.index ?? -1)
    }
    
}

extension NewsPageViewController: UIPageViewControllerDataSource {
    // Index trenutno aktivne stranice
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        displayedIndex
}
    // Broj stranica
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        controllers.count
}
    // Navigacija u nazad
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController
    ) -> UIViewController? {
        guard
            let vc = viewController as? NewsViewController,
            let controllerIndex = controllers.firstIndex(of: vc),
            controllerIndex - 1 >= 0,
            controllerIndex - 1 < controllers.count
        else {
            return nil
}
        displayedIndex = controllerIndex - 1
        return controllers[displayedIndex]
    }
    //Navigacija u naprijed
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController
    ) -> UIViewController? {
        guard
            let vc = viewController as? NewsViewController,
            let controllerIndex = controllers.firstIndex(of: vc),
            controllerIndex + 1 < controllers.count
        else {
            return nil
}
        displayedIndex = controllerIndex + 1
        return controllers[displayedIndex]
    }
}
