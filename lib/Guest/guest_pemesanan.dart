import 'package:komas_latihan/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:komas_latihan/utils/client_request.dart';
import 'package:komas_latihan/utils/settings.dart';

class Pesanlt1 {
  Color? tombol;
  String nokamar;
  String nomorlantai;
  int selectedindex;
  String harga;
  int hargabayar;
  bool kondisi = true;
  bool tersedia = true;

  Pesanlt1(
      {required this.nomorlantai,
      this.tombol,
      required this.nokamar,
      required this.selectedindex,
      required this.harga,
      required this.hargabayar,
      required this.tersedia});
}

// class Floors {
//   Color? tombol;
//   String? nokamar;
//   String? nomorlantai;
//   int? selectedindex;
//   String? harga;
//   int? hargabayar;
//   // bool kondisi = true;
//   bool? tersedia;

//   // Floors({required this.nomorlantai, required this.tombol, required this.nokamar,
//   // required this.selectedindex, required this.harga, required this.hargabayar});

//   Floors.fromJson(Map<String, dynamic> json) {
//     nokamar = json["roomNumber"];
//     nomorlantai = json["floorNumber"].toString();
//     hargabayar = int.parse(json["roomPrice"]);
//     harga = json["roomPrice"];
//     tersedia = json["available"] == "Yes" ? true : false;
//     tombol = json["available"] == "Yes" ?const Color.fromRGBO(217, 217, 217, 1) : const Color.fromRGBO(100, 100, 100, 10);
//     selectedindex = int.parse(json["index"]);
//   }
// }
class Floors {
  Color? tombol;
  String? nokamar;
  String? nomorlantai;
  int? selectedindex;
  String? harga;
  int? hargabayar;
  // bool kondisi = true;
  bool? tersedia;

  // Floors({required this.nomorlantai, required this.tombol, required this.nokamar,
  // required this.selectedindex, required this.harga, required this.hargabayar});

  Floors.fromJson(Map<String, dynamic> json) {
    nokamar = json["roomNumber"];
    nomorlantai = json["floorNumber"].toString();
    hargabayar = int.parse(json["roomPrice"]);
    harga = json["roomPrice"];
    tersedia = json["available"] == "Yes" ? true : false;
    tombol = json["available"] == "Yes"
        ? const Color.fromRGBO(217, 217, 217, 1)
        : const Color.fromRGBO(50, 50, 50, 10);
    selectedindex = json["index"];
  }
}

// ignore: must_be_immutable
class PemesananGuest extends StatefulWidget {
  PemesananGuest({super.key, required this.lantai, required this.admin});
  bool lantai;
  bool admin;

  @override
  State<PemesananGuest> createState() => _PemesananGuestState();
}

class _PemesananGuestState extends State<PemesananGuest> {
  int outindex = 0;
  bool outbool = true;

  bool keranjang = true;

  double tinggi = 25;
  double lebar = 50;

  // Future<List<Floors>>? futureFloors;
  // Future<List<Floors>> getFutureFloors(String url) async {
  //   List<Floors> floors = [];
  //   final response = await ClientRequest.getAll(url);

  //   int index = 0;
  //   response.forEach((value) {
  //     floors.add(Floors.fromJson(<String, dynamic>{
  //       "roomNumber": value["roomNumber"],
  //       "floorNumber": value["floorNumber"],
  //       "roomPrice": value["roomPrice"],
  //       "available": value["available"],
  //       "index": index
  //     }));
  //     index += 1;
  //   });

  //   return floors;
  // }

  static List<Pesanlt1> floors = [];
  List<Pesanlt1> pesanlt1 = createFloor(20);
  static List<Pesanlt1> createFloor(int flrqty) {
    for (int i = 0; i < flrqty; i++) {
      if (i > 9) {
        floors.add(
          Pesanlt1(
              nokamar: (i + 1).toString(),
              nomorlantai: "2",
              selectedindex: i,
              harga: "800.000 / Bulan",
              hargabayar: 800000,
              tersedia: true),
        );
      } else {
        floors.add(
          Pesanlt1(
              // tombol: const Color.fromRGBO(217, 217, 217, 1),
              nokamar: '0' + (i + 1).toString(),
              nomorlantai: "1",
              selectedindex: i,
              harga: "800.000 / Bulan",
              hargabayar: 800000,
              tersedia: true),
        );
      }
    }
    return floors;
  }

