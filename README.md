<details>
<summary>Tugas 8</summary>

#### Flutter Navigation, Layouts, Forms, and Input Elements
**Jelaskan perbedaan antara Navigator.push() dan Navigator.pushReplacement(), disertai dengan contoh**  
`Navigator.push()` digunakan untuk menambahkan layar baru ke tumpukan navigasi. Ketika  menggunakan `Navigator.push()`, program menambahkan suatu route ke dalam stack route yang dikelola oleh Navigator. Method ini menyebabkan route yang ditambahkan berada pada paling atas stack, sehingga route yang baru saja ditambahkan tersebut akan muncul dan ditampilkan kepada pengguna dan juga layar sebelumnya masih ada di tumpukan dan dapat ditemukan saat Anda menekan tombol "back" atau menggunakan metode `Navigator.pop()`. Sedangkan, jika menggunakan method `pushReplacement()`, maka program akan menghapus route yang sedang ditampilkan kepada pengguna dan menggantinya dengan suatu route. Method ini menyebabkan aplikasi untuk berpindah dari route yang sedang ditampilkan kepada pengguna ke suatu route yang diberikan. Pada stack route yang dikelola Navigator, route lama pada atas stack akan digantikan secara langsung oleh route baru yang diberikan tanpa mengubah kondisi elemen stack yang berada di bawahnya.

**Jelaskan masing-masing layout widget pada Flutter dan konteks penggunaannya**
*   Drawer: widget yang digunakan untuk membuat drawer di sebelah kiri.
*   Form: widget yang digunakan untuk mengelola formulir dan validasi input.
*   TextFormField:  widget yang digunakan untuk menerima input teks dari user.
*   AlertDialog: widget berupa pop-up message yang digunakan untuk menampilkan pesan setelah item tersimpan.
*   GlobalKey<FormState>: Kunci global untuk mengidentifikasi dan mengakses status formulir
*   Stack : widget yang digunakan untuk menempatkan widgets secara bertumpuk.    
*   Column :  widget untuk menyusun widget secara vertikal.

**Elemen input pada form**  
Pada tugas ini, saya menggunakan widget `TextFormField` untuk meminta input dari user. Selain itu, widget ini juga dapat membantu menangani validasi data (Mengatasi data kosong atau data tidak valid).  
Elemen yang digunakan menggunakan widget form tersebut, antara lain: 
*   Nama, untuk menerima input barang dari user.
*   Jumlah, untuk menerima jumlah barang user.
*   Deskripsi, untuk menerima deskripsi barang dari user.

**Penerapan clean architecture pada aplikasi Flutter**  
Clean Architecture adalah metode untuk membuat sebuah app dengan mengatur kode ke dalam berbagai lapisan/bagian yang jelas. Terdapat tiga lapisan utama pada penggunaan Clean Architecture pada Flutter, yaitu: Domain Layer, Data Layer, dan Presentation Layer.
*   Domain Layer: mengatur logika untuk mengatur bagaimana elemen dalam aplikasi berinteraksi.
*   Data Layer:  mengatur data dari berbagai sumber seperti API, database, file lokal, dll.
*   Presentation Layer: bertanggung jawab atas UI (User Interface) dan interaksi pengguna. Layer ini juga mengandung komponen-komponen User Interface seperti widgets, screens, dan views.

**Cara mengimplementasikan checklist secara step-by-step**
*   Membuat minimal satu halaman formulir tambah item baru pada aplikasi 
    -   Membuat file baru pada direktori `lib` dengan nama inventorylist_form.dart
        ```ruby
        import 'package:flutter/material.dart';
        import 'package:my_inventory/widgets/left_drawer.dart';

        class InventoryFormPage extends StatefulWidget {
            const InventoryFormPage({super.key});

            @override
            State<InventoryFormPage> createState() => _InventoryFormPageState();
        }

        class _InventoryFormPageState extends State<InventoryFormPage> {
        final _formKey = GlobalKey<FormState>();
        String _name = "";
        int _amount = 0;
        String _description = "";
            @override
            Widget build(BuildContext context) {
                return Scaffold(
                ...
                )
            }
        }
        ```
    -   Pada build widget, tambahkan widget `Form` untuk menerima input dari user
        ```ruby
        body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...
                ]
              )
            ),
        ),
        ```
