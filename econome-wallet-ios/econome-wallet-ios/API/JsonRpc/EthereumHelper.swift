import Foundation
import Geth

final public class EthereumHelper {

    func weiToEth (hex: String) -> Double {
        return Double(strtoul(hex, nil, 16)) * pow(0.1, 18)
    }

    func weiToGwei (hex: String) -> Double {
        return Double(strtoul(hex, nil, 16)) * pow(0.1, 9)
    }

    func tokenNum (hex: String, decimals: Double) -> Double {
        return Double(strtoul(hex, nil, 16)) * pow(0.1, decimals)
    }

}
