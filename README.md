<details>
<summary>Tugas 7</summary>

#### Elemen Dasar Flutter 
**Perbedaan utama antara stateless dan stateful widget dalam konteks pengembangan aplikasi Flutter**  
*   **Stateless widget** adalah widget yang statis / tidak berubah setelah widget dibuat. Dalam konteks stateless widget, widget ini tidak memiliki keadaan internal yang dapat berubah. Mereka hanya mengambil data yang diberikan melalui constructor dan menampilkan tampilan berdasarkan data tersebut. Sebagai contoh, widget seperti Text atau Icon biasanya bersifat stateless. Berbeda dengan stateful widget, **stateful widget** merupakan widget yang dinamis dan tampilan dari widget dapat berubah tergantung oleh respons terhadap event yang diberikan oleh pengguna atau saat menerima data. Beberapa contoh dari stateful widget adalah Checkbox, Radio, Slider, InkWell, Form, dan TextField  
  
**Sebutkan seluruh widget yang kamu gunakan untuk menyelesaikan tugas ini dan jelaskan fungsinya masing-masing.**
*   MyHomePage: widget untuk menampilkan halaman utama. Widget ini berisi komponen-komponen yang membentuk tampilan beranda aplikasi.
*   InventoryCard : widget untuk menampilkan/menampung setiap item card (tombol).  
*   Scaffold: Widget yang menyediakan struktur dasar untuk tampilan utama aplikasi, seperti AppBar, SnackBar, body, dll.
*   AppBar : widget berupa bar di bagian atas yang biasanya menampilkan judul aplikasi
*   SingleChildScrollView : idget untuk mengaplikasikan scroll pada konten yang melebihi ruang layar.
*   Padding : widget yang memberikan jarak/padding
*   Column :  widget untuk menyusun list dari `children` secara vertikal.
*   GridView :  widget yang dapat menyusun `children` dalam bentuk grid.
*   Material : widget yang memberikan efek visual Material Design, seperti InkWell
*   InkWell : widget yang merespon pada event `onTap` sehingga memberikan efek visual seperti gelombang tinta. 
*   SnackBar : widget untuk menampilkan elemen sementara di bagian bawah layar berupa *feedback* atau pesan kepada pengguna.
*   Text: widget untuk menampilkan teks
*   Icon: widget untuk wenampilkan ikon grafis.

**Cara mengimplementasikan checklist secara step-by-step**
*   Membuat sebuah program Flutter baru
    -   Membuat proyek Flutter baru dengan nama my_inventory dengan menjalakan kode berikut:
        ```ruby
        flutter create my_inventory
        ```
    -   Membuat file baru bernama `menu.dart` pada direktori `my_inventory/lib`
    -   Mengimport library yang dibutuhkan, seperti Material Design library
        ```ruby
        import 'package:flutter/material.dart';
        ```
    -   Membuat stateless widget berupa MyHomePage untuk menampilkan halaman utama
        ```ruby
        class MyHomePage extends StatelessWidget {
        MyHomePage({Key? key}) : super(key: key);
        ...
        }
        ```
    -   Mengimport `menu.dart` ke `main.dart` agar dapat menampilkan `MyHomePage()` saat aplikasi dijalankan
    -   Pada class MyHomePage di `menu.dart`, buat widget build untuk menampilkan UI pada layar. 
        ```ruby
        @override
        Widget build(BuildContext context) {
            return Scaffold(
            appBar: AppBar(
                title: const Text(
                'My Inventory',
                ),
                backgroundColor: Colors.grey,
            ),
            body: SingleChildScrollView(
                // Widget wrapper yang dapat discroll
                child: Padding(
                padding: const EdgeInsets.all(10.0), // Set padding dari halaman
                child: Column(
                    // Widget untuk menampilkan children secara vertikal
                    children: <Widget>[
                    const Padding(
                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        // Widget Text untuk menampilkan tulisan dengan alignment center dan style yang sesuai
                        child: Text(
                        'My Inventory', // Text yang menandakan toko
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                        ),
                        ),
                    ),
                    // Grid layout
                    GridView.count(
                        // Container pada card kita.
                        primary: true,
                        padding: const EdgeInsets.all(20),
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        crossAxisCount: 3,
                        shrinkWrap: true,
                        children: items.map((InventoryItem item) {
                        // Iterasi untuk setiap item
                        return InventoryCard(item);
                        }).toList(),
                    ),
                    ],
                ),
                ),
            ),
            );
        }
        ```
*   Membuat tiga tombol sederhana dengan ikon dan teks untuk: Melihat daftar item (Lihat Item), Menambah item (Tambah Item), Logout (Logout)  
    -   Membuat class untuk tombol.  
        Class tersebut mempunyai atribut untuk menampung ikon dan teks pada tombol 
        ```ruby
        class InventoryItem {
        final String name;
        final IconData icon;
        final Color color;

        InventoryItem(this.name, this.icon, this.color);
        }
        ```
        
    -   Membuat tombol
        ```ruby
        final List<InventoryItem> items = [
            InventoryItem("Lihat Item", Icons.checklist, Colors.lightGreen.shade900),
            InventoryItem("Tambah Item", Icons.add_shopping_cart, Colors.lightGreen.shade800),
            InventoryItem("Logout", Icons.logout, Colors.lightGreen.shade700),
        ];
        ```
    -   Memunculkan tombol pada tampilan layar dengan menggunakan GridView pada Widget build di MyHomePage dan menghubungkan dengan widget InventoryCard
        ```ruby
        GridView.count(
            // Container pada card kita.
            ...
            children: items.map((InventoryItem item) {
            // Iterasi untuk setiap item
            return InventoryCard(item);
            }).toList(),
        ),
        ```
*   Memunculkan Snackbar dengan tulisan: "Kamu telah menekan tombol Lihat Item" ketika tombol Lihat Item ditekan., "Kamu telah menekan tombol Tambah Item" ketika tombol Tambah Item ditekan., "Kamu telah menekan tombol Logout" ketika tombol Logout ditekan.
    -   Membuat stateless widget InventoryCard sebagai struktur dari button InventoryItem
        ```ruby
        class InventoryCard extends StatelessWidget {
        final InventoryItem item;

        const InventoryCard(this.item, {super.key}); // Constructor

        @override
        Widget build(BuildContext context) {
            return Material(
            color: item.color,
            child: InkWell(
                // Area responsive terhadap sentuhan
                onTap: () {
                // Memunculkan SnackBar ketika diklik
                ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(SnackBar(
                        content: Text("Kamu telah menekan tombol ${item.name}!")));
                },
                child: Container(
                // Container untuk menyimpan Icon dan Text
                padding: const EdgeInsets.all(8),
                child: Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        Icon(
                        item.icon,
                        color: Colors.white,
                        size: 30.0,
                        ),
                        const Padding(padding: EdgeInsets.all(3)),
                        Text(
                        item.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white),
                        ),
                    ],
                    ),
                ),
                ),
            ),
            );
        }
        }
        ```
    -   Menambahkan event onTap dan widget SnackBar pada tombol agar memunculkan tulisan yang diinginkan
        ```ruby
        onTap: () {
        // Memunculkan SnackBar ketika diklik
        ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text("Kamu telah menekan tombol ${item.name}!")));
        },
        ```

</details>