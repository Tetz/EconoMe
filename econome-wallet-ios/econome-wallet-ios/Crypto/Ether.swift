import Foundation
import KeychainSwift
import Geth
import APIKit
import JSONRPCKit

final public class Ether {

    let batchFactory = BatchFactory(version: "2.0", idGenerator: NumberIdGenerator())
    let (keystore, account) = EthAccountCoordinator().launch(EthAccountConfiguration.default)

    func sendTransaction () {
        print("===== sign() =====")
        let address: String = "0x9aE1f5ADFcc383B1C5a85e7f0BBaD4b768e7D661"
        let request = EthGetTransactionCount(address: "0x288c9fC760b556C597E1662c8580d457E86b9Ff6")
        let batch = batchFactory.create(request)
        let httpRequest = EthServiceRequest(batch: batch)

        Session.send(httpRequest) { result in
            switch result {
            case .success(let nonce):
                print("===== nonce !!! =====")
                print(strtoul(nonce, nil, 16))
                let n: Int64 = Int64(strtoul(nonce, nil, 16))
                let toAddress = GethAddress(fromHex: address)
                let opt = "0x00".data(using: .utf8)
                let tx: GethTransaction? = GethNewTransaction(
                        n,
                        toAddress,
                        GethNewBigInt(10000000000000000), // 0.01 Eth
                        22000,
                        GethNewBigInt(1000000000), //  11 Gwei
                        opt
                )

                print(self.account!.getAddress().getHex())

                try! self.keystore!.unlock(self.account!, passphrase: "password")
                let signedTx: GethTransaction = try! self.keystore!.signTx(self.account!, tx: tx, chainID: GethNewBigInt(3))
                print("===== signedTx =====")
                print(try! signedTx.encodeJSON())
                let txStr: String = try! signedTx.encodeRLP().hexEncodedString()
                print(txStr)
                let request = EthSendRawTransaction(signedTx: txStr.addHexPrefix())
                let batch = self.batchFactory.create(request)
                let httpRequest = EthServiceRequest(batch: batch)
                print(httpRequest)

                Session.send(httpRequest) { result in
                    switch result {
                    case .success(let result):
                        print("===== Success !!! =====")
                        print(result)
                    case .failure(let error):
                        print(error)
                    }
                }
            case .failure(let error):
                print("===== error nonce !!! =====")
                print(error)
            }
        }

    }
}

