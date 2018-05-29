import KeychainSwift
import EthereumKit

final public class EtherKeystore {
    
    let myEtherAddress: String = "com.otaku-coin.otaku-wallet-ios.myEtherAddress"
    let myPrivateKey: String = "com.otaku-coin.otaku-wallet-ios.myPrivateKey"
    
    func createWalletIfNotExists () {
        // Load from Keychain
        let keychain = KeychainSwift()
        let address: String? = keychain.get(myEtherAddress)
        let privateKey: String? = keychain.get(myPrivateKey)
        
        // Check if given keys exist in Keychain
        if address == nil || privateKey == nil {
            // Configurations
            let mnemonic = Mnemonic.create()
            let seed = Mnemonic.createSeed(mnemonic: mnemonic)
            let wallet: Wallet
            do {
                wallet = try Wallet(seed: seed, network: .ropsten)
            } catch let error {
                fatalError("Error: \(error.localizedDescription)")
            }
            
            // Create new wallet and save the address in Keychain
            let generatedAddress = wallet.generateAddress()
            let generatedPrivateKey = wallet.dumpPrivateKey()
            keychain.set(generatedAddress, forKey: myEtherAddress)
            keychain.set(generatedPrivateKey, forKey: myPrivateKey)
        }
        
        print("EtherKeystore: address ==> \(String(describing: address))")
        print("EtherKeystore: privateKey ==> \(String(describing: privateKey))")
    }
    
}
