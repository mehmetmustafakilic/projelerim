//
//  RickMortyTableViewCell.swift
//  RickMortySwiftWithoutSB
//
//  Created by Mehmet Mustafa Kılıç on 24.11.2022.
//

import UIKit
import AlamofireImage
import SnapKit

class RickMortyTableViewCell: UITableViewCell {
    
    private let customImage: UIImageView = UIImageView()
    private let title: UILabel = UILabel()
    private let customDescription: UILabel = UILabel()
    private let randomImage: String = "https://picsum.photos/200/300"
    
    enum Identifier: String {
        case custom = "mstf1.0"
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(customImage)
        addSubview(title)
        addSubview(customDescription)
        title.font = .boldSystemFont(ofSize: 16)
        customDescription.font = .italicSystemFont(ofSize: 17)
        customImage.snp.makeConstraints { (make) in
            make.height.equalTo(100)
            make.top.equalTo(contentView)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        title.snp.makeConstraints { (make) in
            make.top.equalTo(customImage.snp.bottom).offset(10)
            make.left.right.equalTo(customImage)
        }
        
        customDescription.snp.makeConstraints { (make) in
            make.top.equalTo(title).offset(5)
            make.left.right.equalTo(title)
            make.bottom.equalToSuperview()
        }
    }
    
    func saveModel(model: Result) {
        title.text = model.name
        customDescription.text = model.status
        customImage.af.setImage(withURL: URL(string: model.image ?? randomImage) ?? URL(string: randomImage )!)
    }
}
