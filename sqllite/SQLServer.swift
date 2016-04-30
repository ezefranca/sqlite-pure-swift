//
//  SQLServer.swift
//  sqllite
//
//  Created by Swift-301-SAB on 30/04/16.
//  Copyright © 2016 Swift-301-SAB. All rights reserved.
//

import Foundation

/**
 Classe que faz o banco
 */
class SQLServer
{
    var identificadorBanco : COpaquePointer = nil
    
    //Guarda o nome do arquivo
    var arquivo : String = ""
    
    //Estado atual do banco de dados
    private var bancoAberto : Bool = false
    
    var bancoEstaAberto : Bool {
        return bancoAberto
    }
    
    init(){}
    deinit {}
    
    //Abre uma conexao de banco de dados com um determinado arquivo
    //
    func conectar(arquivo:String) -> Bool{
        if sqlite3_open(arquivo, &identificadorBanco) != SQLITE_OK {
            let mensagemErro = String.fromCString(sqlite3_errmsg(identificadorBanco))
            NSLog("Falha \(mensagemErro)")
            bancoAberto = false
            return false
        }
        
        self.arquivo = arquivo
        bancoAberto = true
        NSLog("Arquivo criado com sucesso em: \(arquivo)")
        return true
    }
    
    
    func close(){
        bancoAberto = false
        sqlite3_close(identificadorBanco)
        NSLog("Fechado o banco \(arquivo)")
    }
    
    
    func executar(sql:String) -> Bool
    {
        if !bancoAberto
        {
            NSLog("Não foi possível abrir")
            return false
        }
        
        if sqlite3_exec(identificadorBanco, sql, nil, nil, nil) != SQLITE_OK {
            let mensagemErro = String.fromCString(sqlite3_errmsg(identificadorBanco))
            NSLog("Falha \(mensagemErro)")
            return false
        }
        NSLog("Comando \(sql) executado com sucesso!")
        return true
    }
    
    func resgatar(sqlBusca : String) -> [[String:AnyObject]]?
    {
        var resultado : [[String:AnyObject]] = []
        var identificadorBusca : COpaquePointer = nil
        var contador = -1
        
        if sqlite3_prepare_v2(identificadorBanco, sqlBusca, -1, &identificadorBusca, nil) != SQLITE_OK
        {
            let mensagemErro = String.fromCString(sqlite3_errmsg(identificadorBusca))
            NSLog("Erro ao executar a query \(sqlBusca):   \(mensagemErro)")
            return nil
        }
        
        
        while(sqlite3_step(identificadorBusca) == SQLITE_ROW)
        {
            NSLog("Registro encontrado")
            
            contador += 1
            resultado.append([:])
            
            
            let quantidadeColunas =  sqlite3_column_count(identificadorBusca)
            
            for coluna in 0..<quantidadeColunas
            {
                let tipoColuna = sqlite3_column_type(identificadorBusca, coluna)
                let nomeColuna = String.fromCString(sqlite3_column_name(identificadorBusca, coluna))
                
                
                if tipoColuna == SQLITE_TEXT {
                    resultado[contador][nomeColuna!] = String.fromCString(UnsafePointer<CChar> (sqlite3_column_text(identificadorBusca, coluna)))
                }
                
                else if tipoColuna == SQLITE_INTEGER {
                    resultado[contador][nomeColuna!] =  Int(sqlite3_column_int(identificadorBusca, coluna))
                }
                
                else if tipoColuna == SQLITE_NULL {
                    resultado[contador][nomeColuna!] = nil
                }
                
                else if tipoColuna == SQLITE_FLOAT {
                    resultado[contador][nomeColuna!] = sqlite3_column_double(identificadorBusca, coluna)
                }
                
                
                
            }
            
        }
        return resultado
    }
    
    
}