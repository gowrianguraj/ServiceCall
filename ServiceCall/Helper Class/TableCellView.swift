//
//  TableCellView.swift
//  ServiceCall
//
//  Created by gowri anguraj on 08/01/20.
//  Copyright © 2020 gowri anguraj. All rights reserved.
//

import Foundation
import UIKit

class TableCellView: UITableViewCell {
    private let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let carImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let yearMakeModelTrimLabelView: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceMileageLocationLabelView: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let phoneNumberButtonView: UIButton = {
        let button = UIButton()
        button.tintColor = .blue
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init coder hasn't been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setupView() {
        addSubview(cellView)
        cellView.addSubview(carImageView)
        cellView.addSubview(yearMakeModelTrimLabelView)
        cellView.addSubview(priceMileageLocationLabelView)
        cellView.addSubview(phoneNumberButtonView)
        
        NSLayoutConstraint.activate([
            //constraints to one whole cell
            cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            cellView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            cellView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0)
            ])
        
        //contraints to car image view
        carImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        carImageView.widthAnchor.constraint(equalTo: cellView.widthAnchor, constant: 0).isActive = true
        carImageView.leftAnchor.constraint(equalTo: cellView.leftAnchor).isActive = true
        carImageView.leftAnchor.constraint(equalTo: cellView.leftAnchor).isActive = true
        carImageView.rightAnchor.constraint(equalTo: cellView.leftAnchor, constant: 0).isActive = true
        
        // Constraints to label 1
        yearMakeModelTrimLabelView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        yearMakeModelTrimLabelView.topAnchor.constraint(equalTo:carImageView.bottomAnchor, constant: 10).isActive = true
        yearMakeModelTrimLabelView.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant:20).isActive = true
        
        //constraints to label 2
        priceMileageLocationLabelView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        priceMileageLocationLabelView.topAnchor.constraint(equalTo:yearMakeModelTrimLabelView.bottomAnchor, constant: 10).isActive = true
        priceMileageLocationLabelView.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant:20).isActive = true
        
        // contraints to phone number button
        phoneNumberButtonView.heightAnchor.constraint(equalToConstant: 10).isActive = true
        phoneNumberButtonView.topAnchor.constraint(equalTo:priceMileageLocationLabelView.bottomAnchor, constant: 20).isActive = true
        phoneNumberButtonView.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant:20).isActive = true
        phoneNumberButtonView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    func configureCellData(withInfo info: UsedCarSpecs?) {
        guard let info = info  else { return }
        if let carImageURL = info.images?.firstPhoto.large {
            carImageView.fetchImageFromURLStringAndCache(urlString: carImageURL)
        }
        
        let trim = info.trim != "Unspecified" ? info.trim :""
        yearMakeModelTrimLabelView.text = "\(info.year) \(info.make) \(info.model) \(trim)"
        
        priceMileageLocationLabelView.text = "$\(info.currentPrice.toString()) | \(info.mileage) Mi | \(info.dealer.city), \(info.dealer.state)"
        
        let number = info.dealer.phone.toPhoneNumber()
        phoneNumberButtonView.setTitle(number, for: .normal)
    }
}


