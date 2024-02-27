//
//  BarItemViewType.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 27/02/2024.
//

import Foundation

protocol BarItemsViewType: class {
    
    var leftBarItem: BarItem? { set get }
    
    var leftBarItems:[BarItem] { set get }
    
    var rightBarItem: BarItem? { set get }
    
    var rightBarItems:[BarItem] { set get }
    
    func updateRightBarButtons()
    
    func updateLeftBarButtons()
}
