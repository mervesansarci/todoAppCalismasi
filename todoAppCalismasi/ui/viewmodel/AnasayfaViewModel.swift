//
//  AnasayfaViewModel.swift
//  todoAppCalismasi
//
//  Created by Merve Sansarcı on 20.05.2024.
//

import Foundation
import RxSwift

class AnasayfaViewModel {
    var grepo = GorevRepository()
    var gorevListesi = BehaviorSubject<[Todo]>(value: [Todo]())
    
    init(){
        veritabaniKopyala()
        gorevListesi = grepo.gorevListesi
    }
    
    func ara(aramaKelimesi:String){
        grepo.ara(aramaKelimesi: aramaKelimesi)
    }
    
    func sil(gorev_id:Int){
        grepo.sil(gorev_id: gorev_id)
        gorevleriYukle()
    }
    
    func gorevleriYukle(){
        grepo.gorevleriYukle()
    }
    
    func veritabaniKopyala(){
            let bundleYolu = Bundle.main.path(forResource: "gorev", ofType: ".db")
            let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let kopyalanacakYer = URL(fileURLWithPath: hedefYol).appendingPathComponent("gorev.db")
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: kopyalanacakYer.path){
                print("Veritabanı zaten var")
            }else{
                do{
                    try fileManager.copyItem(atPath: bundleYolu!, toPath: kopyalanacakYer.path)
                }catch{}
            }
        }
    
}
