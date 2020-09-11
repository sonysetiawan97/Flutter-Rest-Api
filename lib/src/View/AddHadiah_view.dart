import 'package:flutter/material.dart';
import 'package:flutterrestapi/src/model/hadiah.dart';
import 'package:flutterrestapi/src/service/hadiahservice.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class AddHadiah extends StatefulWidget {
  @override
  _AddHadiahState createState() => _AddHadiahState();

  Hadiah hadiah;

  AddHadiah({this.hadiah});
}

class _AddHadiahState extends State<AddHadiah> {
  HadiahApiService _apiService = HadiahApiService();

  bool _isLoading = false;
  bool _isFieldIdHadiahValid;
  bool _isFieldNamaHadiahValid;
  bool _isFieldPointHadiahValid;

  TextEditingController _controllerIdHadiah = TextEditingController();
  TextEditingController _controllerNamaHadiah = TextEditingController();
  TextEditingController _controllerPointHadiah = TextEditingController();

  @override
  void initState() {
    if (widget.hadiah != null) {
      _isFieldIdHadiahValid = true;
      _controllerIdHadiah.text = widget.hadiah.id_hadiah.toString();
      _isFieldNamaHadiahValid = true;
      _controllerNamaHadiah.text = widget.hadiah.nama_hadiah;
      _isFieldPointHadiahValid = true;
      _controllerPointHadiah.text = widget.hadiah.point_hadiah.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        title: Text(
          widget.hadiah == null ? "Add Hadiah" : "Edit Hadiah",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildTextFieldIdUser(),
                _buildTextFieldNamaHadiah(),
                _buildTextFieldPointHadiah(),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: RaisedButton(
                    onPressed: () {
                      if (_isFieldIdHadiahValid == null ||
                          _isFieldNamaHadiahValid == null ||
                          _isFieldPointHadiahValid == null ||
                          !_isFieldIdHadiahValid ||
                          !_isFieldNamaHadiahValid ||
                          !_isFieldPointHadiahValid) {
                        _scaffoldState.currentState.showSnackBar(SnackBar(
                          content: Text("Please fill all field"),
                        ));
                        return;
                      }
                      setState(() => _isLoading = true);

                      int id_hadiah =
                          int.parse(_controllerIdHadiah.text.toString());
                      String nama_hadiah =
                          _controllerNamaHadiah.text.toString();
                      int point_hadiah =
                          int.parse(_controllerPointHadiah.text.toString());
                      Hadiah hadiah = Hadiah(
                          id_hadiah: id_hadiah,
                          nama_hadiah: nama_hadiah,
                          point_hadiah: point_hadiah);

                      if (widget.hadiah == null) {
                        _apiService.postHadiah(hadiah).then((isSuccess) {
                          setState(() => _isLoading = false);
                          if (isSuccess) {
                            Navigator.pop(
                                _scaffoldState.currentState.context, true);
                          } else {
                            _scaffoldState.currentState.showSnackBar(SnackBar(
                              content: Text("Submit data failed"),
                            ));
                          }
                        });
                      } else {
                        hadiah.id_hadiah = widget.hadiah.id_hadiah;
                        _apiService.putHadiah(hadiah).then((isSuccess) {
                          setState(() => _isLoading = false);
                          if (isSuccess) {
                            Navigator.pop(
                                _scaffoldState.currentState.context, true);
                          } else {
                            _scaffoldState.currentState.showSnackBar(SnackBar(
                              content: Text("Update data failed"),
                            ));
                          }
                        });
                      }
                    },
                    child: Text(
                      widget.hadiah == null ? "Submit Hadiah" : "Update Hadiah",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
          _isLoading
              ? Stack(
                  children: <Widget>[
                    Opacity(
                      opacity: 0.3,
                      child: ModalBarrier(
                        dismissible: false,
                        color: Colors.grey,
                      ),
                    ),
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }

  Widget _buildTextFieldIdUser() {
    return TextField(
      controller: _controllerIdHadiah,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "ID hadiah",
        errorText: _isFieldIdHadiahValid == null || _isFieldIdHadiahValid
            ? null
            : "ID hadiah require",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldIdHadiahValid) {
          setState(() => _isFieldIdHadiahValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldNamaHadiah() {
    return TextField(
      controller: _controllerNamaHadiah,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Nama Hadiah",
        errorText: _isFieldNamaHadiahValid == null || _isFieldNamaHadiahValid
            ? null
            : "Nama hadiah require",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldNamaHadiahValid) {
          setState(() => _isFieldNamaHadiahValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldPointHadiah() {
    return TextField(
      controller: _controllerPointHadiah,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Point Hadiah",
        errorText: _isFieldPointHadiahValid == null || _isFieldPointHadiahValid
            ? null
            : "Point hadiah require",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldPointHadiahValid) {
          setState(() => _isFieldPointHadiahValid = isFieldValid);
        }
      },
    );
  }
}
