//
//  SceneDelegate.swift
//  NewsApp
//
//  Created by Lara on 09/09/2021.
//  Copyright © 2021 Lara. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var navigationController: UINavigationController?
    private var appCoordinator: AppCoordinator!


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene)
        else { return }
        
        window = UIWindow(windowScene: windowScene)
        navigationController = UINavigationController()
        appCoordinator = AppCoordinator(window: window!, navigationController: navigationController!)
    }

}

