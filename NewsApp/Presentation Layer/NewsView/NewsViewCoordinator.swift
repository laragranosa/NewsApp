import Foundation
import UIKit

class NewsViewCoordinator{
//    var childCoordinators = [AppCoordinatorProtocol]()
    var navigationController: UINavigationController
    weak var parentCoordinator: AppCoordinator?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start(data: News) -> NewsViewController { //(data: News) -> NewsViewController
        let viewModel = NewsViewViewModel(data: data)
        let vc = NewsViewController(viewModel: viewModel)
        return vc
    }

}
