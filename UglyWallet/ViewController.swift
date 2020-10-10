//
//  ViewController.swift
//  UglyWallet
//
//  Created by Cristian Carlassare on 09/10/2020.
//

import UIKit

class ViewController: UIViewController {
    
    let wallet: ExampleWallet = ExampleWallet()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let queue = DispatchQueue(label: "transfer_queue", attributes: .concurrent)
        let queue2 = DispatchQueue(label: "transfer_queue2", attributes: .concurrent)

        
        queue.async {
            Thread.sleep(forTimeInterval: Double.random(in: 0...1))
            self.wallet.transferToUsd(amount: 100)
        }
        queue.async {
            Thread.sleep(forTimeInterval: Double.random(in: 0...1))
            self.wallet.trasnferToEuros(amount: 100)
        }
        queue2.async {
            Thread.sleep(forTimeInterval: Double.random(in: 0...1))
            self.wallet.transferToUsd(amount: 100)
        }
        queue.async {
            Thread.sleep(forTimeInterval: Double.random(in: 0...1))
            self.wallet.transferToUsd(amount: 100)  
        }
        queue2.async {
            Thread.sleep(forTimeInterval: Double.random(in: 0...1))
            self.wallet.trasnferToEuros(amount: 50)
        }
        queue2.async {
            Thread.sleep(forTimeInterval: Double.random(in: 0...1))
            self.wallet.transferToUsd(amount: 50)
        }
        queue.async {
            Thread.sleep(forTimeInterval: Double.random(in: 0...1))
            self.wallet.trasnferToEuros(amount: 50)
        }
        queue2.async {
            Thread.sleep(forTimeInterval: Double.random(in: 0...1))
            self.wallet.transferToUsd(amount: 50)
        }
        
        queue.async {
            Thread.sleep(forTimeInterval: 5)
            self.wallet.printBalance()
            self.wallet.bank?.printCommissions()
        }
    }

}

