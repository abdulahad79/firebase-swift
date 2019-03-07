//
//  Chatmodel.swift
//  demfirebase
//
//  Created by abdul ahad on 06/03/2019.
//  Copyright © 2019 abdul ahad. All rights reserved.
//

import Foundation

class Chatmodel {
    var id: String?
    var name: String?
    var text: String?
    
    init(id:String, name:String, text:String) {
        self.id = id
        self.name = name
        self.text = text
    }
    
}
