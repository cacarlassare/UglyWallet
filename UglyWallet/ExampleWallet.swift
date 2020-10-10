//
//  ExampleWallet.swift
//  UglyWallet
//
//  Created by Cristian Carlassare on 09/10/2020.
//

import UIKit

class ExampleWallet: Wallet {
    
    override init() {
        super.init()
        
        self.balanceUsd = 100
        self.balanceEuros = 100
        self.convertRate = 0.8
        
        self.bank = ExampleBank()
    }

}
