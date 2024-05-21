//
//  ViewController.swift
//  todoAppCalismasi
//
//  Created by Merve Sansarcı on 20.05.2024.
//

import UIKit

class Anasayfa: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    var gorevListesi = [Todo]()
    var viewModel = AnasayfaViewModel()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        gorevTableView.delegate = self
        gorevTableView.dataSource = self
        
        _=viewModel.gorevListesi.subscribe(onNext: { liste in
            self.gorevListesi = liste
            self.gorevTableView.reloadData()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.gorevleriYukle()
    }

    @IBOutlet weak var gorevTableView: UITableView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetay"{
            if let gorev = sender as? Todo {
                let gidilecekVC = segue.destination as! GorevDetay
                gidilecekVC.gorev = gorev
            }
        }
    }
}

extension Anasayfa:UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.ara(aramaKelimesi: searchText)
    }
}

extension Anasayfa: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gorevListesi.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let hucre = tableView.dequeueReusableCell(withIdentifier: "gorevHucre") as! GorevHucre
        
        let gorev = gorevListesi[indexPath.row]
        
        hucre.labelGorev.text = gorev.gorev_adi
        
        return hucre
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let gorev = gorevListesi[indexPath.row]
        performSegue(withIdentifier: "toDetay", sender: gorev)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let silAction = UIContextualAction(style: .destructive, title: "Sil"){contextualAction,view,bool in
            let gorev = self.gorevListesi[indexPath.row]
            
            let alert = UIAlertController(title: "silme işlemi", message: "\(gorev.gorev_adi!) silinsin mi?", preferredStyle: .alert)
            
            let iptalAction = UIAlertAction(title: "iptal", style: .cancel)
            alert.addAction(iptalAction)
            
            let evetAction = UIAlertAction(title: "evet", style: .destructive){_ in
                self.viewModel.sil(gorev_id: gorev.gorev_id!)
            }
            alert.addAction(evetAction)
            
            self.present(alert, animated: true)
        }
        
        return UISwipeActionsConfiguration(actions: [silAction])
    }
}

