import 'package:almanara/core/constrain/color.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String hint;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final void Function(DateTime)? onDateTimeSelected;

  const CustomTextField({
    super.key,
    required this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.onDateTimeSelected,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final TextEditingController _controller = TextEditingController();

  Future<void> _selectDateTime(BuildContext context) async {
    if (widget.onDateTimeSelected == null)
      return; // إذا لم يتم تمرير دالة، لا تفعل شيئًا

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        final DateTime selectedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        setState(() {
          _controller.text =
              "${pickedDate.toString().split(' ')[0]} ${pickedTime.format(context)}";
        });

        widget.onDateTimeSelected!(selectedDateTime);
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onTap: widget.onDateTimeSelected != null
          ? () => _selectDateTime(context)
          : null, // اجعلها قابلة للنقر فقط عند وجود onDateTimeSelected
      maxLines: 1,
      readOnly: widget.onDateTimeSelected !=
          null, // امنع الكتابة اليدوية عند اختيار التاريخ
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: grey, width: 0.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: grey, width: 0.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: black, width: 0.5),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: grey, width: 0.5),
        ),
        hintText: widget.hint,
        hintStyle: Theme.of(context).textTheme.bodyMedium,
        prefixIcon: widget.prefixIcon,
        prefixIconColor: grey,
        suffixIcon: widget.suffixIcon,
        suffixIconConstraints: BoxConstraints.loose(Size.fromWidth(40)),
      ),
    );
  }
}
