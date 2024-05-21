//
//  GorevKayit.swift
//  todoAppCalismasi
//
//  Created by Merve Sansarcı on 20.05.2024.
//

import UIKit

class GorevKayit: UIViewController {
    @IBOutlet weak var tfGorevEkle: UITextField!
    
    var viewModel = GorevKayitViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func buttonEkle(_ sender: Any) {
        if let gorev = tfGorevEkle.text{
            viewModel.kaydet(gorev_adi: gorev)
        }
    }
}
