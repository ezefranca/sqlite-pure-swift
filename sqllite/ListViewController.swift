//
//  ListViewController.swift
//  sqllite
//
//  Created by Swift-301-SAB on 30/04/16.
//  Copyright © 2016 Swift-301-SAB. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var gerenciador = GerenciadorBanco()
    
    var listaAlunos : [Aluno] = []
    {
        didSet{
           tableView.reloadData()
        }
            
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.resgastarTodosAlunos()
    }
    
    func resgastarTodosAlunos(){
        let aluno = Aluno(sqlServer: gerenciador.SqlServer)
        listaAlunos = aluno.resgatarTodos()
    }
    
}

extension ListViewController : UITableViewDataSource{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listaAlunos.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "cellAluno")
        cell.textLabel?.text = listaAlunos[indexPath.row].nome
        cell.detailTextLabel?.text = listaAlunos[indexPath.row].telefone
        return cell
    }
    
}

extension ListViewController : UITableViewDelegate{
    
}
