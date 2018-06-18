import Foundation
import KeychainSwift
import Geth
import APIKit
import JSONRPCKit

final public class Ether {

    let batchFactory = BatchFactory(version: "2.0", idGenerator: NumberIdGenerator())
    let (keystore, account) = EthAccountCoordinator().launch(EthAccountConfiguration.default)

    func sendTransaction (to: String, amount: GethBigInt) {
        let request = EthGetTransactionCount(address: account!.getAddress().getHex())
        let batch = batchFactory.create(request)
        let httpRequest = EthServiceRequest(batch: batch)

        // Get nonce
        Session.send(httpRequest) { result in
            switch result {
            case .success(let result):
                let nonce: Int64 = Int64(strtoul(result, nil, 16))
                let opt = "0x00".data(using: .utf8)
                let tx: GethTransaction? = GethNewTransaction(
                        nonce,
                        GethAddress(fromHex: to),
                        amount,
                        22000,
                        GethNewBigInt(1000000000),
                        opt
                )

                // Unlock Account
                try! self.keystore!.unlock(self.account!, passphrase: "password")
                let signedTx: GethTransaction = try! self.keystore!.signTx(self.account!, tx: tx, chainID: GethNewBigInt(3))
                print(try! signedTx.encodeJSON())

                // RLP Encoding
                let txStr: String = try! signedTx.encodeRLP().hexEncodedString()

                // JSON RPC Request
                let request = EthSendRawTransaction(signedTx: txStr.addHexPrefix())
                let batch = self.batchFactory.create(request)
                let httpRequest = EthServiceRequest(batch: batch)

                Session.send(httpRequest) { result in
                    switch result {
                    case .success(let result):
                        print("Transaction ID: \(result)")
                    case .failure(let error):
                        print(error)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }

    }
}

