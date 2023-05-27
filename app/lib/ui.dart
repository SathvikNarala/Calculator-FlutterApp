import 'package:flutter/material.dart';
import 'logic.dart';

class AppState extends State<StatefulWidget>{
  
  final _key = GlobalKey<FormState>();

  final _arithmetic = TextEditingController(text: '');

  Response output = Response();

  ElevatedButton _makeButton({required String display, 
  Color? color = Colors.blueGrey, 
  Function? action})
  {
    return ElevatedButton(
      onPressed: (){
        action == null ? 
        _arithmetic.text = _arithmetic.text + display : 
        action();
      },
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        backgroundColor: color,
      ), 
      
      child: Center(
        child: Text(display,
          textScaleFactor: 1.5,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Calculator')
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Form(
          key: _key,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  isDense: true,
                  hintText: '0'
                ),
                textAlign: TextAlign.end,
                keyboardType: TextInputType.none,
                cursorColor: Colors.blue,
                style: const TextStyle(
                  fontSize: 50
                ),
                controller: _arithmetic,
                validator: (value) {
                  return RegExp(r'^.*$').hasMatch(value!) ? 
                  null : "Requires a valid arithmetic expression";
                },
              ),

              const SizedBox(
                height: 70,
              ),

              Expanded(
                child: GridView.count(
                  crossAxisCount: 4,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: MediaQuery.of(context).size.aspectRatio * 3.0,
                  shrinkWrap: true,
                  children: [
                    _makeButton(
                      display: 'C', 
                      color: Colors.red,
                      action: ()=>_arithmetic.clear()
                    ),
                    _makeButton(
                      display: '(', 
                      color: Colors.blue,
                    ),
                    _makeButton(
                      display: ')', 
                      color: Colors.blue,
                    ),
                    _makeButton(
                      display: '/', 
                      color: Colors.blue
                    ),
              
                    _makeButton(display: '7'),
                    _makeButton(display: '8'),
                    _makeButton(display: '9'),
                    
                    _makeButton(
                      display: '*', 
                      color: Colors.blue
                    ),
              
                    _makeButton(display: '4'),
                    _makeButton(display: '5'),
                    _makeButton(display: '6'),
              
                    _makeButton(
                      display: '-', 
                      color: Colors.blue
                    ),
                    
                    _makeButton(display: '1'),
                    _makeButton(display: '2'),
                    _makeButton(display: '3'),
                    
                    _makeButton(display: '+', 
                      color: Colors.blue
                    ),
                    
                    _makeButton(display: '0'),
                    _makeButton(display: '.'),
              
                    _makeButton(
                      display: 'X',
                      action: ()=>_arithmetic.text = _arithmetic.text.replaceFirst(RegExp(r'.$'), '')
                    ),
                    
                    _makeButton(
                      display: '=', 
                      color: Colors.green,
                      action: ()=> setState(() {
                        if(_key.currentState!.validate()){
                          if(_arithmetic.text.isNotEmpty){
                            output = Logic.evaluate(
                              Request(
                                expression: _arithmetic.text
                              )
                            );

                            _arithmetic.text = output.answer.toString();
                          }
                        }
                      }),
                    ),
                  ],
                ),
              ), 
            ],
          ),
        ),
      )
    );
  }
}
