//
//  GorevDetayViewModel.swift
//  todoAppCalismasi
//
//  Created by Merve Sansarcı on 20.05.2024.
//

import Foundation

class GorevDetayViewModel{
    var grepo = GorevRepository()
    
    func guncelle(gorev_id:Int,gorev_adi:String){
        grepo.guncelle(gorev_id: gorev_id, gorev_adi: gorev_adi)
    }
}
