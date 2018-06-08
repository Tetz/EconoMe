import UIKit
import SnapKit

class TokenListCell: UITableViewCell {
    var imgView: UIImageView?
    var titleLab:UILabel?
    var despLab:UILabel?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    func setupUI() {
        imgView = UIImageView()
        imgView?.image = UIImage.init(named: "Ethereum")
        // imgView?.layer.borderColor = UIColor.gray.cgColor
        // imgView?.layer.borderWidth = 1.0
        self.addSubview(imgView!)
        
        let label1 = UILabel()
        label1.font = .systemFont(ofSize: 20)
        self.addSubview(label1)
        titleLab = label1
        
        let label2 = UILabel()
        label2.font = .systemFont(ofSize: 20)
        label2.numberOfLines = 0
        self.addSubview(label2)
        despLab = label2;
        
        imgView?.snp.makeConstraints({ (make) in
            make.top.left.equalTo(10)
            make.width.height.equalTo(50)
        })
        
        label1.snp.makeConstraints { (make) in
            make.left.equalTo((imgView?.snp.right)!).offset(10)
            make.centerY.equalTo(imgView!)
        }
        
        label2.snp.makeConstraints { (make) in
            make.right.equalTo(self.snp.right).offset(-20)
            make.centerY.equalTo(imgView!)
        }
        
    }
    
}
