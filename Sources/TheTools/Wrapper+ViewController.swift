//
//  File.swift
//  
//
//  Created by Pavel Gnatyuk on 22/02/2020.
//

#if canImport(UIKit)

import UIKit

public struct Wrapper<ViewController: UIViewController> {
    let viewController: ViewController
    private(set) var image: UIImage? = nil
    private(set) var title: String? = nil

    public func add(image: UIImage?) -> Self {
        return Wrapper(viewController: viewController, image: image)
    }
    
    public func add(title: String?) -> Self {
        return Wrapper(viewController: viewController, image: image, title: title)
    }
    
    public func wrap() -> UINavigationController {
        let navController = UINavigationController(rootViewController: viewController)
        navController.navigationBar.prefersLargeTitles = true
        image.map {
            navController.tabBarItem.image = $0
        }
        title.map {
            navController.tabBarItem.title = $0
        }
        return navController
    }
}

#endif
