//
//  RepositoryTableViewCell.swift
//  GitMobile
//
//  Created by Zafar on 3/8/20.
//  Copyright © 2020 Zafar. All rights reserved.
//

import UIKit

import RxSwift

class RepositoryTableViewCell: UITableViewCell {
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    private let disposeBag = DisposeBag()
    var viewModel: RepositoryViewModel! {
        didSet {
            self.configure()
        }
    }
    
    lazy var repositoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "github_placeholder")
        return imageView
    }()
    
    lazy var repositoryTitleLabel: UILabel = {
        let label = UILabel()
        label.font = appFont(size: 18)
        return label
    }()
    
    lazy var repositoryDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = appFont(size: 14)
        return label
    }()
}

// MARK: - Configuration
extension RepositoryTableViewCell {
    private func configure() {
        repositoryTitleLabel.text = viewModel.title
        repositoryDescriptionLabel.text = viewModel.description
        
        viewModel.getImageData()
            .compactMap { ImageDataService.shared.convertToUIImage(from: $0) }
            .bind(to: repositoryImageView.rx.image)
            .disposed(by: disposeBag)
    }
}

// MARK: - UI Setup
extension RepositoryTableViewCell {
    private func setupUI() {
        self.contentView.addSubview(repositoryImageView)
        self.contentView.addSubview(repositoryTitleLabel)
        self.contentView.addSubview(repositoryDescriptionLabel)
        
        repositoryImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(50)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(20)
        }
        
        repositoryTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(repositoryImageView)
            make.left.equalTo(repositoryImageView.snp.right).offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        repositoryDescriptionLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(repositoryImageView)
            make.left.equalTo(repositoryTitleLabel)
        }
    }
}
