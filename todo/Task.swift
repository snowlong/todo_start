//
//  Task.swift
//  todo
//
//  Created by 駿河優輝長 on 2019/09/21.
//  Copyright © 2019 Jun Takahashi. All rights reserved.
//

import Foundation
import UIKit

class Task: Codable {
    var title: String
    var memo: String?
    
    init(title: String) {
        self.title = title
    }
//    init(title: String, memo: String?) {
//        self.title = title
//        self.memo = memo
//    }
}
