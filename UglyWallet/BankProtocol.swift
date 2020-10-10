//
//  BankProtocol.swift
//  UglyWallet
//
//  Created by Cristian Carlassare on 09/10/2020.
//

import Foundation

protocol BankProtocol {
    var commission: Double? { get set }
    func receiveCommission(amount: Double) //gets the commission for each transfer
    func printCommissions() //prints out the commissions balance
}

protocol ExtendedBankProtocol: BankProtocol {
    func commissionToPay(for amount: Double) -> Double
}
