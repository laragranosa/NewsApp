import Foundation
import UIKit

protocol AppCoordinatorProtocol {
//    associatedtype ChildCoordinator: AppCoordinatorProtocol
    var childCoordinators: [AppCoordinatorProtocol] { get set }
    var navigationController: UINavigationController { get set }
    func start()
    func removeChild(index: Int)
//    func createPageViewController(data: [News], pageIndex: Int)
//    func createNewsViewController(data: News) -> NewsViewController
}

//extension AppCoordinatorProtocol {
//    func removeChild(child: AppCoordinatorProtocol){
//        let nekavar = childCoordinators[0]
//        nekavar == child
//        childCoordinators.firstIndex { (storedCoordinator) -> Bool in
//            return child != nekavar
//        }
//    }
//}
