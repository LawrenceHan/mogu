//
//  DispatchHelper.swift
//  mogu
//
//  Created by Hanguang on 31/12/2016.
//  Copyright © 2016 Hanguang. All rights reserved.
//

import Foundation

let queueLabel = "com.hanguang.app.tableview.queue"
let tableViewQueueSpecific = DispatchSpecificKey<String>()

final class DispatchHelper {
    
    static let sharedInstance = DispatchHelper()
    let tableViewQueue: DispatchQueue
    
    private init() {
        tableViewQueue = DispatchQueue(label: queueLabel)
        tableViewQueue.setSpecific(key: tableViewQueueSpecific, value: queueLabel)
    }
    
    func dispatchOnTableViewQueue(block: DispatchWorkItem, sync: Bool) {
        if DispatchQueue.getSpecific(key: tableViewQueueSpecific) != nil {
            autoreleasepool(invoking: {
                block.perform()
            })
        } else {
            if sync {
                tableViewQueue.sync(execute: block)
            } else {
                tableViewQueue.async(execute: block)
            }
        }
    }
}
