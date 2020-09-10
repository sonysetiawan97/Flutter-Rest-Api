import 'package:flutter/material.dart';
import 'package:flutterrestapi/src/app.dart';
import 'package:flutterrestapi/src/model/admin.dart';
import 'package:flutterrestapi/src/service/adminservice.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class AddUser extends StatefulWidget {
  @override
  _AddUserState createState() => _AddUserState();

  Admin admin;

  AddUser({this.admin});
}

class _AddUserState extends State<AddUser> {
  AdminApiService _apiService = AdminApiService();

  bool _isLoading = false;
  bool _isFieldIdUserValid;
  bool _isFieldFirstNameValid;
  bool _isFieldLastNameValid;

  TextEditingController _controllerIdUser = TextEditingController();
  TextEditingController _controllerFirstName = TextEditingController();
  TextEditingController _controllerLastName = TextEditingController();

  @override
  void initState() {
    if (widget.admin != null) {
      _isFieldIdUserValid = true;
      _controllerIdUser.text = widget.admin.id_user.toString();
      _isFieldFirstNameValid = true;
      _controllerFirstName.text = widget.admin.first_name;
      _isFieldLastNameValid = true;
      _controllerLastName.text = widget.admin.last_name;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        title: Text(
          widget.admin == null ? "Add User" : "Edit User",
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
                _buildTextFieldFirstName(),
                _buildTextFieldLastName(),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: RaisedButton(
                    onPressed: () {
                      if (_isFieldIdUserValid == null ||
                          _isFieldFirstNameValid == null ||
                          _isFieldLastNameValid == null ||
                          !_isFieldIdUserValid ||
                          !_isFieldFirstNameValid ||
                          !_isFieldLastNameValid) {
                        _scaffoldState.currentState.showSnackBar(SnackBar(
                          content: Text("Please fill all field"),
                        ));
                        return;
                      }
                      setState(() => _isLoading = true);

                      int id_user =
                          int.parse(_controllerIdUser.text.toString());
                      String first_name = _controllerFirstName.text.toString();
                      String last_name = _controllerLastName.text.toString();
                      Admin admin = Admin(
                          id_user: id_user,
                          first_name: first_name,
                          last_name: last_name);

                      if (widget.admin == null) {
                        _apiService.postUsers(admin).then((isSuccess) {
                          setState(() => _isLoading = false);
                          if (isSuccess) {
                            Navigator.pop(context, "Submit data successful");
                          } else {
                            _scaffoldState.currentState.showSnackBar(SnackBar(
                              content: Text("Submit data failed"),
                            ));
                          }
                        });
                      } else {
                        admin.id_user = widget.admin.id_user;
                        _apiService.putUsers(admin).then((isSuccess) {
                          setState(() => _isLoading = false);
                          if (isSuccess) {
                            Navigator.pop(context, "Update data successful");
                          } else {
                            _scaffoldState.currentState.showSnackBar(SnackBar(
                              content: Text("Update data failed"),
                            ));
                          }
                        });
                      }
                      Navigator.of(context)
                          .push(new MaterialPageRoute(builder: (_) {
                        return new App();
                      }));
                    },
                    child: Text(
                      widget.admin == null ? "Submit User" : "Update User",
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

  Widget _buildTextFieldFirstName() {
    return TextField(
      controller: _controllerFirstName,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "First Name User",
        errorText: _isFieldFirstNameValid == null || _isFieldFirstNameValid
            ? null
            : "First name user require",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldFirstNameValid) {
          setState(() => _isFieldFirstNameValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldLastName() {
    return TextField(
      controller: _controllerLastName,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Last Name User",
        errorText: _isFieldLastNameValid == null || _isFieldLastNameValid
            ? null
            : "Last name user require",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldLastNameValid) {
          setState(() => _isFieldLastNameValid = isFieldValid);
        }
      },
    );
  }
}
