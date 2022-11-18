//
//  UIRefreshControl.swift
//  Dogs
//
//  Created by Anthony Ezeh on 18/11/2022.
//

import UIKit

extension UIRefreshControl {

    func attach(_ target: Any?, action: Selector, scrollView: UIScrollView) {
        addTarget(target, action: action, for: .valueChanged)
        scrollView.addSubview(self)
    }

    func start() {
        beginRefreshing()
    }

    func stop() {
        endRefreshing()
    }

}
