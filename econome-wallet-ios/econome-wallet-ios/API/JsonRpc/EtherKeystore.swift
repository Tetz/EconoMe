import Foundation
import KeychainSwift
import Geth
import APIKit
import JSONRPCKit

final public class EtherKeystore {
    
    let myEtherAddress: String = "myEtherAddress"
    let myKeystore: String = "myKeystore"
    let _gethContext: GethContext? = nil
    let _keychain = KeychainSwift()
    let batchFactory = BatchFactory(version: "2.0", idGenerator: NumberIdGenerator())

    func createWalletIfNotExists () {
        // Load from Keychain
        let keychain = KeychainSwift()
        let address: String? = keychain.get(myEtherAddress)
        let keystore: String? = keychain.get(myKeystore)

        // Check if given keys exist in Keychain
        if address == nil || keystore == nil {
            // Keystore
            let dataDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
            let keyStorePath = dataDir + "/keystore"
            let keyStoreManager = GethNewKeyStore(keyStorePath, GethLightScryptN, GethLightScryptP)
            let account = try! keyStoreManager?.newAccount("password")
            let newAddress = account?.getAddress().getHex()
            print("newAddress: \(newAddress!)")
            
            let url = account?.getURL()
            let urlArr = url!.components(separatedBy: "/keystore/")
            let file = "keystore/" + urlArr[1]

            if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let fileURL = dir.appendingPathComponent(file)
                do {
                    let keystore = try String(contentsOf: fileURL, encoding: .utf8)
                    keychain.set(newAddress!, forKey: myEtherAddress)
                    keychain.set(keystore, forKey: myKeystore)
                    print(keystore)
                }
                catch {
                    print("Keystore File Error")
                }
            }
        }
        print("Wallet Address: \(keychain.get(myEtherAddress)!)")
        print("Wallet Keystore: \(keychain.get(myKeystore)!)")
    }

    func importWalletByKeystore (keystore: String, passphrase: String, newPassphrase: String) -> GethAccount {
        let data: Data? = keystore.data(using: .utf8)
        let dataDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let keyStorePath = dataDir + "/keystore"
        let account: GethAccount = try! GethKeyStore(
                keyStorePath,
                scryptN: GethLightScryptN,
                scryptP: GethLightScryptP
        ).importKey(
                _ : data!,
                passphrase: passphrase,
                newPassphrase: newPassphrase
        )

        print("======= importWalletByKeystore() =======")
        print(account.getAddress().getHex())
        return account
    }

    func getKeystore (keystore: String, passphrase: String, newPassphrase: String) -> GethKeyStore {
        let data: Data? = keystore.data(using: .utf8)
        let dataDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let keyStorePath = dataDir + "/keystore"
        let keystore: GethKeyStore = GethKeyStore(
                keyStorePath,
                scryptN: GethLightScryptN,
                scryptP: GethLightScryptP
        )

        return keystore
    }

    //
    func sign () {
        print("===== sign() =====")
        // GethTransaction
        // public init!(_ nonce: Int64, to: GethAddress!, amount: GethBigInt!, gasLimit: Int64, gasPrice: GethBigInt!, data: Data!)
        let toAddress = GethAddress(fromHex: "0x9aE1f5ADFcc383B1C5a85e7f0BBaD4b768e7D661")
        let opt = "0x00".data(using: .utf8)
        let tx = GethTransaction(
                1,
                to: toAddress,
                amount: GethNewBigInt(10000000000000000), // 0.01 Eth
                gasLimit: 4600000,
                gasPrice: GethNewBigInt(20000000000), // 20 Gwei
                data: opt
        )

        // GethKeyStore
        // open func signTxPassphrase(_ account: GethAccount!, passphrase: String!, tx: GethTransaction!, chainID: GethBigInt!) throws -> GethTransaction
        let keyString = _keychain.get(myKeystore)
        let keystore: GethKeyStore = getKeystore(keystore: keyString!, passphrase: "password", newPassphrase: "password")
        let data: Data? = keyString!.data(using: .utf8)
        let account: GethAccount = try! keystore.importKey(
                _ : data!,
                passphrase: "password",
                newPassphrase: "password"
        )
        try! keystore.unlock(account, passphrase: "password")
        let signedTx: String = try! keystore.signTx(account, tx: tx, chainID: GethNewBigInt(1)).getHash().getHex()
        print("===== signedTx =====")
        print(signedTx)
        let request = EthSendRawTransaction(signedTx: signedTx)
        let batch = batchFactory.create(request)
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

    }

    // TODO FIXME
//    func getBalance () {
//        let keyString = _keychain.get(myKeystore)
//        let account = importWalletByKeystore(keystore: keyString!, passphrase: "password", newPassphrase: "password").getAddress()
//
//        let geth = GethEthereumClient("https://ropsten.infura.io/xyji23ngACpAtbvoO0MZ")
//        let ctx: GethContext = GethContext()
//        let number: Int64 = 18
//
//        // open func getBalanceAt(_ ctx: GethContext!, account: GethAddress!, number: Int64) throws -> GethBigInt
//        let result = try! geth!.getBalanceAt(ctx, account: account, number: number)
//
//        print("======= getBalance =======")
//        print(account!.getHex())
//        print(result.string())
//    }
    
}
