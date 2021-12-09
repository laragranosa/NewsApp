import Foundation
import UIKit

class NewsPageCoordinator: AppCoordinatorProtocol {
    
    var childCoordinators = [AppCoordinatorProtocol]()
    var navigationController: UINavigationController
    var parentCoordinator: AppCoordinatorProtocol?
    var index: Int?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start(data: [News], pageIndex: Int) {
        let vm = NewsPageViewModel(data: data, tappedCell: pageIndex)
        let vc = NewsPageViewController(viewModel: vm, coordinator: self)
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func start() {
    }
    
    func removeChild(index: Int) {
        childCoordinators.remove(at: index)
    }
}
