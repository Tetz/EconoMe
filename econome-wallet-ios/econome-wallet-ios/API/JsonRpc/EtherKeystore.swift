import Foundation
import KeychainSwift
import Geth

final public class EtherKeystore {
    
    let myEtherAddress: String = "myEtherAddress"
    let myKeystore: String = "myKeystore"

    func createWalletIfNotExists () {
        // Load from Keychain
        let keychain = KeychainSwift()
        let address: String? = keychain.get(myEtherAddress)
        let keystore: String? = keychain.get(myKeystore)

        // Check if given keys exist in Keychain
        if address == nil || keystore == nil {
            // Keysotre
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
    
}
