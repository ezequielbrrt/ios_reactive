//
//  Task.swift
//  HelloRxSwift
//
//  Created by Ezequiel Barreto on 10/06/21.
//  Copyright © 2021 Ezequiel Barreto. All rights reserved.
//

import Foundation

enum Priority: Int {
    case high
    case medium
    case low
}

struct Task {
    let title: String
    let priority: Priority
}
