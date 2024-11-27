import UIKit

class UserListView: UIView {
    private let tableView = UITableView()
    private var users: [User] = []
    private let gitDataService: GitData = GitDataImpl.shared

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        fetchUsers()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        fetchUsers()
    }

    private func setupUI() {
        // Configure the table view
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: "UserCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false

        // Add the table view to the view
        addSubview(tableView)

        // Set constraints for the table view
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func fetchUsers() {
        let url = "https://gist.githubusercontent.com/peymano-wmt/32dcb892b06648910ddd40406e37fdab/raw/db25946fd77c5873b0303b858e861ce724e0dcd0/countries.json"
        gitDataService.getData(from: url) { [weak self] fetchedUsers in
            self?.users = fetchedUsers
            self?.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource
extension UserListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as? UserTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: users[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate
extension UserListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected User: \(users[indexPath.row].name)")
    }
}

// MARK: - Custom Table View Cell
class UserTableViewCell: UITableViewCell {
    private let nameLabel = UILabel()
    private let emailLabel = UILabel()

    func configure(with user: User) {
        nameLabel.text = "Name: \(user.name)"
        emailLabel.text = """
        Capital: \(user.capital)
        Currency: \(user.currency.name) \(user.currency.symbol ?? "(No symbol)")
        Language: \(user.language.name) \(user.language.code ?? "(No code)")
        Region: \(user.region)
        """
    }

 

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(emailLabel)

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),

            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            emailLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            emailLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            emailLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}
