//
//  Movie.swift
//  Movie-App-Group-7
//
//  Created by Nadia Darin on 23/08/22.
//

import Foundation
import UIKit

struct Movie {
    let id: UUID
    let title: String
    let orginalTitle: String
    let description: String
    let movieBanner: UIImage
    let moviePoster: UIImage
    let director: String
    let duration: Int
    let releaseDate: String
    
    var formattedDuration: String {
        "\(duration / 60)h \(duration % 60)s"
    }
    
}

class DummyData {
    
   static func fakeMovies() -> [Movie] {
        [
            Movie(id: UUID(), title: "Castle in the Sky", orginalTitle: "天空の城ラピュタ (Tenkū no shiro Rapyuta)", description: "The orphan Sheeta inherited a mysterious crystal that links her to the mythical sky-kingdom of Laputa. With the help of resourceful Pazu and a rollicking band of sky pirates, she makes her way to the ruins of the once-great civilization. Sheeta and Pazu must outwit the evil Muska, who plans to use Laputa's science to make himself ruler of the world.", movieBanner: UIImage(named: "castle_in_the_sky_banner")!, moviePoster: UIImage(named: "castle_in_the_sky_image")!, director: "Hayao Miyazaki", duration: 124, releaseDate: "1986"),
            Movie(id: UUID(), title: "Grave of the Fireflies", orginalTitle: "火垂るの墓 (火垂るの墓)", description: "In the latter part of World War II, a boy and his sister, orphaned when their mother is killed in the firebombing of Tokyo, are left to survive on their own in what remains of civilian life in Japan. The plot follows this boy and his sister as they do their best to survive in the Japanese countryside, battling hunger, prejudice, and pride in their own quiet, personal battle.", movieBanner: UIImage(named: "grave_of_the_fireflies_banner")!, moviePoster: UIImage(named: "grave_of_the_fireflies_image")!, director: "Isao Takahata", duration: 89, releaseDate: "1988"),
            Movie(id: UUID(), title: "My Neighbor Totoro", orginalTitle: "となりのトトロ (Tonari no Totoro)", description: "Two sisters move to the country with their father in order to be closer to their hospitalized mother, and discover the surrounding trees are inhabited by Totoros, magical spirits of the forest. When the youngest runs away from home, the older sister seeks help from the spirits to find her.", movieBanner: UIImage(named: "my_neighbor_totoro_banner")!, moviePoster: UIImage(named: "my_neighbor_totoro_image")!, director: "Hayao Miyazaki", duration: 86, releaseDate: "1988"),
            Movie(id: UUID(), title: "Kiki's Delivery Service", orginalTitle: "魔女の宅急便 (Majo no takkyūbin)", description: "A young witch, on her mandatory year of independent life, finds fitting into a new community difficult while she supports herself by running an air courier service.", movieBanner: UIImage(named: "kikis_delivery_service_banner")!, moviePoster: UIImage(named: "kikis_delivery_service_image")!, director: "Hayao Miyazaki", duration: 102, releaseDate: "1989"),
            Movie(id: UUID(), title: "Only Yesterday", orginalTitle: "おもひでぽろぽろ (Omoide poro poro)", description: "It’s 1982, and Taeko is 27 years old, unmarried, and has lived her whole life in Tokyo. She decides to visit her family in the countryside, and as the train travels through the night, memories flood back of her younger years: the first immature stirrings of romance, the onset of puberty, and the frustrations of math and boys. At the station she is met by young farmer Toshio, and the encounters with him begin to reconnect her to forgotten longings. In lyrical switches between the present and the past, Taeko contemplates the arc of her life, and wonders if she has been true to the dreams of her childhood self.", movieBanner: UIImage(named: "only_yesterday_banner")!, moviePoster: UIImage(named: "only_yesterday_image")!, director: "Isao Takahata", duration: 118, releaseDate: "1991")

        ]
    }
    
}


