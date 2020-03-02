///
///  Wrapper+UIViewController.swift
///
///  Wrapp a view controller into a navigation controller.
///
///
///  Created by Pavel Gnatyuk on 22/02/2020.
///

/*
    Example:
```
let more = Wrapper(viewController: makeMoreViewController())
    .add(image: UIImage(systemName: "table.badge.more"))
    .add(title: NSLocalizedString("More", comment: "More tabbar item title"))
    .wrap()
```
*/

#if canImport(UIKit)

import UIKit


/// Wrap a view controller into a navigation controller
public struct Wrapper<ViewController: UIViewController> {
    let viewController: ViewController
    private(set) var image: UIImage? = nil
    private(set) var title: String? = nil
    
    public init(viewController: ViewController) {
        self.viewController = viewController
    }

    public init(viewController: ViewController, image: UIImage?) {
        self.viewController = viewController
        self.image = image
    }

    public init(viewController: ViewController, image: UIImage?, title: String?) {
        self.viewController = viewController
        self.image = image
        self.title = title
    }
    
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
