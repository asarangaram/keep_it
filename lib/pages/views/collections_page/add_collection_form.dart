import 'package:colan_widgets/colan_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keep_it/models/collection.dart';
import 'package:keep_it/providers/db_store.dart';
import 'package:keep_it/utils/extensions.dart';

import '../../../models/collections.dart';
import '../../../providers/theme.dart';
import '../app_theme.dart';

class UpsertCollectionForm extends ConsumerStatefulWidget {
  const UpsertCollectionForm({
    super.key,
    required this.collections,
    this.collection,
  });
  final Collections collections;
  final Collection? collection;

  @override
  ConsumerState<UpsertCollectionForm> createState() =>
      _AddCollectionFormState();
}

class _AddCollectionFormState extends ConsumerState<UpsertCollectionForm> {
  String? dbError;
  String? dbErrorDetail;
  late final TextEditingController editLabel;
  late final TextEditingController editDescription;

  late FocusNode focusLabel = FocusNode();
  late FocusNode focusDescription = FocusNode();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    editLabel = TextEditingController();
    editDescription = TextEditingController();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    editLabel.text = widget.collection?.label ?? "";
    editDescription.text = widget.collection?.description ?? "";
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    editLabel.dispose();
    editDescription.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final customTheme = ref.watch(customThemeDataProvider);

    return AppTheme(
      child: Dialog(
        backgroundColor: Colors.transparent,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
                border: Border.all(color: customTheme.color),
                color: customTheme.color.invertColor().withAlpha(128),
                borderRadius: BorderRadius.circular(8.0)),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CLTextField.form(
                    editLabel,
                    label: "Name",
                    validator: validateName,
                    focusNode: focusLabel,
                    onFieldSubmitted: (p0) {
                      FocusScope.of(context).requestFocus(focusDescription);
                    },
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 16.0),
                  CLTextField.multiLineForm(editDescription,
                      label: "Description",
                      validator: validateDescription,
                      focusNode: focusDescription),
                  const SizedBox(height: 16.0),
                  if (dbError != null) CLBlink(child: CLText.small(dbError!)),
                  Align(
                    alignment: Alignment.center,
                    child: CLStandardButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          setState(() {
                            dbError = null;
                            dbErrorDetail = null;
                          });
                          // Do something with the entered values
                          final label = editLabel.text;
                          final description =
                              editDescription.text.trim().isEmpty
                                  ? null
                                  : editDescription.text;
                          try {
                            ref
                                .read(collectionsProvider(null).notifier)
                                .upsertCollection(Collection(
                                    id: widget.collection?.id,
                                    label: label,
                                    description: description));
                          } catch (e) {
                            setState(() {
                              dbError = "Unable to create Collection; ";
                              dbErrorDetail = e.toString();
                            });
                          }

                          Navigator.of(context).pop(); // Close the dialog
                        }
                      },
                      label: CLText.large((widget.collection?.id == null)
                          ? "Create"
                          : "Update"),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CLIconButton(
                          Icons.keyboard_hide,
                          onTap: (FocusScope.of(context).focusedChild != null)
                              ? () {
                                  FocusScope.of(context)
                                      .focusedChild!
                                      .unfocus();
                                }
                              : null,
                          scaleType: CLScaleType.verySmall,
                        ),
                        CLStandardButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                          label: const CLText.verySmall("Cancel"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? validateName(String? name) {
    if (name?.isEmpty ?? true) {
      return "Have a good name";
    }
    if (name!.length > 16) {
      return "Name should not exceed 15 letters";
    }
    if (widget.collections.collections.map((e) => e.label).contains(name)) {
      return "$name already exists";
    }
    return null;
  }

  String? validateDescription(String? name) {
    // No restriction as of now
    return null;
  }
}
