import Foundation
import UIKit

class AppCoordinator : AppCoordinatorProtocol {
    
    func removeChild(index: Int) {
    }
    
    
    var navigationController: UINavigationController
    var childCoordinators = [AppCoordinatorProtocol]()
//    private var pageViewController = UIPageViewController()
    private var window: UIWindow!

    init(window: UIWindow, navigationController: UINavigationController) {
        self.window = window
        self.navigationController = navigationController
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        start()
    }
    
    func start() {
        let child = NewsListCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }
    
    
//    internal func setRootViewController() {
//        let dataSource = NewsAppNetworkDataSource()
//        let presenter = NewsListPresenter(newsDataSource: dataSource, coordinator: self)
//        let vc = NewsListTableViewController(presenter: presenter, coordinator: self)
//        self.navigationController = UINavigationController(rootViewController: vc)
//        let titleItem = UILabel()
//        titleItem.text = "Green view"
//        titleItem.backgroundColor = .black
//        navigationController.navigationItem.title = "blabla"
//        window?.rootViewController = navigationController
//        window?.makeKeyAndVisible()
//    }
    
//    func createPageViewController(data: [News], pageIndex: Int) {
//        let presenter = NewsPagePresenter(data: data, tappedCell: pageIndex)
//        let vc = NewsPageViewController(coordinator: self, presenter: presenter)
//        self.navigationController.pushViewController(vc, animated: true)
//    }
    
//    func createNewsViewController(data: News) -> NewsViewController {
//        let presenter = NewsViewPresenter(data: data)
//        let vc = NewsViewController(presenter: presenter)
//        return vc
//    }
}
