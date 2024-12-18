//
//  Cell.swift
//  AnyList
//
//  Created by Вячеслав Башур on 18/12/2024.
//

import UIKit

class ElementCell: UITableViewCell {
    static let reuseId = "element"
    
    enum Icon {
        static let on = UIImage(systemName: "circle.fill")
        static let off = UIImage(systemName: "checkmark.circle.fill")
    }
    
    var element: Element?
    
    lazy var cellView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .brown
        return view
    }()
    
    lazy var icon = {
        let icon = UIImageView()
        icon.contentMode = .scaleAspectFit
        icon.tintColor = .systemGray3
        icon.backgroundColor = .black
        icon.layer.cornerRadius = Config.buttonSize / 2
        icon.widthAnchor.constraint(
            equalToConstant: Config.buttonSize
        ).isActive = true
        icon.heightAnchor.constraint(
            equalToConstant: Config.buttonSize
        ).isActive = true
        return icon
    }()
    
    lazy var nameLabel = AppLabel(style: .value)
    
    lazy var messageLabel = AppLabel(style: .subtitle)
    
//    lazy var textStack = UIStackView(arrangedSubviews: [nameLabel, messageLabel])
    
    lazy var stack = UIStackView(arrangedSubviews: [icon, nameLabel, messageLabel])
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setCell() {
//        textStack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .clear
        contentView.addSubview(cellView)
        cellView.addSubview(stack)
        stack.distribution = .fillProportionally
        nameLabel.text = "dsgsdgsdgsdgdsg"
        messageLabel.text = "sdgsdgsdgsdg"
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Config.Cell.indent),
            cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Config.Cell.indent),
            cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Config.Cell.indent),
            cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Config.Cell.indent),
            
            stack.topAnchor.constraint(equalTo: cellView.topAnchor),
            stack.leadingAnchor.constraint(equalTo: cellView.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: cellView.trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: cellView.bottomAnchor),
        ])
    }
    
    func setElement(isActive: Bool?, name: String?, message: String?) {
        guard let isActive, let name, let message else { return }
        nameLabel.text = name
        messageLabel.text = message
        
        if isActive {
            icon.image = Icon.on
        } else {
            icon.image = Icon.off
            cellView.backgroundColor = .clear
            nameLabel.textColor = .black.withAlphaComponent(Config.alfa)
            messageLabel.textColor = .black.withAlphaComponent(Config.alfa)
        }
    }
}
