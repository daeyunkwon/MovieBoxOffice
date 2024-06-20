//
//  ViewController.swift
//  MovieBoxOffice
//
//  Created by 권대윤 on 6/6/24.
//

import UIKit

import Alamofire
import SnapKit

final class ViewController: UIViewController {
    
    //MARK: - Properties
    
    private var movies: [BoxOffice] = []
    
    //MARK: - UI Components
    
    private let tableView = UITableView()
    
    private let dateTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "20200401 형식으로 검색해보세요"
        tf.textColor = .white
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.keyboardType = .numberPad
        tf.attributedPlaceholder = NSAttributedString(string: #""20200401"형식으로 검색해보세요"#, attributes: [.foregroundColor: UIColor.lightGray, .font: UIFont.systemFont(ofSize: 14)])
        return tf
    }()
    
    private let textFieldBottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var searchButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .white
        btn.setTitle("검색", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.setTitleColor(.systemGray, for: .highlighted)
        btn.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    private let backImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private let backBlackView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.6)
        return view
    }()
    
    
    //MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureLayout()
        configureUI()
        fetchData()
    }
    
    private func fetchData() {
        let yesterday = getYesterdayDateString()
        
        NetworkManager.shared.fetchBoxOfficeData(date: yesterday) { data in
            self.movies = data.boxOfficeResult.dailyBoxOfficeList
            self.tableView.reloadData()
        }
    }
    
    private func configureTableView() {
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(DailyBoxOfficeTableViewCell.self, forCellReuseIdentifier: DailyBoxOfficeTableViewCell.identifier)
    }
    
    private func configureLayout() {
        view.addSubview(backImageView)
        backImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        backImageView.addSubview(backBlackView)
        backBlackView.snp.makeConstraints { make in
            make.top.equalTo(backImageView.snp.top)
            make.leading.equalTo(backImageView.snp.leading)
            make.trailing.equalTo(backImageView.snp.trailing)
            make.bottom.equalTo(backImageView.snp.bottom)
        }
        
        view.addSubview(searchButton)
        searchButton.snp.makeConstraints { make in
            make.top.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.width.equalTo(80)
            make.height.equalTo(50)
        }
        
        view.addSubview(dateTextField)
        dateTextField.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.trailing.equalTo(searchButton.snp.leading).offset(-10)
            make.centerY.equalTo(searchButton.snp.centerY).offset(-1)
            make.height.equalTo(30)
        }
        
        view.addSubview(textFieldBottomLine)
        textFieldBottomLine.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.trailing.equalTo(searchButton.snp.leading).offset(-10)
            make.height.equalTo(5)
            make.top.equalTo(dateTextField.snp.bottom).offset(5)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(textFieldBottomLine.snp.bottom).offset(10)
        }
    }
    
    private func configureUI() {
        backImageView.image = UIImage.back
    }
    
    //MARK: - Functions

    @objc func searchButtonTapped() {
        view.endEditing(true)
        guard let text = self.dateTextField.text, text.trimmingCharacters(in: .whitespaces).isEmpty == false else {return}
        
        NetworkManager.shared.fetchBoxOfficeData(date: text) { data in
            self.movies = data.boxOfficeResult.dailyBoxOfficeList
            self.tableView.reloadData()
        }
    }
    
    private func getYesterdayDateString() -> String {
        var todayDate = Date.timeIntervalSinceReferenceDate
        todayDate -= 86400
        let yesterdayDate = Date(timeIntervalSinceReferenceDate: todayDate)
        
        let formatter = DateFormatter()
        formatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyyMMdd"
        let yesterday = formatter.string(from: yesterdayDate)
        return yesterday
    }
}

//MARK: - UITableViewDataSource & UITableViewDelegate

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DailyBoxOfficeTableViewCell.identifier, for: indexPath) as! DailyBoxOfficeTableViewCell
        
        cell.movie = self.movies[indexPath.row]
        
        return cell
    }
}

