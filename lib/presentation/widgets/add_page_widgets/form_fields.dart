part of '../../pages/add_page.dart';

Widget _buildTitleTextFormField(BuildContext context) {
  return TextFormField(
    decoration: InputDecoration(
      filled: true,
      fillColor: Theme.of(context).accentColor,
      icon: const Icon(
        Icons.title,
        color: Colors.amberAccent,
      ),
      labelText: 'Item title',
      labelStyle: const TextStyle(color: Colors.black),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(Colors.amber.alpha), width: 3),
      ),
    ),
    keyboardType: TextInputType.text,
    validator: (String? value) {
      if (value!.isEmpty) {
        return "Title is required.";
      }
      return null;
    },
    onChanged: (String? value) => _formData["title"] = value,
    onSaved: (String? value) => _formData["title"] = value,
  );
}

Widget _buildDescriptionTextFormField(BuildContext context) {
  return TextFormField(
    minLines: 10,
    maxLines: 11,
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.amber[150],
      icon: const Icon(
        Icons.edit,
        color: Colors.blue,
      ),
      labelText: 'Description',
      labelStyle: const TextStyle(color: Colors.black),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue, width: 3),
      ),
    ),
    keyboardType: TextInputType.text,
    validator: (String? value) {
      if (value!.isEmpty || value.length < 10) {
        return "Description is required and must be +10 characters long";
      }
      return null;
    },
    onSaved: (String? value) => _formData["description"] = value,
  );
}

void _showDatePicker(BuildContext context) {
  DatePicker.showDateTimePicker(context,
      showTitleActions: true,
      minTime: DateTime(2021, 3, 5),
      maxTime: DateTime.now(),
      theme: DatePickerTheme(
          headerColor: Colors.amber,
          backgroundColor: Theme.of(context).accentColor,
          itemStyle: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          doneStyle: const TextStyle(color: Colors.white, fontSize: 16)),
      onConfirm: (date) {
    print('confirm ${date.toIso8601String()}');
    _formData["dateOfLoose"] = date.toIso8601String();
    timeTextController.text = date.day.toString() +
        '/' +
        date.month.toString() +
        '/' +
        date.year.toString() +
        ":" +
        date.hour.toString() +
        ":" +
        date.minute.toString();
  },
      currentTime: _formData["dateOfLoose"] != null
          ? DateTime.parse(_formData["dateOfLoose"])
          : DateTime.now(),
      locale: LocaleType.en); //language of datetime picker
}

Widget _buildDateTimeTextFormField(BuildContext context) {
  return TextFormField(
      controller: timeTextController,
      readOnly: true,
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).accentColor,
        icon: const Icon(
          Icons.date_range,
          color: Colors.amberAccent,
        ),
        labelText: 'Date if loose/found',
        labelStyle: const TextStyle(color: Colors.black),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(Colors.amber.alpha), width: 3),
        ),
      ),
      onTap: () => _showDatePicker(context),
      validator: (String? value) {
        if (value!.isEmpty) {
          return "Date and time of loose is required";
        }
        return null;
      });
}

void _showtypeAlertDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Did you find it or miss it ?'),
          actions: [
            TextButton(
                onPressed: () => {
                      typeTextController.text = "Missing",
                      _formData["found"] = "0",
                      Navigator.pop(context)
                    },
                child: const Text('missing it')),
            TextButton(
                onPressed: () => {
                      typeTextController.text = "Found",
                      _formData["found"] = "1",
                      Navigator.pop(context)
                    },
                child: const Text(' found it '))
          ],
        );
      });
}

Widget _buildtypeOfItemTextFormField(BuildContext context) {
  return TextFormField(
    controller: typeTextController,
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.amber[150],
      icon: const Icon(
        Icons.edit,
        color: Colors.blue,
      ),
      labelText: 'Found or Missing',
      labelStyle: const TextStyle(color: Colors.black),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue, width: 3),
      ),
    ),
    readOnly: true,
    validator: (String? value) {
      if (value!.isEmpty) {
        return "This field is required.";
      }
      return null;
    },
    onTap: () => _showtypeAlertDialog(context),
  );
}

Widget _buildCategoryDropDownMenu(BuildContext context) {
  return DropdownButtonFormField<String>(
      menuMaxHeight: 325,
      decoration: InputDecoration(
          filled: true,
          fillColor: Theme.of(context).accentColor,
          icon: const Icon(
            Icons.class_,
            color: Colors.amberAccent,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(Colors.amber.alpha), width: 3),
          )),
      hint: const Text(
        "Category",
        style: TextStyle(color: Colors.black),
      ),
      items: category.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Row(
            children: [
              FaIcon(toIcon(value), color: Colors.amber),
              const SizedBox(
                width: 5.0,
              ),
              Text(value)
            ],
          ),
        );
      }).toList(),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return "Please select a category";
        }
      },
      onChanged: (String? value) => _formData["category"] = value);
}

Widget _buildLocationDropDownMenu() {
  return DropdownButtonFormField<String>(
      menuMaxHeight: 325,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.amber[150],
        icon: const Icon(
          Icons.location_on_sharp,
          color: Colors.blue,
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 3),
        ),
      ),
      hint: const Text(
        "Governorate",
        style: TextStyle(color: Colors.black),
      ),
      items: governorate.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        );
      }).toList(),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return "Please select a category";
        }
      },
      onChanged: (String? value) => _formData["governorate"] = value);
}
