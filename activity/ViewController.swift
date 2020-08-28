//
//  ViewController.swift
//  activity
//
//  Created by COTEMIG on 19/08/20.
//  Copyright © 2020 Cotemig. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
        
        var listaDeTarefas: [String] = []
        let listaKey = "chaveLista"
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            tableview.dataSource = self
            
            if let lista: [String] = UserDefaults.standard.value(forKey: listaKey) as? [String]{
                listaDeTarefas.append(contentsOf:lista)
            }
        }
        
        
        @IBAction func addtask(_ sender: Any) {
            let alert = UIAlertController(title: "adicionar tarefa",
                                          message: "qual o nome da tarefa",
                                          preferredStyle: .alert)
            
            let acaosalvar = UIAlertAction(title: "salvar",style: .default) { (action) in
                if let textField = alert.textFields?.first, let textoDigitado = textField.text{
                    self.listaDeTarefas.append(textoDigitado)
                    self.tableview.reloadData()
                    
                    UserDefaults.standard.set(self.listaDeTarefas, forKey: self.listaKey)
                }
                
            }
            
            let acaocancelar = UIAlertAction(title:"Cancelar", style: .cancel)
            
            alert.addAction(acaosalvar)
            alert.addAction(acaocancelar)
            
            alert.addTextField()
            
            present(alert, animated: true)
        }
        
        
    }
    extension ViewController: UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return listaDeTarefas.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = listaDeTarefas[indexPath.row]
            return cell
        }
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            
            if editingStyle == .delete{
                listaDeTarefas.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath] , with: .fade)
                UserDefaults.standard.set(self.listaDeTarefas, forKey: self.listaKey)
            }
        }
}
