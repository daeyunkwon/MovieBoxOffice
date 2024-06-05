//
//  DailyBoxOfficeTableViewCell.swift
//  MovieBoxOffice
//
//  Created by 권대윤 on 6/6/24.
//

import UIKit

import SnapKit

final class DailyBoxOfficeTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    
    var movie: BoxOffice? {
        didSet {
            guard let movieNm = movie?.movieNm else {return}
            guard let rank = movie?.rank else {return}
            guard let date = movie?.openDt else {return}
            
            rankLabel.text = rank
            movieNameLabel.text = movieNm
            dateLabel.text = date
        }
    }
    
    //MARK: - UI Components
    
    private let rankLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.backgroundColor = .white
        label.font = .systemFont(ofSize: 15, weight: .heavy)
        label.textAlignment = .center
        return label
    }()
    
    private let movieNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .heavy)
        label.textColor = .white
        label.numberOfLines = 1
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray3
        label.font = .systemFont(ofSize: 13)
        label.textAlignment = .right
        return label
    }()

    //MARK: - Init
    
    override func prepareForReuse() {
        super.prepareForReuse()
        rankLabel.text = ""
        movieNameLabel.text = ""
        dateLabel.text = ""
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        let stackView = UIStackView(arrangedSubviews: [rankLabel, movieNameLabel, dateLabel])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fill
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.verticalEdges.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(10)
        }
        
        rankLabel.snp.makeConstraints { make in
            make.width.equalTo(50)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.width.equalTo(80)
        }
    }
}
