import Foundation
import UIKit

class NewsListCoordinator: AppCoordinatorProtocol {
    
    var childCoordinators = [AppCoordinatorProtocol]()
    var navigationController: UINavigationController
    var parentCoordinator: AppCoordinatorProtocol?
    var index: Int!

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let dataSource = NewsAppNetworkDataSource()
        let vm = NewsListViewModel(newsDataSource: dataSource, coordinator: self)
        let vc = NewsListTableViewController(viewModel: vm, coordinator: self)
        self.navigationController.pushViewController(vc, animated: false)
    }
    
    func openNewsPage(data: [News], pageIndex: Int){
        let child = NewsPageCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.index = childCoordinators.count - 1
        child.start(data: data, pageIndex: pageIndex)
    }
    
    func removeChild(index: Int) {
        childCoordinators.remove(at: index)
    }
    
//    func removeChild(child: AppCoordinatorProtocol){
//        childCoordinators.firstIndex { (storedCoordinator) -> Bool in
//            return child != storedCoordinator
//        }
//    }
}
