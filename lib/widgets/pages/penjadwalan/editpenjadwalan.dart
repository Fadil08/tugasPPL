import 'package:belajar_firebase/widgets/pages/penjadwalan/service.dart';
import 'package:belajar_firebase/widgets/pages/penjadwalan/testjadwal/time.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class editdataPenjadwalan extends StatefulWidget {
  final penjadwalanTanaman? dataDet;
  const editdataPenjadwalan({Key? key, this.dataDet}) : super(key: key);

  @override
  State<editdataPenjadwalan> createState() => _detDataState();
}

class _detDataState extends State<editdataPenjadwalan> {
  final _namaTanaman = TextEditingController();
  final _tahapan = TextEditingController();
  final _startJadwal = TextEditingController();
  final _endJadwal = TextEditingController();
  final _deskripsi = TextEditingController();
  bool _isDisabled = false;

  @override
  void dispose() {
    // TODO: implement dispose
    _namaTanaman.dispose();
    _tahapan.dispose();
    _startJadwal.dispose();
    _endJadwal.dispose();
    _deskripsi.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    _namaTanaman.text = widget.dataDet?.namaTanaman ?? "";
    _tahapan.text = widget.dataDet?.tahapan ?? "";
    _startJadwal.text = widget.dataDet?.startJadwal ?? "";
    _endJadwal.text = widget.dataDet?.endJadwal ?? "";
    _deskripsi.text = widget.dataDet?.deskripsi ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (widget.dataDet == null) _isDisabled = true;

    return Scaffold(
      appBar: AppBar(
        title: Text('padi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            TextField(
              controller: _namaTanaman,
              enabled: _isDisabled,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Masukkan judul Note'),
            ),
            SizedBox(
              height: 12.0,
            ),
            TextField(
              controller: _tahapan,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Masukkan isi Note'),
            ),
            SizedBox(
              height: 12.0,
            ),
            TextField(
                controller: _startJadwal,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Masukkan start Jadwal',
                  icon: IconButton(
                    icon: Icon(
                      Icons.date_range_outlined,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2030),
                              initialEntryMode: DatePickerEntryMode.input)
                          .then((value) {
                        if (value != null) {
                          setState(() {
                            _startJadwal.text = value.toString();
                          });
                        }
                      });
                    },
                  ),
                )),
            SizedBox(
              height: 12.0,
            ),
            TextField(
              controller: _endJadwal,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Masukkan end jadwal',
                icon: IconButton(
                  icon: Icon(
                    Icons.date_range_outlined,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2030),
                            initialEntryMode: DatePickerEntryMode.input)
                        .then((value) {
                      if (value != null) {
                        setState(() {
                          _endJadwal.text = value.toString();
                        });
                      }
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              height: 12.0,
            ),
            TextField(
              controller: _deskripsi,
              maxLines: 10,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Masukkan deskripsi'),
            ),
            ElevatedButton(
              onPressed: () {
                final dt = penjadwalanTanaman(
                  namaTanaman: _namaTanaman.text,
                  tahapan: _tahapan.text,
                  startJadwal: _startJadwal.text,
                  endJadwal: _endJadwal.text,
                  deskripsi: _deskripsi.text,
                );
                dataservisTanaman.tambahData(item: dt);
                Navigator.pop(context);
              },
              child: Text('Simpan Data'),
            ),
          ],
        ),
      ),
    );
  }
}