*   Memakai minimal tiga elemen input, yaitu name, amount, description. 
    -   Pada Form, tambahkan tiga widget `TextFormField` untuk menerima input
        ```ruby
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
                decoration: InputDecoration(
                hintText: "Nama Item",
                labelText: "Nama Item",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                ),
                ),
                onChanged: (String? value) {
                setState(() {
                    _name = value!;
                });
                },
                ...
            ),
        ),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
                decoration: InputDecoration(
                hintText: "Jumlah",
                labelText: "Jumlah",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                ),
                ),
                onChanged: (String? value) {
                setState(() {
                    _amount = int.parse(value!);
                });
                },
                ...
            ),
        ),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
                decoration: InputDecoration(
                hintText: "Deskripsi",
                labelText: "Deskripsi",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                ),
                ),
                onChanged: (String? value) {
                setState(() {
                    _description = value!;
                });
                },
                ...
            ),
        )
        ```
*   Memiliki sebuah tombol Save
    -   Menambahkan tombol `Save` pada `Form`
        ```ruby
        Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.lightGreen.shade900),
                ),
                onPressed: () {
                    ...
                },
                child: const Text(
                    "Save",
                    style: TextStyle(color: Colors.white),
                ),
                ),  
            ),
        ),
        ```
*   Menggunakan validasi input
    -   Pada setiap widget `TextFormField` ditambahkan validasi input makai `validator`
        contoh pada input deskripsi:
        ```ruby
        validator: (String? value) {
                if (value == null || value.isEmpty) {
                    return "Jumlah tidak boleh kosong!";
                }
                if (int.tryParse(value) == null) {
                    return "Jumlah harus berupa angka!";
                }
                return null;
        },
        ```
*   Mengarahkan pengguna ke halaman form tambah item baru ketika menekan tombol Tambah Item pada halaman utama.
    -   Tambahkan fitur navigasi pada tombol `Tambah Item`
        ```ruby
        // Navigate ke route yang sesuai (tergantung jenis tombol)
        if (item.name == "Tambah Item") {
        Navigator.push(context,
        MaterialPageRoute(builder: (context) => const InventoryFormPage()));
        }
        ```
*   Memunculkan data sesuai isi dari formulir yang diisi dalam sebuah pop-up setelah menekan tombol Save pada halaman formulir tambah item baru.
    -   Pada tombol `Save` yang terletak pada `Form`, tambahkan `OnPressed` yang akan memunculkan widget `AlertDialog`
        ```ruby
        onPressed: () {
            if (_formKey.currentState!.validate()) {
            showDialog(
                context: context,
                builder: (context) {
                return AlertDialog(
                    title: const Text('Produk berhasil tersimpan'),
                    content: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                        Text('Nama: $_name'), //menampilkan isi dari input user
                        Text('Jumlah: $_amount'),
                        Text('Deskripsi: $_description'),
                        ],
                    ),
                    ),
                    actions: [
                    TextButton(
                        child: const Text('OK'),
                        onPressed: () {
                        Navigator.pop(context);
                        },
                    ),
                    ],
                );
                },
            );
            _formKey.currentState!.reset();
            }
        },
        ```
*   Membuat sebuah drawer pada aplikasi
    -   Membuat file baru di dalam direktori baru `widgets`dengan nama `left_drawer.dart`.
        ```ruby
        import 'package:flutter/material.dart';
        import 'package:flutter/material.dart';
        import 'package:my_inventory/menu.dart';
        import 'package:my_inventory/inventorylist_form.dart';

        class LeftDrawer extends StatelessWidget {
        const LeftDrawer({super.key});

        @override
        Widget build(BuildContext context) {
            return Drawer(
            ...
            )
        }
        ```
*   Menambahkan dua buah opsi pada Drawer, yaitu Halaman Utama dan Tambah Item
    -   Menambahkan dua widget `ListTile` pada build Widget LeftDrawer, 
        ```ruby
        ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Halaman Utama'),
            ...
          ),
          ListTile(
            leading: const Icon(Icons.add_shopping_cart),
            title: const Text('Tambah Produk'),
            ...
        ),
        ```
*   Lakukan Routing sehingga ketika memiih opsi Halaman Utama, maka aplikasi akan mengarahkan pengguna ke halaman utama dan ketika memiih opsi (Tambah Item), maka aplikasi akan mengarahkan pengguna ke halaman form tambah item baru.
    -   Menambahkan `Navigator` pada setiap `ListTile` jika di klik(menggunakan `OnTap`)
        Pada teks `Tambah Produk`
        ```ruby
        ListTile(
            ...
            // Bagian redirection ke MyHomePage
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(),
                  ));
            },
        ),
        ``` 
        Pada teks `Halaman Utama`
        ```ruby
        ListTile(
            ...
            // Bagian redirection ke InventoryFormPage
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InventoryFormPage(),
                  ));
            },
          ),
        ```
    
</details>



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
*   Column :  widget untuk menyusun widget secara vertikal.
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
