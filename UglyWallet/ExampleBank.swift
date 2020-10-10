//
//  ExampleBank.swift
//  UglyWallet
//
//  Created by Cristian Carlassare on 09/10/2020.
//

import UIKit

class ExampleBank: Bank {
    
    override init() {
        super.init()
        
        self.commission = 0.025
    }
}
