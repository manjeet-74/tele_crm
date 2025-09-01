import 'package:flutter/material.dart';
import 'package:tele_crm/constants.dart';

class FilterBar extends StatelessWidget {
  const FilterBar({
    super.key,
    required this.leadStatus,
    required this.createdOn,
    required this.assignee,
    required this.leadStatuses,
    required this.createdOnOptions,
    required this.assignees,
    required this.onChanged,
  });

  final String? leadStatus;
  final String? createdOn;
  final String? assignee;

  final List<String> leadStatuses;
  final List<String> createdOnOptions;
  final List<String> assignees;

  final void Function(String?, String?, String?) onChanged;

  @override
  Widget build(BuildContext context) {
    OutlinedButton.styleFrom(
      // padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
      backgroundColor: selectedFill,
      foregroundColor: Colors.black87,
    );

    Widget menu({
      required String label,
      required List<String> items,
      required String? value,
      required void Function(String?) onSelect,
    }) {
      return DropdownMenu<String>(
        width: 120,
        hintText: label,
        initialSelection: value,
        dropdownMenuEntries:
            items.map((e) => DropdownMenuEntry(value: e, label: e)).toList(),
        enableFilter: false,
        menuStyle: MenuStyle(
          backgroundColor: WidgetStatePropertyAll(Colors.white),
          shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        ),
        inputDecorationTheme: InputDecorationTheme(
          isDense: true,
          filled: true,
          fillColor: selectedFill,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          constraints: const BoxConstraints(maxHeight: 44),
        ),
        onSelected: onSelect,
      ); // Material 3 DropdownMenu with consistent styling. [9]
    }

    final widgets = <Widget>[];
    if (leadStatuses.isNotEmpty) {
      widgets.add(menu(
        label: 'Lead Status',
        items: leadStatuses,
        value: leadStatus,
        onSelect: (v) => onChanged(v, createdOn, assignee),
      ));
    }
    if (createdOnOptions.isNotEmpty) {
      widgets.add(menu(
        label: 'Created On',
        items: createdOnOptions,
        value: createdOn,
        onSelect: (v) => onChanged(leadStatus, v, assignee),
      ));
    }
    if (assignees.isNotEmpty) {
      widgets.add(menu(
        label: 'Assignee',
        items: assignees,
        value: assignee,
        onSelect: (v) => onChanged(leadStatus, createdOn, v),
      ));
    }

    return Align(
      alignment: Alignment.centerLeft,
      child: Wrap(
        spacing: 12,
        runSpacing: 8,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: widgets,
      ),
    );

    // return Align(
    //   alignment: Alignment.centerLeft,
    //   child: Wrap(
    //     spacing: 12,
    //     runSpacing: 8,
    //     crossAxisAlignment: WrapCrossAlignment.center,
    //     children: [
    //       menu(
    //         label: 'Lead Status',
    //         items: leadStatuses,
    //         value: leadStatus,
    //         onSelect: (v) => onChanged(v, createdOn, assignee),
    //       ),
    //       menu(
    //         label: 'Created On',
    //         items: createdOnOptions,
    //         value: createdOn,
    //         onSelect: (v) => onChanged(leadStatus, v, assignee),
    //       ),
    //       menu(
    //         label: 'Assignee',
    //         items: assignees,
    //         value: assignee,
    //         onSelect: (v) => onChanged(leadStatus, createdOn, v),
    //       ),
    //     ],
    //   ),
    // );
  }
}
