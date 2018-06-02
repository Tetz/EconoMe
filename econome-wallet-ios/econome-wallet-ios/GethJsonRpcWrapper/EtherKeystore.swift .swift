import KeychainSwift
import Geth

final public class EtherKeystore {
    
    let myEtherAddress: String = "com.otaku-coin.otaku-wallet-ios.myEtherAddress"
    let myPrivateKey: String = "com.otaku-coin.otaku-wallet-ios.myPrivateKey"
    
    func createWalletIfNotExists () {
        // Keysotre
        let dataDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let keyStorePath = dataDir + "/keystore"
        print("keyStorePath: \(keyStorePath)")
        
        let keyStoreManager = GethNewKeyStore(keyStorePath, GethLightScryptN, GethLightScryptP)
        let account = try! keyStoreManager?.newAccount("password")
        let address = account?.getAddress().getHex()
        print("address: \(address!)")
        
        let url = account?.getURL()
        print("URL: \(String(describing: url))")
        
        print("=====> Start")
        let fileName = "keystore/UTC--2018-06-01T04-25-35.634795774Z--2f3a3a89bf3e7b7d18ba97b4ca0fcd0595ab2ee9"
        let file = fileName
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(file)
            print(fileURL)
            do {
                let text = try String(contentsOf: fileURL, encoding: .utf8)
                print(text)
            }
            catch {/* error handling here */}
        }
    
    }
    
}
