//
//  RickMortyViewController.swift
//  RickMortySwiftWithoutSB
//
//  Created by Mehmet Mustafa Kılıç on 22.11.2022.
//

import UIKit
import SnapKit

protocol RickMortyOutPut {
    func changeLoading(isLoad: Bool)
    func saveDatas(Values: [Result])
}


final class RickMortyViewController: UIViewController {
    private let labelTitle: UILabel = UILabel()
    private let tableView: UITableView = UITableView()
    private let indicator: UIActivityIndicatorView = UIActivityIndicatorView()
    private lazy var results: [Result] = []
    lazy var viewModel: IRickMortyViewModel = RickMortyViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        viewModel.setDelegate(output: self)
        viewModel.fetchItem()
    }
    
    private func configure() {
        view.addSubview(labelTitle)
        view.addSubview(tableView)
        view.addSubview(indicator)
        
        drawDesing()
        makeLabel()
        makeIndicator()
        makeTableView()
    }
    
    func drawDesing() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RickMortyTableViewCell.self , forCellReuseIdentifier: RickMortyTableViewCell.Identifier.custom.rawValue)
        tableView.rowHeight = 200
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.view.backgroundColor = .white
            self.labelTitle.font = .boldSystemFont(ofSize: 25)
            self.indicator.color = .systemBlue
            self.labelTitle.text = "Ricky Morty"
        }
        self.indicator.startAnimating()
    }
}

extension RickMortyViewController: RickMortyOutPut {
    func changeLoading(isLoad: Bool) {
        isLoad ? indicator.startAnimating() : indicator.stopAnimating()
    }
    
    func saveDatas(Values: [Result]) {
        results = Values
        tableView.reloadData()
    }
    
    
}

extension RickMortyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: RickMortyTableViewCell = tableView.dequeueReusableCell(withIdentifier: RickMortyTableViewCell.Identifier.custom.rawValue) as? RickMortyTableViewCell else {
            return UITableViewCell()
        }
        
        cell.saveModel(model: results[indexPath.row])
        
        return cell
    }
    
    
}

extension RickMortyViewController {
    func makeLabel() {
        labelTitle.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
            make.height.greaterThanOrEqualTo(10)
        }
    }
    
    func makeIndicator() {
        indicator.snp.makeConstraints { (make) in
            make.top.equalTo(labelTitle)
            make.right.equalTo(labelTitle).offset(-5)
            make.top.equalTo(labelTitle)
        }
    }
    
    func makeTableView() {
        tableView .snp.makeConstraints { (make) in
            make.top.equalTo(labelTitle.snp.bottom).offset(10)
            make.bottom.equalToSuperview()
            make.left.right.equalTo(labelTitle)
        }
    }
}
