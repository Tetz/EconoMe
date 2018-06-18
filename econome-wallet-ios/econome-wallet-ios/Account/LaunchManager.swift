import Foundation
import KeychainSwift
import Geth

final public class LaunchManger {

    let launchStatusKey: String = "LAUNCH_STATUS"

    @discardableResult init() {
        let keychain = KeychainSwift()
        keychain.set("BEFORE_TUTORIAL", forKey: launchStatusKey)
        let launchStatus: String? = keychain.get(launchStatusKey)

        if launchStatus == "BEFORE_TUTORIAL" {
            keychain.set("AFTER_TUTORIAL", forKey: launchStatusKey)
        }
    }

}


