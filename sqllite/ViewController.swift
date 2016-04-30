//
//  ViewController.swift
//  sqllite
//
//  Created by Swift-301-SAB on 30/04/16.
//  Copyright © 2016 Swift-301-SAB. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var gerenciador = GerenciadorBanco()
    var aluno:Aluno?
    
    @IBOutlet weak var nomeLabel: UITextField!
    @IBOutlet weak var idadeLabel: UITextField!
    @IBOutlet weak var telefoneLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func inserirAluno(){
        let aluno = Aluno(sqlServer: gerenciador.SqlServer)
        //aluno.id = 1
        aluno.nome = "GLAUCO"
        aluno.idade = 55
        aluno.telefone = "2345678"
        aluno.salvar()
    }
    
    func resgatarAluno(id:Int) -> Aluno?
    {
        let aluno = Aluno(sqlServer: gerenciador.SqlServer)
        aluno.id = id
        
        
        guard aluno.resgatar() else {
            return nil
        }
        print("BUSQUEI ESSE MANO AQUI \(aluno.nome)")
        return aluno
    }
    
    func carregarAluno(){
        if let aluno = self.aluno{
            nomeLabel.text = String(aluno.nome)
            idadeLabel.text = String(aluno.idade)
            telefoneLabel.text = String(aluno.telefone)
        }
    }
    
    
    
    @IBAction func salvar(sender: UIButton) {
        
        if aluno == nil {
            aluno = Aluno(sqlServer: gerenciador.SqlServer)
        }
        
        aluno!.nome = nomeLabel.text
        aluno!.idade = Int(idadeLabel.text!)
        aluno!.telefone = telefoneLabel.text
        
        
        var mensagem = "Falha ao Salvar"
        if aluno!.salvar(){
           mensagem = "Salvo com sucesso"
        }
        
        let alert = UIAlertController(title: "Boa!!", message: mensagem, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: {
        [unowned self] botao in
            self.navigationController?.popViewControllerAnimated(true)
        }))
        
        presentViewController(alert, animated: true, completion: nil)
        
        
    }


}

