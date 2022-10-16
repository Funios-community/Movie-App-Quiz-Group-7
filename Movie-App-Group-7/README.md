# Movie App Group 7 Quiz

#### Buatlah aplikasi seperti desain berikut: 
![Screen Shot 2022-08-20 at 20 52 40](https://user-images.githubusercontent.com/33575723/185749392-8d5f9936-e408-443c-aa7a-f91c69821f6f.png)

#### Common:
- Gunakan `color` dan `font type` bawaan dari xcode.

#### Login page (Storyboard): 
- Buatlah Login page sesuai dengan desain diatas.
- Pada saat button Sign In diclick lakukan validasi untuk `username` dan `password` yang diinput. bandingkan hasil input dengan kata yang kalian tentukan sendiri.
- Jika input salah atau tidak sesuai dengan kata yang kalian tentukan maka tampilan `Alert` seperti pada design diatas.
- Jika input benar atau sesuai maka pindah layout dengan `segue` ke `TabbarController` yang berisi `Movie List` dan `Profile`
- Pastikan `TextField Password` secure *****.

#### List page (Storyboard dan XiB):
- Buatlah `tableView` dengan tampilan list yang berisi 5 item. (Storyboard) sesuai dengan desain diatas.
- Buatlah `Custom Cell` menggunakan `XiB` sesuai desain (Xib) 
    - `Challenge` buatlah `dynamic cell height size`, yang dimana cell akan menyesuaikan ukuran (height) sesuai isi content (caption/description) 
- List tersebut dapat di `click` dan perpindah kehalaman `detail` dengan `programatically (show(...))`, lalu tampilkan data `detail` pada halaman tersebut.

#### Detail page (XiB): 
- Buatlah Detail page dengan `Xib` sesuai dengan desain diatas.
- Tampilkan `data detail` tersebut sesuai dengan data yang di `click` pada halaman list.
- Pastikan ada `button back` dan `back swipe gesture` dapat berfungsi dengan seharusnya.
- Jangan lupa rubah `running_time/duration` dari `menit` ke bentuk `1h 30m` seperti pada desain.

### Profile page (Storyboard):
- Buatlah profile page dengan storyboard sesuai dengan desain diatas.
- Pada halaman profile ini tampilkan kata-kata `Hello, \(username)`, username didapat dari user input saat login.
- Pada saat `button logout` di `click` kembali ke halaman `login`. 
    - `Challenge`:`JANGAN` gunakan `route programatically(show(...)) atau segue`, tapi gunakan `dismiss`.

# Penjelasan lebih lanjut
![Screen Shot 2022-08-20 at 20 21 02](https://user-images.githubusercontent.com/33575723/185748479-6631ba0c-f5e7-4440-8d67-f2d5859729d6.png)

# DATA
Gunakan `Data Struct` dibawah. 
Lalu buatlah `Dummy List [Movie]` copy paste data dibawah untuk membuat `list`.

## Data Model Struct
```
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
}
```

## Copy paste the data from here and download the image from URL and put it in your project and use it as UIImage(named: "....").
```
[
    {
    "id": "2baf70d1-42bb-4437-b551-e5fed5a87abe",
    "title": "Castle in the Sky",
    "original_title": "天空の城ラピュタ",
    "original_title_romanised": "Tenkū no shiro Rapyuta",
    "image": "https://image.tmdb.org/t/p/w600_and_h900_bestv2/npOnzAbLh6VOIu3naU5QaEcTepo.jpg",
    "movie_banner": "https://image.tmdb.org/t/p/w533_and_h300_bestv2/3cyjYtLWCBE1uvWINHFsFnE8LUK.jpg",
    "description": "The orphan Sheeta inherited a mysterious crystal that links her to the mythical sky-kingdom of Laputa. With the help of resourceful Pazu and a rollicking band of sky pirates, she makes her way to the ruins of the once-great civilization. Sheeta and Pazu must outwit the evil Muska, who plans to use Laputa's science to make himself ruler of the world.",
    "director": "Hayao Miyazaki",
    "producer": "Isao Takahata",
    "release_date": "1986",
    "running_time": "124"
    },
    {
    "id": "12cfb892-aac0-4c5b-94af-521852e46d6a",
    "title": "Grave of the Fireflies",
    "original_title": "火垂るの墓",
    "original_title_romanised": "Hotaru no haka",
    "image": "https://image.tmdb.org/t/p/w600_and_h900_bestv2/qG3RYlIVpTYclR9TYIsy8p7m7AT.jpg",
    "movie_banner": "https://image.tmdb.org/t/p/original/vkZSd0Lp8iCVBGpFH9L7LzLusjS.jpg",
    "description": "In the latter part of World War II, a boy and his sister, orphaned when their mother is killed in the firebombing of Tokyo, are left to survive on their own in what remains of civilian life in Japan. The plot follows this boy and his sister as they do their best to survive in the Japanese countryside, battling hunger, prejudice, and pride in their own quiet, personal battle.",
    "director": "Isao Takahata",
    "producer": "Toru Hara",
    "release_date": "1988",
    "running_time": "89"
    },
    {
    "id": "58611129-2dbc-4a81-a72f-77ddfc1b1b49",
    "title": "My Neighbor Totoro",
    "original_title": "となりのトトロ",
    "original_title_romanised": "Tonari no Totoro",
    "image": "https://image.tmdb.org/t/p/w600_and_h900_bestv2/rtGDOeG9LzoerkDGZF9dnVeLppL.jpg",
    "movie_banner": "https://image.tmdb.org/t/p/original/etqr6fOOCXQOgwrQXaKwenTSuzx.jpg",
    "description": "Two sisters move to the country with their father in order to be closer to their hospitalized mother, and discover the surrounding trees are inhabited by Totoros, magical spirits of the forest. When the youngest runs away from home, the older sister seeks help from the spirits to find her.",
    "director": "Hayao Miyazaki",
    "producer": "Hayao Miyazaki",
    "release_date": "1988",
    "running_time": "86"
    },
    {
    "id": "ea660b10-85c4-4ae3-8a5f-41cea3648e3e",
    "title": "Kiki's Delivery Service",
    "original_title": "魔女の宅急便",
    "original_title_romanised": "Majo no takkyūbin",
    "image": "https://image.tmdb.org/t/p/w600_and_h900_bestv2/7nO5DUMnGUuXrA4r2h6ESOKQRrx.jpg",
    "movie_banner": "https://image.tmdb.org/t/p/original/h5pAEVma835u8xoE60kmLVopLct.jpg",
    "description": "A young witch, on her mandatory year of independent life, finds fitting into a new community difficult while she supports herself by running an air courier service.",
    "director": "Hayao Miyazaki",
    "producer": "Hayao Miyazaki",
    "release_date": "1989",
    "running_time": "102"
    },
    {
    "id": "4e236f34-b981-41c3-8c65-f8c9000b94e7",
    "title": "Only Yesterday",
    "original_title": "おもひでぽろぽろ",
    "original_title_romanised": "Omoide poro poro",
    "image": "https://image.tmdb.org/t/p/w600_and_h900_bestv2/xjJU6rwzLX7Jk8HFQfVW6H5guMC.jpg",
    "movie_banner": "https://image.tmdb.org/t/p/w533_and_h300_bestv2/isCrlWWI4JrdLKAUAwFb5cjAsH4.jpg",
    "description": "It’s 1982, and Taeko is 27 years old, unmarried, and has lived her whole life in Tokyo. She decides to visit her family in the countryside, and as the train travels through the night, memories flood back of her younger years: the first immature stirrings of romance, the onset of puberty, and the frustrations of math and boys. At the station she is met by young farmer Toshio, and the encounters with him begin to reconnect her to forgotten longings. In lyrical switches between the present and the past, Taeko contemplates the arc of her life, and wonders if she has been true to the dreams of her childhood self.",
    "director": "Isao Takahata",
    "producer": "Toshio Suzuki",
    "release_date": "1991",
    "running_time": "118"
    }
]
```


