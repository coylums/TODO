//
//  Observable.swift
//  TODOApp
//
//  Created by Coy Woolard on 11/10/18.
//  Copyright © 2018 Coy Woolard. All rights reserved.
//

import Foundation

class Observable<T> {

    var valueChanged: (() -> Void) = { }

    var value: T {
        didSet {
            valueChanged()
        }
    }

    init(_ v: T) {
         value = v
    }
}
