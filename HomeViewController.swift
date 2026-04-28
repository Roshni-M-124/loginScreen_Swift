//
//  HomeViewController.swift
//  loginScreen
//
//  Created by Mobicip on 14/04/26.
//

import UIKit

// Data

nonisolated enum Section {
    case main
}

nonisolated struct Fruit: Hashable {
    let id = UUID()
    let title: String
    let price: String
    let imageIndex: Int
    var isExpanded: Bool = false
    
    
}

nonisolated enum Item: Hashable {
    case fruit(Fruit)
    case price(Fruit)
}

// ViewController

class HomeViewController: UIViewController,
                          UITableViewDelegate,
                          UITableViewDataSourcePrefetching {

    let tableView: UITableView = {
        let table = UITableView()
        table.register(FruitCell.self, forCellReuseIdentifier: "FruitCell")
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 80
        return table
    }()

    var dataSource: UITableViewDiffableDataSource<Section, Item>!

    var fruits: [Fruit] = [
        Fruit(title: "Apple", price: "₹120/kg", imageIndex: 0),
        Fruit(title: "Banana", price: "₹60/kg", imageIndex: 1),
        Fruit(title: "Orange", price: "₹80/kg", imageIndex: 2),
        Fruit(title: "Mango", price: "₹150/kg", imageIndex: 3),
        Fruit(title: "Grapes", price: "₹90/kg", imageIndex: 4),
        Fruit(title: "Pineapple", price: "₹70/kg", imageIndex: 5),
        Fruit(title: "Papaya", price: "₹50/kg", imageIndex: 6),
        Fruit(title: "Watermelon", price: "₹40/kg", imageIndex: 7),
        Fruit(title: "Guava", price: "₹55/kg", imageIndex: 8),
        Fruit(title: "Strawberry", price: "₹200/kg", imageIndex: 9),
        Fruit(title: "Blueberry", price: "₹350/kg", imageIndex: 10),
        Fruit(title: "Kiwi", price: "₹180/kg", imageIndex: 11),
        Fruit(title: "Pomegranate", price: "₹140/kg", imageIndex: 12),
        Fruit(title: "Dragon Fruit", price: "₹220/kg", imageIndex: 13),
        Fruit(title: "Lychee", price: "₹160/kg", imageIndex: 14),
        Fruit(title: "Peach", price: "₹130/kg", imageIndex: 15),
        Fruit(title: "Pear", price: "₹110/kg", imageIndex: 16),
        Fruit(title: "Plum", price: "₹125/kg", imageIndex: 17),
        Fruit(title: "Cherry", price: "₹300/kg", imageIndex: 18),
        Fruit(title: "Custard Apple", price: "₹90/kg", imageIndex: 19)
    ]

    let fruitURL: [URL] = [
            URL(string: "https://cdn.pixabay.com/photo/2016/09/29/08/33/apple-1702316_1280.jpg")!,
            URL(string: "https://img.freepik.com/free-vector/vector-ripe-yellow-banana-bunch-isolated-white-background_1284-45456.jpg?semt=ais_hybrid&w=740&q=80")!,
            URL(string:"https://img.freepik.com/free-photo/fresh-orange-isolated-white-background_93675-131671.jpg")!,
            URL(string:"https://i.pinimg.com/474x/6d/c0/13/6dc0138f240932023a22f1b4828ed0fd.jpg")!,
            URL(string:"https://www.shutterstock.com/image-photo/red-grapes-hanging-on-vine-600nw-2475929273.jpg")!,
            URL(string:"https://i.pinimg.com/474x/ca/e0/88/cae0888867e43b432a5e8ffe033a234d.jpg")!,
            URL(string:"https://t3.ftcdn.net/jpg/01/77/22/44/360_F_177224431_6S50Gr64wFWjkDHBGXq7PkaG5kcrgEgd.jpg")!,
            URL(string:"https://img.freepik.com/free-photo/green-striped-ripe-watermelon-with-slice-cross-section-isolated-white-background-with-copy-space-text-images-special-kind-berry-sweet-pink-flesh-with-black-seeds-side-view_639032-1254.jpg?semt=ais_hybrid&w=740&q=80")!,
            URL(string:"https://i.pinimg.com/736x/0c/7e/dc/0c7edcc7c166411876163bd3e75d8b3b.jpg")!,
            URL(string:"https://img.freepik.com/free-photo/strawberry-isolated-white-background_1232-1974.jpg?semt=ais_hybrid&w=740&q=80")!,
            URL(string:"https://img.freepik.com/free-vector/fresh-blueberries-with-water-drops-green-leaves-white-background-realistic-vector-illustration_1284-77363.jpg?semt=ais_hybrid&w=740&q=80")!,
            URL(string:"https://cdn.britannica.com/45/126445-050-4C0FA9F6/Kiwi-fruit.jpg")!,
            URL(string:"https://img.freepik.com/free-vector/pomegranate-realistic-concept-with-organic-food-symbols-vector-illustration_1284-75800.jpg?semt=ais_hybrid&w=740&q=80")!,
            URL(string:"https://images.unsplash.com/photo-1698546690393-45482eb06942?fm=jpg&q=60&w=3000&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8ZHJhZ29uJTIwZnJ1aXR8ZW58MHx8MHx8fDA%3D")!,
            URL(string:"https://cdn.britannica.com/18/176518-050-5AB1E61D/lychee-fruits-Southeast-Asia.jpg")!,
            URL(string:"https://img.freepik.com/premium-photo/peach-fruit-isolated_809796-9569.jpg?semt=ais_hybrid&w=740&q=80")!,
            URL(string:"https://img.freepik.com/free-vector/vintage-pear-illustration_53876-112720.jpg")!,
            URL(string:"https://media.istockphoto.com/id/687478414/photo/red-cherry-plum-with-green-leaves-isolated-on-white-background.jpg?s=612x612&w=0&k=20&c=vje7nFHGnWl-cHDA8wP_UZHryRT5LkAFwn7_8qKtiyc=")!,
            URL(string:"https://www.shutterstock.com/image-vector/two-cherries-isolated-on-white-600nw-2425033511.jpg")!,
            URL(string:"https://cdn.britannica.com/95/126995-050-101B8B8D/Sweetsop.jpg")!
        ]

    var imageCache: [Int: UIImage] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        tableView.delegate = self
        tableView.prefetchDataSource = self

        view.addSubview(tableView)
        tableView.frame = view.bounds
        title = "Fruits"
        configureDataSource()
        applyInitialSnapshot()
    }
}

