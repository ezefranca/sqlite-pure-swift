//
//  GerenciadorBanco.swift
//  sqllite
//
//  Created by Swift-301-SAB on 30/04/16.
//  Copyright © 2016 Swift-301-SAB. All rights reserved.
//

import Foundation


class GerenciadorBanco {
    
    private var sqlServer = SQLServer()
    
    var SqlServer : SQLServer {
        return self.sqlServer
    }
    
    init()
    {
        self.criarBanco()
    }
    
    func criarBanco()
    {
        let gerenciadorArquivo = NSFileManager.defaultManager()
        let arquivo = NSHomeDirectory() + "/Documents/alunos.db"
        
        if !gerenciadorArquivo.fileExistsAtPath(arquivo)
        {
            if !gerenciadorArquivo.createFileAtPath(arquivo, contents: nil, attributes: nil)
            {
                NSLog("Erro ao tentar criar o arquivo \(arquivo)")
                return
            }
            
            NSLog("Arquivo \(arquivo) criado com sucesso")
            
            
            if sqlServer.conectar(arquivo){
                self.criarTabela()
            }
        }
        if !sqlServer.bancoEstaAberto{
            sqlServer.conectar(arquivo)
        }
        
    }
    
    
    
    func criarTabela()
    {
        let sql = Aluno.schema
        
        if sqlServer.executar(sql) {
            NSLog("criado")
            return
        }
        NSLog("Falha tabela nao criada!!!!")
    }
    
}