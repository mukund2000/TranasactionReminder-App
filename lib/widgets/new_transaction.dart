import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController=TextEditingController();

  final priceController=TextEditingController();
  DateTime _selectedDate;

  void _presentDatePicker(){
    showDatePicker(
      context: context,
       initialDate: DateTime.now(), 
       firstDate: DateTime(2020), 
       lastDate: DateTime.now()
       ).then((_pickedDate){
        if(_pickedDate==null)
        {
          return;
        }
        setState(() {
          _selectedDate=_pickedDate;
        });
       });
  }

  void _submitData(){
    if(priceController==null)
    {
      return;
    }
    final enteredTitle=titleController.text;
    final enteredPrice=double.parse(priceController.text);

    if(enteredTitle.isEmpty||enteredPrice <= 0||_selectedDate==null)
    {
      return ;
    }
    widget.addTx(
         enteredTitle,
         enteredPrice,
         _selectedDate,
        );
        Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
            elevation: 4.0,
            child: Container(
              padding: EdgeInsets.all(4.0),
              child: Column(
                children: <Widget>[
                  TextField(decoration: InputDecoration(labelText: "Title"),
                  controller: titleController,
                  
                  // onChanged: (val){
                  //   titleInput=val;
                  // },
                  ),
                  TextField(decoration: InputDecoration(labelText: "Price"),
                  controller: priceController,
                  keyboardType:TextInputType.number,
                  onSubmitted: (_)=>_submitData(),
                  // onChanged: (val){
                  //   priceInput=val;
                  // },
                  ),
                  Container(
                    height: 70,
                    child: Row(
                      children: <Widget>[
                        Expanded(child: Text(_selectedDate==null?"No date choosen":"Picked Date:${DateFormat().add_yMd().format(_selectedDate)}")),
                        FlatButton(onPressed: _presentDatePicker, 
                        child: Text(
                          "Choose Date",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor
                            ),
                            )
                            )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      RaisedButton(onPressed: _submitData,
                        color: Colors.green,
                        // print(titleController);
                        // print(priceController);
                        
                        // print(titleInput);
                        // print(priceInput);
                      child: Text("Submit",style:Theme.of(context).textTheme.button),),
                    ],
                  )
                ],
              ),
            ), 

          );
  }
}