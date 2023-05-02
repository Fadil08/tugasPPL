import 'package:belajar_firebase/widgets/pages/penjadwalan/testjadwal/time.dart';
import 'package:flutter/material.dart';


class ColorPicker extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ColorPickerState();
  }
}

class ColorPickerState extends State<ColorPicker> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
          width: double.maxFinite,
          child: ListView.builder(
            padding: const EdgeInsets.all(0),
            itemCount: colorCollection.length - 1,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                contentPadding: const EdgeInsets.all(0),
                leading: Icon(
                    index == selectedColorIndex
                        ? Icons.lens
                        : Icons.trip_origin,
                    color: colorCollection[index]),
                title: Text(colorNames[index]),
                onTap: () {
                  setState(() {
                    selectedColorIndex = index;
                  });

                  // ignore: always_specify_types
                  Future.delayed(const Duration(milliseconds: 200), () {
                    // When task is over, close the dialog
                    Navigator.pop(context);
                  });
                },
              );
            },
          )),
    );
  }
}