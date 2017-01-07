//
//  MultiCastDelegate.swift
//  Adventure
//
//  Created by Eric on 2017/1/6.
//  Copyright © 2017年 Eric. All rights reserved.
//

import Foundation

class MultiCastDelegateNode {
    weak var element:AnyObject?
    init(agent: AnyObject) {
        element = agent
    }
}

func +=<T> (left: MultiCastDelegator<T>, right: T) {
    left.append(agent: right)
}

func -=<T> (left: MultiCastDelegator<T>, right: T) {
    left.remove(agent: right)
}

class MultiCastDelegator<T> {
    typealias delegateMethod = (T) -> ()
    var delegates = [MultiCastDelegateNode]()
    
    func invoke(closure: delegateMethod) {
        for index in (0..<delegates.count).reversed() {
            if let cell = delegates[index].element {
                closure(cell as! T)
            } else {
                //delegate has been freed, destroy node
                delegates.remove(at: index)
            }
        }
    }
    
    func append(agent: T) {
            delegates.append(MultiCastDelegateNode(agent: agent as AnyObject))
    }
    
    func remove(agent: T) {
        let agentObject = agent as AnyObject
        for index in (0..<delegates.count).reversed() {
            if let cell = delegates[index].element {
                if cell === agentObject {
                    delegates.remove(at: index)
                }
            }
        }
    }
}
