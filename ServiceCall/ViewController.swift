//
//  ViewController.swift
//  ServiceCall
//
//  Created by gowri anguraj on 08/01/20.
//  Copyright © 2020 gowri anguraj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
        let tableView: UITableView = UITableView()
        var listingsArray: [UsedCarSpecs]?
        let serviceManager = ServiceRequest()
        
        lazy var spinner: UIActivityIndicatorView = {
            let spinner = UIActivityIndicatorView(style: .whiteLarge)
            spinner.translatesAutoresizingMaskIntoConstraints = false
            spinner.heightAnchor.constraint(equalToConstant: 50).isActive = true
            spinner.widthAnchor.constraint(equalToConstant: 50).isActive = true
            spinner.backgroundColor = UIColor(hue: 0.0, saturation: 0.0, brightness: 0.0, alpha: 0.4)
            spinner.layer.cornerRadius = 8.0
            spinner.clipsToBounds = true
            spinner.hidesWhenStopped = true
            return spinner
        }()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            setupSpinnerView()
            makeNetworkRequest()
        }
        
        private func setupSpinnerView(){
            self.view.addSubview(spinner)
            spinner.frame = self.view.frame
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            spinner.startAnimating()
        }
        
        private func setupTableView() {
            tableView.backgroundColor = .white
            tableView.separatorStyle = .singleLine
            tableView.register(TableCellView.self, forCellReuseIdentifier: "carlistingcell")
            tableView.dataSource = self
            tableView.delegate = self
            tableView.clipsToBounds = true
            tableView.separatorColor = .clear
            self.view.addSubview(tableView)
            self.navigationItem.title = "Car Listings"
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
            tableView.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
            tableView.leadingAnchor.constraint(equalTo:view.leadingAnchor).isActive = true
            tableView.trailingAnchor.constraint(equalTo:view.trailingAnchor).isActive = true
        }
        
        private func makeNetworkRequest() {
            serviceManager.fetchUsedCarListingsResponse {(response) in
                switch response{
                case.success(let responseInfo):
                    self.listingsArray = responseInfo
                    DispatchQueue.main.async {
                        self.setupTableView()
                        self.spinner.startAnimating()
                    }
                    NSLog("Usercar list data response \(String(describing: responseInfo))")
                case.failure(let error):
                    NSLog("error occured while requesting response Data \(error.localizedDescription)")
                }
            }
        }
        
        @objc func didTapCallButton(sender: UIButton) {
            guard let phoneNumber = listingsArray?[sender.tag].dealer.phone else {return}
            if let phoneURL = URL(string: "tel://\(phoneNumber)"), UIApplication.shared.canOpenURL(phoneURL) {
                UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
            }
        }
    }
    
    extension ViewController: UITableViewDelegate, UITableViewDataSource {
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.listingsArray?.count ?? 0
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "carlistingcell", for: indexPath) as? TableCellView, let listngsInfo = self.listingsArray?[indexPath.row] else {
                return UITableViewCell()
            }
            cell.configureCellData(withInfo: listngsInfo)
            cell.phoneNumberButtonView.tag = indexPath.row
            cell.phoneNumberButtonView.addTarget(self, action: #selector(didTapCallButton), for: .touchUpInside)
            return cell
        }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 300
        }
    }
    






