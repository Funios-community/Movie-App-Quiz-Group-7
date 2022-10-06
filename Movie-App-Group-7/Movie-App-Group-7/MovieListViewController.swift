//
//  Movielist.swift
//  Movie-App-Group-7
//
//  Created by Mac Pro on 26/08/22.
//

import UIKit

class MovieListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    
    var movieList: [APIGhibli] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        getMovieList()
    }
    
    func getMovieList() {
        let url = URL(string: "https://ghibliapi.herokuapp.com/films")!
     
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                let decoder = JSONDecoder()
                let movies = try decoder.decode([APIGhibli].self, from: data!)
                
                self.bindData(with: movies)
                
            } catch {
                print("Error \(error)")
            }
        }.resume()
    }
    
    func bindData(with movies: [APIGhibli]) {
        DispatchQueue.main.async {
            self.movieList = movies
            self.tableView.reloadData()
        }
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MovieTableCell", bundle: nil), forCellReuseIdentifier: "movieList")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movieList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieList", for: indexPath) as! MovieTableCell
        
        cell.bindData(with: movieList[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        routeToDetailMovie(with: movieList[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as! MovieTableCell
        cell.downloadImage()
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as! MovieTableCell
        cell.cancelDownloadRemoveImage()
    }
    
    func routeToDetailMovie(with movie: APIGhibli) {
        let detailVC = DetailViewController (nibName: "DetailViewController", bundle: nil)
        detailVC.id = movie.id
        self.navigationController?.show(detailVC, sender: self)
        print(movie.id)
    }
}


//    override func viewDidLoad() {
//        super.viewDidLoad()
//        tableView.delegate = self
//        tableView.dataSource = self
//        self.tableView.register(UINib(nibName: "MovieTableCell", bundle: nil), forCellReuseIdentifier: "movieList")
//}
//        let movielist: [Movie] =
//
//        [
//            Movie(id: UUID(),
//                  title: "Kiki's Delivery Service",
//                  orginalTitle: "魔女の宅急便 (Majo no takkyūbin)",
//                  description: "A young witch, on her mandatory year of independent life, finds fitting into a new community difficult while she supports herself by running an air courier service",
//                  movieBanner: UIImage(named: "kikisDeliveryService")!,
//                  moviePoster: UIImage(named: "bannerKiki")!,
//                  director: "Hayao Miyazaki",
//                  duration: 120,
//                  releaseDate: "1989"),
//            Movie(id: UUID(),
//                  title: "Castle in the Sky",
//                  orginalTitle: "天空の城ラピュタ (Tenkū no shiro Rapyuta)",
//                  description: "The orphan Sheeta inherited a mysterious crystal that links her to the mythical sky-kingdom of Laputa. With the help of resourceful Pazu and a rollicking band of sky pirates, she makes her way to the ruins of the once-great civilization. Sheeta and Pazu must outwit the evil Muska, who plans to use Laputa's science to make himself ruler of the world",
//                  movieBanner: UIImage(named: "castleInTheSky")!,
//                  moviePoster: UIImage(named: "bannerCastel")!,
//                  director: "Hayao Miyazaki",
//                  duration: 120,
//                  releaseDate: "1986"),
//            Movie(id: UUID(),
//                  title: "Grave of the Fireflies",
//                  orginalTitle: "火垂るの墓 (Hotaru no haka)",
//                  description: "In the latter part of World War II, a boy and his sister, orphaned when their mother is killed in the firebombing of Tokyo, are left to survive on their own in what remains of civilian life in Japan. The plot follows this boy and his sister as they do their best to survive in the Japanese countryside, battling hunger, prejudice, and pride in their own quiet, personal battle",
//                  movieBanner: UIImage(named: "graveOfTheFireFlies")!,
//                  moviePoster: UIImage(named: "bannerGrave")!,
//                  director: "Isao Takahata",
//                  duration: 120,
//                  releaseDate: "1988"),
//            Movie(id: UUID(),
//                  title: "My Neighbor Totoro",
//                  orginalTitle: "となりのトトロ (Tonari no Totoro)",
//                  description: "Two sisters move to the country with their father in order to be closer to their hospitalized mother, and discover the surrounding trees are inhabited by Totoros, magical spirits of the forest. When the youngest runs away from home, the older sister seeks help from the spirits to find her",
//                  movieBanner: UIImage(named: "myNeighborTotoro")!,
//                  moviePoster: UIImage(named: "bannerTotoro")!,
//                  director: "Hayao Miyazaki",
//                  duration: 120,
//                  releaseDate: "1988"),
//            Movie(id: UUID(),
//                  title: "Only Yesterday",
//                  orginalTitle: "おもひでぽろぽろ (Omoide poro poro)",
//                  description: "It’s 1982, and Taeko is 27 years old, unmarried, and has lived her whole life in Tokyo. She decides to visit her family in the countryside, and as the train travels through the night, memories flood back of her younger years: the first immature stirrings of romance, the onset of puberty, and the frustrations of math and boys. At the station she is met by young farmer Toshio, and the encounters with him begin to reconnect her to forgotten longings. In lyrical switches between the present and the past, Taeko contemplates the arc of her life, and wonders if she has been true to the dreams of her childhood self",
//                  movieBanner: UIImage(named: "makingOf")!,
//                  moviePoster: UIImage(named: "bannerMakingOf")!,
//                  director: "Isao Takahata",
//                  duration: 120,
//                  releaseDate: "1991")
//        ]
//   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell = tableView .dequeueReusableCell(withIdentifier: "movieList", for: indexPath) as! MovieTableCell
//
//        let movie = movielist[indexPath.row]
//
//        cell.ImageMovie.image = movie.movieBanner
//        cell.labelHeading.text = movie.title
//        cell.labelHead2.text = movie.orginalTitle
//        cell.labelHead3.text = movie.description
//
//        return cell
//}
//   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return movielist.count
//    }
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        let detail = DetailViewController(nibName: "DetailViewController", bundle: nil)
//        detail.movie = movielist [indexPath.row]
//        self.show(detail, sender: self)
//    }
//
//
//}
