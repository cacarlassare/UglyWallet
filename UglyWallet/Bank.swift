//
//  Bank.swift
//  UglyWallet
//
//  Created by Cristian Carlassare on 09/10/2020.
//

import UIKit

class Bank: NSObject, ExtendedBankProtocol {
    
    var commission: Double?
    fileprivate var receivedComissions: Array<Double> = Array<Double>()
    
    
    func receiveCommission(amount: Double) {
        self.receivedComissions.append(amount)
    }
    
    func printCommissions() {
        print("")
        if self.receivedComissions.isEmpty {
            print("No comissions registered.")
        } else {
            print("Comissions (expressed in Dollars):")
            for receivedComission in self.receivedComissions {
                print("• US$ \(receivedComission)")
            }
        }
    }
    
    func commissionToPay(for amount: Double) -> Double {
        let commission = amount * (self.commission ?? 0)
        return commission
    }
}
