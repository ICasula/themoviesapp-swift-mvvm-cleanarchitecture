//
//  BaseViewController.swift
//  TheMoviesApp
//
//  Created by Ignasi Casulà on 06/01/2022.
//

import UIKit

public class BaseViewController : UIViewController {
    static func storyboardInstance() -> Self {
        let storyboard = UIStoryboard.init(name: String(describing: self), bundle: Bundle.main)
        let viewController: Self = storyboard.instantiateInitialViewController() as! Self
        
        return viewController
    }
}
