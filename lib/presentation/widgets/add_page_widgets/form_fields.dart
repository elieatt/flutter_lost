part of '../../pages/add_page.dart';

Widget _buildTitleTextFormField(BuildContext context) {
  return TextFormField(
    decoration: InputDecoration(
      filled: true,
      // fillColor: Theme.of(context).colorScheme.secondary,
      icon: Icon(
        Icons.title,
        color: Theme.of(context).colorScheme.secondary,
      ),
      labelText: 'Item title',
      labelStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: Color(Theme.of(context).colorScheme.secondary.alpha),
            width: 3),
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
      //  fillColor: Theme.of(context).colorScheme.secondary,
      icon: Icon(
        Icons.edit,
        color: Theme.of(context).colorScheme.primary,
      ),
      labelText: 'Description',
      labelStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
      enabledBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: Theme.of(context).colorScheme.primary, width: 3),
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
      maxTime: _nowDT,
      theme: DatePickerTheme(
          headerColor: Theme.of(context).colorScheme.primary,
          backgroundColor: Theme.of(context).colorScheme.background,
          itemStyle: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.bold,
              fontSize: 18),
          doneStyle: const TextStyle(color: Colors.white, fontSize: 16)),
      onConfirm: (date) {
    print('confirm ${date.toIso8601String()}');
    _formData["dateOfLoose"] = date.toIso8601String();
    _timeTextController.text = date.day.toString() +
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
          : _nowDT,
      locale: LocaleType.en); //language of datetime picker
}

Widget _buildDateTimeTextFormField(BuildContext context) {
  return TextFormField(
      controller: _timeTextController,
      readOnly: true,
      decoration: InputDecoration(
        filled: true,
        //    fillColor: Theme.of(context).colorScheme.secondary,
        icon: Icon(
          Icons.date_range,
          color: Theme.of(context).colorScheme.secondary,
        ),
        labelText: 'Date of loose/found',
        labelStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Color(Theme.of(context).colorScheme.secondary.alpha),
              width: 3),
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
                      _typeTextController.text = "Missing",
                      _formData["found"] = "0",
                      Navigator.pop(context)
                    },
                child: const Text('missing it')),
            TextButton(
                onPressed: () => {
                      _typeTextController.text = "Found",
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
    controller: _typeTextController,
    decoration: InputDecoration(
      filled: true,
      //  fillColor: Theme.of(context).colorScheme.secondary,
      icon: Icon(
        Icons.edit,
        color: Theme.of(context).colorScheme.primary,
      ),
      labelText: 'Found or Missing',
      labelStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
      enabledBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: Theme.of(context).colorScheme.primary, width: 3),
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
          //  fillColor: Theme.of(context).colorScheme.secondary,
          icon: Icon(
            Icons.class_,
            color: Theme.of(context).colorScheme.secondary,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Color(Theme.of(context).colorScheme.secondary.alpha),
                width: 3),
          )),
      hint: Text(
        "Category",
        style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
      ),
      items: category.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Row(
            children: [
              FaIcon(toIcon(value),
                  color: Theme.of(context).colorScheme.secondary),
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

Widget _buildLocationDropDownMenu(BuildContext context) {
  return DropdownButtonFormField<String>(
      menuMaxHeight: 325,
      decoration: InputDecoration(
        filled: true,
        //fillColor: Theme.of(context).colorScheme.secondary,
        icon: Icon(
          Icons.location_on_sharp,
          color: Theme.of(context).colorScheme.primary,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary, width: 3),
        ),
      ),
      hint: Text(
        "Governorate",
        style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
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
          return "Please select a governorate";
        }
      },
      onChanged: (String? value) => _formData["governorate"] = value);
}
