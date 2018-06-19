import Foundation
import Geth

final public class EthereumHelper {

    func ethToWei (_ eth: Double) -> GethBigInt {
        let num = Int64(eth * 1000000000000000000)
        return GethNewBigInt(num)
    }

    func weiToEth (_ hex: String) -> Double {
        return Double(strtoul(hex, nil, 16)) * pow(0.1, 18)
    }

    func weiToGwei (_ hex: String) -> Double {
        return Double(strtoul(hex, nil, 16)) * pow(0.1, 9)
    }

    func tokenNum (_ hex: String, decimals: Double) -> Double {
        return Double(strtoul(hex, nil, 16)) * pow(0.1, decimals)
    }

}
