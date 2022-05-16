import 'package:flutter/material.dart';

import '../utils/interfaces.dart';
import '../presenter/imc_presenter.dart';

import 'components/components.dart';

class HomePage extends StatefulWidget {
  final IMCPresenter? presenter;
  final String? title;

  const HomePage(this.presenter, {Key? key, this.title}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> implements IMCView {
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();

  late String _weight, _height;

  var _message = '';
  var _imcString = '';
  var _value = 0;
  var _heightMessage = '';
  var _weightMessage = '';

  final FocusNode _ageFocus = FocusNode();
  final FocusNode _heightFocus = FocusNode();
  final FocusNode _weightFocus = FocusNode();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    widget.presenter?.imcView = this;
  }

  void handleRadioValueChanged(int value) {
    widget.presenter?.onOptionChanged(value, _height, _weight);
  }

  void calculator() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      widget.presenter?.onCalculateClicked(_weight, _height);
    }
  }

  @override
  void updateIMCValue(String bmiValue, String bmiMessage) {
    setState(() {
      _imcString = bmiValue;
      _message = bmiMessage;
    });
  }

  @override
  void updateWeight({String? weight}) {
    setState(() {
      _weightController.text = weight ?? '';
    });
  }

  @override
  void updateHeight({String? height}) {
    setState(() {
      _heightController.text = height ?? '';
    });
  }

  @override
  void updateUnit(int value, String heightMessage, String weightMessage) {
    setState(() {
      _value = value;
      _heightMessage = heightMessage;
      _weightMessage = weightMessage;
    });
  }

  @override
  Widget build(BuildContext context) {
    var _mainPartView = Container(
      color: Colors.grey.shade300,
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              ageFormField(context),
              heightFormField(context),
              weightFormField(),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: CalculateButton(
                  calculator: calculator,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    var _resultView = Column(
      children: <Widget>[
        Center(
          child: Text(
            'Seu IMC: $_imcString',
            style: const TextStyle(
                color: Colors.blue,
                fontSize: 24.0,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.italic),
          ),
        ),
        const Padding(padding: EdgeInsets.all(2.0)),
        Center(
          child: Text(
            _message,
            style: const TextStyle(
                color: Colors.lightGreen,
                fontSize: 24.0,
                fontWeight: FontWeight.w600),
          ),
        )
      ],
    );

    return Scaffold(
        appBar: AppBar(
          title: const Text('IMC'),
          centerTitle: true,
          backgroundColor: Colors.pinkAccent.shade400,
        ),
        backgroundColor: Colors.white,
        body: ListView(
          children: <Widget>[
            const Padding(padding: EdgeInsets.all(5.0)),
            _mainPartView,
            const Padding(padding: EdgeInsets.all(5.0)),
            _resultView
          ],
        ));
  }

  TextFormField weightFormField() {
    return TextFormField(
      controller: _weightController,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
      focusNode: _weightFocus,
      onFieldSubmitted: (value) {
        _weightFocus.unfocus();
        calculator();
      },
      validator: (value) {
        if (double.parse(value ?? '') == 0.0) {
          return ('Weight is not valid. Weight > 0.0');
        }
      },
      onSaved: (value) {
        _weight = value ?? '';
      },
      decoration: InputDecoration(
          hintText: _weightMessage,
          labelText: _weightMessage,
          icon: const Icon(Icons.menu),
          fillColor: Colors.white),
    );
  }

  TextFormField heightFormField(BuildContext context) {
    return TextFormField(
      controller: _heightController,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      focusNode: _heightFocus,
      onFieldSubmitted: (term) {
        _fieldFocusChange(context, _heightFocus, _weightFocus);
      },
      validator: (value) {
        if (double.parse(value ?? '') == 0.0) {
          return ('Height is not valid. Height > 0.0');
        }
      },
      onSaved: (value) {
        _height = value ?? '';
      },
      decoration: InputDecoration(
        hintText: _heightMessage,
        icon: const Icon(Icons.assessment),
        fillColor: Colors.white,
      ),
    );
  }

  TextFormField ageFormField(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      focusNode: _ageFocus,
      onFieldSubmitted: (term) {
        _fieldFocusChange(context, _ageFocus, _heightFocus);
      },
      validator: (value) {
        if (double.parse(value ?? '') <= 15) {
          return ('Age should be over 15 years old');
        }
      },
      onSaved: (value) {},
      decoration: const InputDecoration(
        hintText: 'Age',
        icon: Icon(Icons.person_outline),
        fillColor: Colors.white,
      ),
    );
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
