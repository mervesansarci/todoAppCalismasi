//
//  GorevKayitViewModel.swift
//  todoAppCalismasi
//
//  Created by Merve Sansarcı on 20.05.2024.
//

import Foundation

class GorevKayitViewModel {
    var grepo = GorevRepository()
    
    func kaydet(gorev_adi:String){
        grepo.kaydet(gorev_adi: gorev_adi)
    }
}
