import 'package:flutter/material.dart';
import 'package:flutterrestapi/src/model/transaksi.dart';
import 'package:flutterrestapi/src/service/transaksiservice.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class AddTransaksi extends StatefulWidget {
  @override
  _AddTransaksiState createState() => _AddTransaksiState();

  Transaksi transaksi;

  AddTransaksi({this.transaksi});
}

class _AddTransaksiState extends State<AddTransaksi> {
  TransaksiApiService _apiService = TransaksiApiService();

  bool _isLoading = false;
  bool _isFieldIdTransaksi;
  bool _isFieldIdUserValid;
  bool _isFieldTotalTransaksi;

  TextEditingController _controllerIdTransaksi = TextEditingController();
  TextEditingController _controllerIdUser = TextEditingController();
  TextEditingController _controllerTotalTransaksi = TextEditingController();

  @override
  void initState() {
    if (widget.transaksi != null) {
      _isFieldIdTransaksi = true;
      _controllerIdTransaksi.text = widget.transaksi.id_transaksi.toString();
      _isFieldIdUserValid = true;
      _controllerIdUser.text = widget.transaksi.id_user.toString();
      _isFieldTotalTransaksi = true;
      _controllerTotalTransaksi.text =
          widget.transaksi.total_transaksi.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        title: Text(
          widget.transaksi == null ? "Add Transaksi" : "Edit Transaksi",
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
                _buildTextFieldIdTransaksi(),
                _buildTextFieldIdUser(),
                _buildTextFieldTotalTransaksi(),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: RaisedButton(
                    onPressed: () {
                      if (_isFieldIdUserValid == null ||
                          _isFieldIdTransaksi == null ||
                          _isFieldTotalTransaksi == null ||
                          !_isFieldIdUserValid ||
                          !_isFieldIdTransaksi ||
                          !_isFieldTotalTransaksi) {
                        _scaffoldState.currentState.showSnackBar(SnackBar(
                          content: Text("Please fill all field"),
                        ));
                        return;
                      }
                      setState(() => _isLoading = true);

                      int id_user =
                          int.parse(_controllerIdUser.text.toString());
                      int id_transaksi =
                          int.parse(_controllerIdTransaksi.text.toString());
                      int total_transaksi =
                          int.parse(_controllerTotalTransaksi.text.toString());
                      Transaksi transaksi = Transaksi(
                          id_user: id_user,
                          id_transaksi: id_transaksi,
                          total_transaksi: total_transaksi);

                      if (widget.transaksi == null) {
                        _apiService.postTransaksi(transaksi).then((isSuccess) {
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
                        transaksi.id_transaksi = widget.transaksi.id_transaksi;
                        _apiService.putTransaksi(transaksi).then((isSuccess) {
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
                      widget.transaksi == null
                          ? "Submit Transaksi"
                          : "Update Transaksi",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    color: Colors.blue[600],
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
      controller: _controllerIdUser,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "ID User",
        errorText: _isFieldIdUserValid == null || _isFieldIdUserValid
            ? null
            : "ID user require",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldIdUserValid) {
          setState(() => _isFieldIdUserValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldIdTransaksi() {
    return TextField(
      controller: _controllerIdTransaksi,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "ID transaksi",
        errorText: _isFieldIdTransaksi == null || _isFieldIdTransaksi
            ? null
            : "ID transaksi require",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldIdTransaksi) {
          setState(() => _isFieldIdTransaksi = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldTotalTransaksi() {
    return TextField(
      controller: _controllerTotalTransaksi,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Total transaksi",
        errorText: _isFieldTotalTransaksi == null || _isFieldTotalTransaksi
            ? null
            : "Total transaksi require",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldTotalTransaksi) {
          setState(() => _isFieldTotalTransaksi = isFieldValid);
        }
      },
    );
  }
}
