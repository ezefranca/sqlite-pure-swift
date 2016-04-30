//
//  Aluno.swift
//  sqllite
//
//  Created by Swift-301-SAB on 30/04/16.
//  Copyright © 2016 Swift-301-SAB. All rights reserved.
//

import Foundation

class Aluno : Modelo {
    
    var id : Int?
    var nome: String?
    var idade: Int?
    var telefone : String?
    
    
    override init(sqlServer: SQLServer){
        super.init(sqlServer: sqlServer)
    }
    
}


extension Aluno : EntidadeProtocol
{
    func salvar() -> Bool
    {
        let nome = (self.nome ?? "NULL")!
        let telefone = (self.telefone ?? "NULL")!
        let idade = (self.idade != nil ? String(self.idade!) : "NULL" )
        
        var sql = "INSERT INTO alunos(nome, idade, telefone) VALUES ('\(nome)', '\(idade)', '\(telefone)')"
        
        if let id = self.id {
            sql = "UPDATE alunos SET nome='\(nome)', idade=\(idade), telefone='\(telefone)' WHERE id=\(id)"
        }
        
        
        return sqlServer.executar(sql)
        
    }
    
    func remover() -> Bool
    {
        guard let id = self.id else {
            NSLog("NENHUM ID FOI ATRIBUIDO PARA REMOVER")
            return false
        }
        let sql = "DELETE FROM alunos WHERE id=\(id)"
        return sqlServer.executar(sql)
    }
    
    func resgatar() -> Bool
    {
        guard let id = self.id else {
            return false
        }
        let sql = "SELECT id, nome, idade, telefone FROM alunos WHERE id=\(id)"
        
        let resultado = sqlServer.resgatar(sql)
        
        if let aluno = resultado?.first {
            self.id = aluno["id"] as? Int
            self.nome = aluno["nome"] as? String
            self.idade = aluno["idade"] as? Int
            self.telefone = aluno["telefone"] as? String
        }
        
        return true
    }
    
    
    func resgatarTodos() -> [Aluno]
    {

        let sql = "SELECT id, nome, idade, telefone FROM alunos"
        
        let resultado = sqlServer.resgatar(sql)
        var retorno : [Aluno] = []
        
        for aluno in resultado! {
            let novoAluno = Aluno(sqlServer: sqlServer)
            novoAluno.id = aluno["id"] as? Int
            novoAluno.nome = aluno["nome"] as? String
            novoAluno.idade = aluno["idade"] as? Int
            novoAluno.telefone = aluno["telefone"] as? String
            retorno.append(novoAluno)
            
        }
        
        return retorno
    }
    
    static var schema : String
    {
        return "CREATE TABLE alunos(id INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT, idade INTEGER, telefone TEXT)"
    }
}