//
//  Wallet.swift
//  UglyWallet
//
//  Created by Cristian Carlassare on 09/10/2020.
//

import UIKit

class Wallet: NSObject, WalletProtocol {
    var balanceUsd: Double?
    var balanceEuros: Double?
    var convertRate: Double!
    var bank: ExtendedBankProtocol? = Bank()
    
    fileprivate let lock = NSLock()
    
    
    // MARK: - Transfer
    
    func transferToUsd(amount: Double) {
        lock.lock()
            guard self.canTransfer(amount: amount, from: self.balanceEuros) else {
                self.printCantTransfer(amount: amount, balance: self.getBalanceEuros(), isDollar: false)
                lock.unlock()
                return
            }
        
            let convertRateToDollar = 1 / self.convertRate
        
            let dollarAmount = amount * convertRateToDollar
            let commissionToPay = self.bank!.commissionToPay(for: dollarAmount)
            let netDollarAmount = dollarAmount - commissionToPay
        
            self.balanceEuros! -= amount
            self.balanceUsd! += netDollarAmount
        
            self.bank!.receiveCommission(amount: commissionToPay)
            
            let currencySymbol = self.currencySymbol(for: false)
            print("Transfered: \(currencySymbol) \(amount)")
        lock.unlock()
    }
    
    func trasnferToEuros(amount: Double) {
        lock.lock()
            guard self.canTransfer(amount: amount, from: self.balanceUsd) else {
                self.printCantTransfer(amount: amount, balance: self.getBalanceUsd(), isDollar: true)
                lock.unlock()
                return
            }
        
            let commissionToPay = self.bank!.commissionToPay(for: amount)
            let netDollarAmount = amount - commissionToPay
        
            let euroAmount = netDollarAmount * self.convertRate
        
            self.balanceEuros! += euroAmount
            self.balanceUsd! -= amount
        
            self.bank!.receiveCommission(amount: commissionToPay)
            
            let currencySymbol = self.currencySymbol(for: true)
            print("Transfered: \(currencySymbol) \(amount)")
        lock.unlock()
    }
    
    
    // MARK: - Get balances
    
    func getBalanceUsd() -> Double {
        return self.balanceUsd ?? 0
    }
    
    func getBalanceEuros() -> Double {
        return self.balanceEuros ?? 0
    }
    
    
    // MARK: - Print balances
    
    func printBalance() {
        print("")
        print("Balance:")
        print("- Dollars: \(self.getBalanceUsd())")
        print("- Euros: \(self.getBalanceEuros())")
    }
    
    fileprivate func printCantTransfer(amount: Double, balance: Double, isDollar: Bool) {
        let currencySymbol = self.currencySymbol(for: isDollar) // With a "Currency" object this wouldn's be necessary
        print("Can't transfer \(currencySymbol) \(amount): your balance is \(currencySymbol) \(balance)")
    }
    
    fileprivate func currencySymbol(for dollar: Bool) -> String { // With a "Currency" object this wouldn's be necessary
        if dollar{
            return "US$"
        } else {
            return "EUR"
        }
    }
    
    
    // MARK: - Check transferences
    
    fileprivate func canTransfer(amount: Double, from balance: Double?) -> Bool {
        guard amount > 0 else {
            return false
        }
        
        guard let _ = self.bank else {
            return false
        }
        
        guard let balance = balance else {
            return false
        }
        
        guard balance >= amount else {
            return false
        }
        
        return true
    }

}

