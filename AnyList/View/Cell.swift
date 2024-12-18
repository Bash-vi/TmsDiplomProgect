//
//  Cell.swift
//  AnyList
//
//  Created by Вячеслав Башур on 18/12/2024.
//

import UIKit

class HobbieCell: UITableViewCell {
    static let reuseId = "element"
    
    enum Icon {
        static let on = UIImage(systemName: "circle.fill")
        static let off = UIImage(systemName: "checkmark.circle.fill")
    }
    
    var element: Element?
    
    lazy var cellView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    lazy var icon = {
        let icon = UIImageView(image: .init(systemName: "checkmark.circle.fill"))
        icon.contentMode = .scaleAspectFit
        icon.tintColor = .systemGray3
        icon.backgroundColor = .black
//        icon.layer.cornerRadius = Constant.buttonSize / 2
//        icon.widthAnchor.constraint(
//            equalToConstant: Constant.buttonSize
//        ).isActive = true
//        icon.heightAnchor.constraint(
//            equalToConstant: Constant.buttonSize
//        ).isActive = true
        return icon
    }()
    
    lazy var nameLabel = AppLabel(style: .value)
    
    lazy var messageLabel = AppLabel(style: .subtitle)
    
    lazy var textStack = UIStackView(arrangedSubviews: [nameLabel, messageLabel])
    
    lazy var stack = UIStackView(arrangedSubviews: [icon, textStack, messageLabel])
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setCell()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setCell() {
        textStack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .clear
        contentView.addSubview(cellView)
        cellView.addSubview(stack)
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Config.Cell.indent),
            cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Config.Cell.indent),
            cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Config.Cell.indent),
            cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Config.Cell.indent),
            
            stack.topAnchor.constraint(equalTo: cellView.topAnchor, constant: Config.Cell.indent),
            stack.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: Config.Cell.indent),
            stack.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -Config.Cell.indent),
            stack.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -Config.Cell.indent),
        ])
    }
    
    func setElement() {
        guard let element else { return }
        nameLabel.text = element.name
        messageLabel.text = element.message
    }
}