  Future<List<Floors>>? futureFloors;
  Future<List<Floors>> getFutureFloors(String url) async {
    List<Floors> floors = [];
    final response = await ClientRequest.getAll(url);

    int index = 0;
    response.forEach((value) {
      floors.add(Floors.fromJson(<String, dynamic>{
        "roomNumber": value["roomNumber"],
        "floorNumber": value["floorNumber"],
        "roomPrice": value["roomPrice"],
        "available": value["available"],
        "index": index
      }));
      index += 1;
    });

    return floors;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFutureFloors(MySettings.getUrl() + ("rooms")).then((value) {
      int index = 0;
      if (value.length <= pesanlt1.length) {
        value.forEach((v) {
          setState(() {
            if (v.tersedia == true) {
              // pesanlt1[index].tombol = notap;
              pesanlt1[index].tersedia = v.tersedia!;
            } else {
              // pesanlt1[index].tombol = tap;
              pesanlt1[index].tersedia = v.tersedia!;
            }
          });
          index += 1;
        });
      } else {
        value.forEach((v) {
          // pesanlt1[index]
          floors[index].tombol = v.tombol!;
          index += 1;
        });
      }
    });
  }

  Color warna1 = Colors.brown.shade200;
  Color warna2 = Colors.brown;

  @override
  Widget build(BuildContext context) {
    return widget.lantai
        ? SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.admin
                        ? const Text(
                            'Fasilitas',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Fasilitas',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: const Icon(
                                  Icons.edit,
                                  color: Colors.black,
                                  size: 14,
                                ),
                              )
                            ],
                          ),
                    const SizedBox(
                      height: 5,
                    ),
                    fasilitas('Kamar Mandi Dalam'),
                    fasilitas('Tempat Tidur'),
                    fasilitas('Lemari'),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Nomor Kamar',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        kamar(pesanlt1[0].selectedindex),
                        kamar(pesanlt1[1].selectedindex),
                        kamar(pesanlt1[2].selectedindex),
                        kamar(pesanlt1[3].selectedindex),
                        kamar(pesanlt1[4].selectedindex),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        kamar(pesanlt1[5].selectedindex),
                        kamar(pesanlt1[6].selectedindex),
                        kamar(pesanlt1[7].selectedindex),
                        kamar(pesanlt1[8].selectedindex),
                        kamar(pesanlt1[9].selectedindex),
                      ],
                    ),
                    // HARGA DAN TAB PEMBAYARAN
                    const SizedBox(
                      height: 30,
                    ),

                    hargakamar(outindex),
                  ]),
            ),
          )
        : SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.admin
                        ? const Text(
                            'Fasilitas',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Fasilitas',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: const Icon(
                                  Icons.edit,
                                  color: Colors.black,
                                  size: 14,
                                ),
                              )
                            ],
                          ),
                    const SizedBox(
                      height: 5,
                    ),
                    fasilitas('Kamar Mandi Dalam'),
                    fasilitas('Tempat Tidur'),
                    fasilitas('Lemari'),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Nomor Kamar',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        kamar(pesanlt1[10].selectedindex),
                        kamar(pesanlt1[11].selectedindex),
                        kamar(pesanlt1[12].selectedindex),
                        kamar(pesanlt1[13].selectedindex),
                        kamar(pesanlt1[14].selectedindex),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        kamar(pesanlt1[15].selectedindex),
                        kamar(pesanlt1[16].selectedindex),
                        kamar(pesanlt1[17].selectedindex),
                        kamar(pesanlt1[18].selectedindex),
                        kamar(pesanlt1[19].selectedindex),
                      ],
                    ),
                    // HARGA DAN TAB PEMBAYARAN
                    const SizedBox(
                      height: 30,
                    ),

                    hargakamar(outindex),
                  ]),
            ),
          );
  }

  Widget kamar(int index) {
    // List<Floors> floors = [];
    // futureFloors!.then((value){
    //   floors = value;
    //   return value;
    // });
    return InkWell(
      onTap: () {
        if (pesanlt1[index].tersedia) {
          setState(() {
            outindex = pesanlt1[index].selectedindex;
            outbool = false;
          });
        }
        // pesanlt1[index].kondisi || !pesanlt1[index].tersedia
        //     ? setState(() {
        //         pesanlt1[index].tombol = const Color.fromRGBO(101, 101, 101, 1);
        //         outindex = pesanlt1[index].selectedindex;
        //         pesanlt1[index].kondisi = false;
        //         outbool = pesanlt1[index].kondisi;
        //       })
        //     : setState(() {
        //         pesanlt1[index].tombol = const Color.fromRGBO(217, 217, 217, 1);
        //         pesanlt1[index].kondisi = true;
        //         outindex = pesanlt1[index].selectedindex;
        //         outbool = pesanlt1[index].kondisi;
        //       });
      },
      onFocusChange: (val) {
        setState(() {
          pesanlt1[index].kondisi = val;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 170),
        height: tinggi,
        width: lebar,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: pesanlt1[index].tombol,
            borderRadius: BorderRadius.circular(3),
            boxShadow: const [
              BoxShadow(
                  color: Color.fromRGBO(198, 198, 198, 1),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(
                    0,
                    2,
                  )),
            ]),
        child: Text(
          textAlign: TextAlign.center,
          pesanlt1[index].nokamar,
          style: const TextStyle(
            fontSize: 10,
          ),
        ),
      ),
    );
  }

  Widget fasilitas(String ket) {
    return Row(
      children: [
        Container(
          height: 15,
          width: 15,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.lightBlue.withOpacity(0.2)),
          child: const Icon(
            Icons.check,
            color: Colors.green,
            size: 10,
          ),
        ),
        const SizedBox(
          width: 6,
        ),
        Text(
          textAlign: TextAlign.left,
          ket,
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }

  Widget hargakamar(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //tab
        outbool
            ? const Text('Kamar Belum Dipilih',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.bold))
            : Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 125),
                    child: Text(
                        textAlign: TextAlign.start,
                        "Rp",
                        style: TextStyle(color: Colors.black, fontSize: 11)),
                  ),
                  Text(pesanlt1[index].harga,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                ],
              ),
        InkWell(
          onTap: () {
            setState(() {
              Navigator.of(context).pop();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(
                      admin: true,
                    ),
                  ));
            });
            // widget.admin
            //     ? setState(() {
            //         Navigator.of(context).pop();
            //         Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //               builder: (context) => Transaksi(
            //                 harga: pesanlt1[index].hargabayar,
            //                 kamar: pesanlt1[index].nokamar,
            //                 lantai: pesanlt1[index].nomorlantai,
            //               ),
            //             ));
            //       })
            //     : setState(() {
            //         Navigator.of(context).pop();
            //       });
          },
          borderRadius: BorderRadius.circular(15),
          child: Container(
            alignment: Alignment.center,
            height: 45,
            width: 110,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border:
                  Border.all(color: warna2, style: BorderStyle.solid, width: 1),
              boxShadow: [
                BoxShadow(
                  color: warna2.withOpacity(0.2),
                  blurRadius: 2,
                  spreadRadius: 1,
                ),
              ],
              color: Colors.white,
            ),
            child: Text(
              textAlign: TextAlign.center,
              widget.admin ? "Pesan Kamar" : "Kembali",
              style: TextStyle(
                  fontSize: 12, color: warna2, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  Widget hargakamaradmin(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //tab
        outbool
            ? const Text('Kamar Belum Dipilih',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.bold))
            : Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 125),
                    child: Text(
                        textAlign: TextAlign.start,
                        "Rp",
                        style: TextStyle(color: Colors.black, fontSize: 11)),
                  ),
                  Text(pesanlt1[index].harga,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                ],
              ),
        InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          borderRadius: BorderRadius.circular(15),
          child: Container(
            alignment: Alignment.centerRight,
            height: 45,
            width: 110,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border:
                  Border.all(color: warna2, style: BorderStyle.solid, width: 1),
              boxShadow: [
                BoxShadow(
                  color: warna2.withOpacity(0.2),
                  blurRadius: 2,
                  spreadRadius: 1,
                ),
              ],
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Text(
                textAlign: TextAlign.center,
                "Kembali",
                style: TextStyle(
                    fontSize: 12, color: warna2, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
