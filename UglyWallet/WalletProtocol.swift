//
//  WalletProtocol.swift
//  UglyWallet
//
//  Created by Cristian Carlassare on 09/10/2020.
//

protocol WalletProtocol {
    var balanceUsd: Double? { get set }
    var balanceEuros: Double? { get set }
    var bank: ExtendedBankProtocol? { get set }
    func transferToUsd(amount: Double) //Converts from usd to euros, send commission to Bank
    func trasnferToEuros(amount: Double) //Converts from euros to usd, send commission to Bank
    func getBalanceUsd() -> Double
    func getBalanceEuros() -> Double
}
