import Foundation

protocol GitData {
    func getData(from url: String, completion: @escaping ([User]) -> Void)
}

class GitDataImpl: GitData {
    static let shared = GitDataImpl()
    private init() {}

    func getData(from url: String, completion: @escaping ([User]) -> Void) {
        guard let serverUrl = URL(string: url) else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: serverUrl) { data, _, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("No data received")

                return
            }

            do {
                let decodedUsers = try JSONDecoder().decode([User].self, from: data)
                DispatchQueue.main.async {
                    completion(decodedUsers)
                }
            } catch {
                print("Decoding error: \(error)")
            }
        }.resume()
    }
}
