import UIKit

class ViewController: UIViewController {
    private let label = UILabel()
    private var count = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.07, green: 0.09, blue: 0.16, alpha: 1)

        label.text = "Bonjour ! 0"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 34)
        label.textAlignment = .center
        label.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 60)
        label.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY - 70)
        label.autoresizingMask = [.flexibleWidth, .flexibleTopMargin, .flexibleBottomMargin]
        view.addSubview(label)

        let button = UIButton(type: .system)
        button.setTitle("Appuie ici", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        button.backgroundColor = UIColor(red: 0.2, green: 0.5, blue: 1, alpha: 1)
        button.layer.cornerRadius = 14
        button.frame = CGRect(x: 0, y: 0, width: 220, height: 56)
        button.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY + 20)
        button.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin, .flexibleBottomMargin]
        button.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        view.addSubview(button)
    }

    @objc private func tapped() {
        count += 1
        label.text = "Bonjour ! \(count)"
    }
}
