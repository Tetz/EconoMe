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
        let address: String = "0x9aE1f5ADFcc383B1C5a85e7f0BBaD4b768e7D661"
        let request = EthGetTransactionCount(address: "0xCBe42308bd74b20a183c91E75e7bD72aa705234f")
        let batch = batchFactory.create(request)
        let httpRequest = EthServiceRequest(batch: batch)

        // TODO Encoded Transfer Function

        Session.send(httpRequest) { result in
            switch result {
            case .success(let nonce):
                print("===== nonce !!! =====")
                print(strtoul(nonce, nil, 16))
                let n: Int64 = Int64(strtoul(nonce, nil, 16))
                // public func GethNewTransaction(_ nonce: Int64, _ to: GethAddress!, _ amount: GethBigInt!, _ gasLimit: Int64, _ gasPrice: GethBigInt!, _ data: Data!) -> GethTransaction!
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

                // GethKeyStore
                // open func signTxPassphrase(_ account: GethAccount!, passphrase: String!, tx: GethTransaction!, chainID: GethBigInt!) throws -> GethTransaction
                let passphrase = "password"
                let newPassphrase = passphrase
                let keystoreStr: String? = self._keychain.get(self.myKeystore)
                let data: Data? = keystoreStr!.data(using: .utf8)
                let dataDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
                let keyStorePath = dataDir + "/keystore"
                let keystore: GethKeyStore = GethKeyStore(
                        keyStorePath,
                        scryptN: GethLightScryptN,
                        scryptP: GethLightScryptP
                )

                let account: GethAccount = try! keystore.importKey(
                        _ : data!,
                        passphrase: passphrase,
                        newPassphrase: newPassphrase
                )
                print(account.getAddress().getHex())

                try! keystore.unlock(account, passphrase: "password")
                let signedTx: GethTransaction = try! keystore.signTx(account, tx: tx, chainID: GethNewBigInt(3))
                print("===== signedTx =====")
                print(try! signedTx.encodeJSON())
                // TODO JSON RPC
                let txStr: String = try! signedTx.encodeRLP().hexEncodedString()
                print(txStr)
                let request = EthSendRawTransaction(signedTx: "0x" + txStr)
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
                print("===== error nounce !!! =====")
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

extension Data {
    struct HexEncodingOptions: OptionSet {
        let rawValue: Int
        static let upperCase = HexEncodingOptions(rawValue: 1 << 0)
    }

    func hexEncodedString(options: HexEncodingOptions = []) -> String {
        let format = options.contains(.upperCase) ? "%02X" : "%02x"
        return map { String(format: format, $0) }.joined()
    }

}

extension String {
    public func stripHexPrefix() -> String {
        var hex = self
        let prefix = "0x"
        if hex.hasPrefix(prefix) {
            hex = String(hex.dropFirst(prefix.count))
        }
        return hex
    }

    public func addHexPrefix() -> String {
        return "0x".appending(self)
    }

    public func toHexString() -> String {
        return data(using: .utf8)!.map { String(format: "%02x", $0) }.joined()
    }
}