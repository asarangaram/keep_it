// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:colan_widgets/colan_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keep_it/models/collection.dart';
import 'package:keep_it/providers/db_store.dart';

import '../../../models/collections.dart';

class UpsertCollectionForm extends ConsumerWidget {
  const UpsertCollectionForm({
    super.key,
    required this.collections,
    this.collection,
  });
  final Collections collections;
  final Collection? collection;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<CLFormField> clFormFields = [
      CLFormField(
        type: CLFormFieldTypes.textField,
        validator: (name) => validateName(name, collections),
        label: "Name",
        initialValue: collection?.label ?? "",
      ),
      CLFormField(
        type: CLFormFieldTypes.textFieldMultiLine,
        validator: validateDescription,
        label: "Description",
        initialValue: collection?.description ?? "",
      )
    ];

    return CLTextFieldForm(
        buttonLabel: (collection?.id == null) ? "Create" : "Update",
        clFormFields: clFormFields,
        onCancel: () => Navigator.of(context).pop(), // Close the dialog},
        onSubmit: (List<String> values) {
          final label = values[0];
          final description =
              values[1].trim().isEmpty ? null : values[1].trim();

          try {
            ref.read(collectionsProvider(null).notifier).upsertCollection(
                Collection(
                    id: collection?.id,
                    label: label,
                    description: description));
          } catch (e) {
            return e.toString();
          }
          Navigator.of(context).pop(); // Close the dialog
          return null;
        });
  }

  String? validateName(String? name, Collections collections) {
    if (name?.isEmpty ?? true) {
      return "Have a good name";
    }
    if (name!.length > 16) {
      return "Name should not exceed 15 letters";
    }
    if (collections.collections.map((e) => e.label).contains(name)) {
      return "$name already exists";
    }
    return null;
  }

  String? validateDescription(String? name) {
    // No restriction as of now
    return null;
  }
}
