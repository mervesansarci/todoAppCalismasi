//
//  GorevRepository.swift
//  todoAppCalismasi
//
//  Created by Merve Sansarcı on 20.05.2024.
//

import Foundation
import RxSwift

class GorevRepository {
    var gorevListesi = BehaviorSubject<[Todo]>(value: [Todo]())
    
    let db: FMDatabase?
    
    init(){
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let veritabaniUrl = URL(fileURLWithPath: hedefYol).appendingPathComponent("gorev.db")
        db = FMDatabase(path: veritabaniUrl.path)
    }
    
    func kaydet(gorev_adi:String){
        db?.open()
        do{
            try db!.executeUpdate("INSERT INTO gorev (gorev_adi) VALUES (?)", values: [gorev_adi])
            
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
        
    }
    
    func guncelle(gorev_id:Int,gorev_adi:String){
        db?.open()
        do{
            try db!.executeUpdate("UPDATE gorev SET gorev_adi = ? WHERE gorev_id = ?", values: [gorev_adi,gorev_id])
            
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func ara(aramaKelimesi:String){
        db?.open()
        
        var liste = [Todo]()
        
        do{
            let rs = try db!.executeQuery("SELECT * FROM gorev WHERE gorev_adi like '%\(aramaKelimesi)%'", values: nil)
            
            while rs.next(){
                let gorev_id = Int(rs.string(forColumn: "gorev_id"))
                let gorev_adi = rs.string(forColumn: "gorev_adi")
                
                let gorev = Todo(gorev_id: gorev_id!, gorev_adi: gorev_adi!)
                liste.append(gorev)
            }
        
            gorevListesi.onNext(liste)            
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
    }
    
    func sil(gorev_id:Int){
        db?.open()
        do{
            try db!.executeUpdate("DELETE FROM gorev WHERE gorev_id = ?", values: [gorev_id])
            
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func gorevleriYukle(){
        db?.open()
        
        var liste = [Todo]()
        
        do{
            let rs = try db!.executeQuery("SELECT * FROM gorev", values: nil)
            
            while rs.next(){
                let gorev_id = Int(rs.string(forColumn: "gorev_id"))
                let gorev_adi = rs.string(forColumn: "gorev_adi")
                
                let gorev = Todo(gorev_id: gorev_id!, gorev_adi: gorev_adi!)
                liste.append(gorev)
            }
            
            gorevListesi.onNext(liste)
            
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
    }
}
