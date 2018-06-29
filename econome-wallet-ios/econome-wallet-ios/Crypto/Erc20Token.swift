import Foundation
import KeychainSwift
import Geth
import APIKit
import JSONRPCKit
import CryptoSwift

final public class Erc20Token {

    let batchFactory = BatchFactory(version: "2.0", idGenerator: NumberIdGenerator())
    let (keystore, account) = EthAccountCoordinator().launch(EthAccountConfiguration.default)

    private func padWithZeros(_ str: String) -> String {
        var paddedStr = str
        let lengthOf32BytesHex = 64
        while paddedStr.count != lengthOf32BytesHex {
            paddedStr = "0" + paddedStr
        }
        return paddedStr
    }

    func generateTransaction (nonce: Int64, to: String) -> GethTransaction? {
         let methodId = "a9059cbb000000000000000000000000".addHexPrefix()
         let hexAmount = padWithZeros("64")
         let dataStr = methodId + to.removeHexPrefix() + hexAmount
         let data = Data(hex: dataStr)
         print("=== Data ===")
         print(dataStr)
         let tx: GethTransaction? = GethNewTransaction(
                 nonce,
                 GethAddress(fromHex: "0x98cd8de75f15ceb40a8e8a5f19f19a6f943373f4"),
                 GethNewBigInt(0),
                 72000,
                 GethNewBigInt(10000000000),
                 data
         )
        return tx
    }

    func sendTransaction (to: String, amount: GethBigInt) {
        let request = EthGetTransactionCount(address: account!.getAddress().getHex())
        let batch = batchFactory.create(request)
        let httpRequest = EthServiceRequest(batch: batch)

        // Get nonce
        Session.send(httpRequest) { result in
            switch result {
            case .success(let result):
                let nonce: Int64 = Int64(strtoul(result, nil, 16))
                let methodId = "a9059cbb000000000000000000000000".addHexPrefix()
                let hexAmount = "0000000000000000000000000000000000000000000000000000000000000064"
                let dataStr = methodId + to.removeHexPrefix() + hexAmount
                let data = Data(hex: dataStr)
                print(dataStr)
                print("=== Data ===")
                let tx: GethTransaction? = GethNewTransaction(
                        nonce,
                        GethAddress(fromHex: "0x98cd8de75f15ceb40a8e8a5f19f19a6f943373f4"),
                        GethNewBigInt(0),
                        72000,
                        GethNewBigInt(10000000000),
                        data
                )

                // Unlock Account
                try! self.keystore!.unlock(self.account!, passphrase: "password")
                let signedTx: GethTransaction = try! self.keystore!.signTx(self.account!, tx: tx, chainID: GethNewBigInt(3))
                print(try! signedTx.encodeJSON())

                // RLP Encoding
                let txStr: String = try! signedTx.encodeRLP().hexEncodedString()
                print(txStr)

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

