import 'package:flutter/material.dart';
import 'package:instagram_demo/features/home/presentation/provider/person_provider.dart';
import 'package:instagram_demo/features/home/presentation/view/widgets/custom_text_form_field_widget.dart';
import 'package:provider/provider.dart';

class AddPersonDialogueWidget extends StatelessWidget {
  const AddPersonDialogueWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final personProvider = Provider.of<PersonProvider>(context, listen: false);

    return AlertDialog(
      title: const Text('Add Post'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextField(
            hintText: 'Name',
            controller: personProvider.nameController,
          ),
          const SizedBox(height: 10),
          CustomTextField(
            hintText: 'Place',
            controller: personProvider.placeController,
          ),
          const SizedBox(height: 10),
          CustomTextField(
            hintText: 'Description',
            controller: personProvider.descreptionController,
          ),
          const SizedBox(height: 10),
          CustomTextField(
            hintText: 'Image Url',
            controller: personProvider.imageUrlController,
          )
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            personProvider.addPerson();
            personProvider.clearController();
            Navigator.pop(context);
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}


