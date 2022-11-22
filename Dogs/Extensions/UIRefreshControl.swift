//
//  UIRefreshControl.swift
//  Dogs
//
//  Created by Anthony Ezeh on 18/11/2022.
//

import UIKit

extension UIRefreshControl {

    // add target and action for pull refresh
    func attach(_ target: Any?, action: Selector, scrollView: UIScrollView) {
        addTarget(target, action: action, for: .valueChanged)
        scrollView.addSubview(self)
    }

    // pull refresh has started
    func start() {
        beginRefreshing()
    }

    // pull refresh has ended
    func stop() {
        endRefreshing()
    }

}