// DataSource

extension HomeViewController {

    func configureDataSource() {

        dataSource = UITableViewDiffableDataSource<Section, Item>(
            tableView: tableView
        ) { tableView, indexPath, item in

            switch item {

            case .fruit(let fruit):

                let cell = tableView.dequeueReusableCell(withIdentifier: "FruitCell",for: indexPath) as! FruitCell
                cell.configure(with: fruit)
                let index = fruit.imageIndex

                if let image = self.imageCache[index] {
                    cell.setImage(image)
                } else {
                    cell.setImage(nil)

                    Task { [weak self] in
                        await self?.fetchImage(for: index)
                        DispatchQueue.main.async {
                            if let updatedCell = tableView.cellForRow(at: indexPath) as? FruitCell {
                                updatedCell.setImage(self?.imageCache[index])
                            }
                        }
                    }
                }

                return cell

            case .price(let fruit):

                let cell = UITableViewCell()
                cell.textLabel?.text = "Price: \(fruit.price)"
                cell.textLabel?.textColor = .gray
                return cell
            }
        }
    }
}

//Snapshot

extension HomeViewController {

    func applyInitialSnapshot() {

        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        let items = fruits.map { Item.fruit($0) }
        snapshot.appendItems(items)
        dataSource.apply(snapshot, animatingDifferences: false)
    }

    func updateDataSource(_ indexPath: IndexPath) {

        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        var snapshot = dataSource.snapshot()

        switch item {

        case .fruit(let fruit):
            
            let index = fruit.imageIndex
            fruits[index].isExpanded.toggle()
            let updatedFruit = fruits[index]
            let newItem = Item.fruit(updatedFruit)
            snapshot.insertItems([newItem], beforeItem: item)
            snapshot.deleteItems([item])
            let priceItem = Item.price(updatedFruit)
            if updatedFruit.isExpanded {
                snapshot.insertItems([priceItem], afterItem: newItem)
            }
            else {
                snapshot.deleteItems([Item.price(fruit)])
            }
        case .price:
            return
        }

        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

// Delegate

extension HomeViewController {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        updateDataSource(indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//Prefetch

extension HomeViewController {

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {

        for indexPath in indexPaths {

            guard let item = dataSource.itemIdentifier(for: indexPath),
                  case .fruit(let fruit) = item else { continue }

            Task {
                await fetchImage(for: fruit.imageIndex)
            }
        }
    }
}

// Fetch Image

extension HomeViewController {

    func fetchImage(for index: Int) async {

        if imageCache[index] != nil { return }
        let url = fruitURL[index]

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            imageCache[index] = UIImage(data: data)
        } catch {
            print(error)
        }
    }
}
