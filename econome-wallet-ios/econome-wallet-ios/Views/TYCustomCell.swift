import UIKit
import SnapKit

class TYCustomCell: UITableViewCell {
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
        //初始化头像
        imgView = UIImageView()
        imgView?.image = UIImage.init(named: "img.jpg")
        imgView?.layer.borderColor = UIColor.gray.cgColor
        imgView?.layer.borderWidth = 1.0
        self.addSubview(imgView!)
        
        //顶部的label 初始化
        let label1 = UILabel()
        label1.font = .systemFont(ofSize: 15)
        label1.textColor = .red
        self.addSubview(label1)
        titleLab = label1
        
        //底部的label 初始化
        let label2 = UILabel()
        label2.font = .systemFont(ofSize: 14)
        label2.textColor = .black
        label2.numberOfLines = 0
        self.addSubview(label2)
        despLab = label2;
        
        //设置布局 SnapKit  --- >相当去Objective-C中的Masonry
        imgView?.snp.makeConstraints({ (make) in
            make.top.left.equalTo(10)
            make.width.height.equalTo(40)
        })
        
        label1.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.left.equalTo((imgView?.snp.right)!).offset(10)
            make.right.equalTo(-10)
            make.height.equalTo(21)
        }
        
        label2.snp.makeConstraints { (make) in
            make.top.equalTo(label1.snp.bottom).offset(10)
            make.left.equalTo((imgView?.snp.right)!).offset(10)
            make.right.equalTo(-10)
            make.bottom.equalTo(-10)
        }
        
    }
    
}
