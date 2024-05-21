//
//  GorevDetay.swift
//  todoAppCalismasi
//
//  Created by Merve Sansarcı on 20.05.2024.
//

import UIKit

class GorevDetay: UIViewController {

    @IBOutlet weak var tfGorevDuzenle: UITextField!
    
    var gorev:Todo?
    
    var viewModel = GorevDetayViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let g = gorev{
            tfGorevDuzenle.text = g.gorev_adi
        }
    }

    @IBAction func buttonDuzenle(_ sender: Any) {
        if let g = gorev, let gorevadi = tfGorevDuzenle.text{
            viewModel.guncelle(gorev_id: g.gorev_id!, gorev_adi: gorevadi)
        }
    }
}
