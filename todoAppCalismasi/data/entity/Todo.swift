//
//  Todo.swift
//  todoAppCalismasi
//
//  Created by Merve Sansarcı on 20.05.2024.
//

import Foundation

class Todo {
    var gorev_id:Int?
    var gorev_adi:String?
    
    init(gorev_id: Int, gorev_adi: String) {
        self.gorev_id = gorev_id
        self.gorev_adi = gorev_adi
    }
}
