//
//  EntidadeProtocol.swift
//  sqllite
//
//  Created by Swift-301-SAB on 30/04/16.
//  Copyright © 2016 Swift-301-SAB. All rights reserved.
//

import Foundation

protocol EntidadeProtocol {
    
    static var schema : String {get}
    
    func remover() -> Bool
    func salvar() -> Bool
    func resgatar() -> Bool
    
}