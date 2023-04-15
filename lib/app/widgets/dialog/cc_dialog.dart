import "package:currency_text_input_formatter/currency_text_input_formatter.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:page_penner/app/widgets/button/cc_text_button.dart";
import "package:page_penner/app/widgets/card/cc_card.dart";
import "package:page_penner/core/values/colors.dart";
import "package:syncfusion_flutter_datepicker/datepicker.dart";

class CCDialog {
  void loadingWithText({
    required String message,
    Color progressColor = primary,
  }) {
    Get.dialog(
      WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(color: progressColor),
              const SizedBox(width: 16),
              Flexible(
                child: Text(message),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void dialogSingleCalendar({
    required BuildContext context,
    required DateRangePickerController controller,
    required DateTime maxDate,
    String negativeButtonName = "Cancelar",
    String positiveButtonName = "Ok",
    required Function() negativeButtonOnPressed,
    required Function(Object) positiveButtonOnPressed,
  }) {
    Get.dialog(
      CCCard.surface(
        widgets: [
          SfDateRangePicker(
            controller: controller,
            cancelText: negativeButtonName.toUpperCase(),
            confirmText: positiveButtonName.toUpperCase(),
            showNavigationArrow: true,
            maxDate: maxDate,
            initialSelectedDate: DateTime.now(),
            selectionMode: DateRangePickerSelectionMode.single,
            showActionButtons: true,
            onCancel: negativeButtonOnPressed,
            onSubmit: (val) {
              Get.back();
              positiveButtonOnPressed(val!);
            },
          ),
        ],
      ),
    );
  }

  void dialogPositiveButton({
    required String title,
    Color titleColor = onSurface,
    IconData? icon,
    Color iconColor = onSurface,
    double iconSize = 22,
    required String contentText,
    String namePositiveButton = "Ok",
    Color colorPositiveButton = primary,
    required Function() onPressedPositiveButton,
  }) {
    Get.dialog(
      WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: titleSession(
            title: title,
            icon: icon,
            iconColor: iconColor,
            iconSize: iconSize,
          ),
          content: Text(
            contentText,
            style: TextStyle(
              color: titleColor,
            ),
          ),
          actions: [
            CCTextButton(
              text: namePositiveButton.toUpperCase(),
              textColor: colorPositiveButton,
              onPressed: onPressedPositiveButton,
            ),
          ],
        ),
      ),
    );
  }

  void dialogNeutralAndPositiveButton({
    required String title,
    Color titleColor = onSurface,
    IconData? icon,
    Color iconColor = onSurface,
    double iconSize = 22,
    required String contentText,
    String nameNeutralButton = "Cancelar",
    Color colorNeutralButton = neutral,
    required Function() onPressedNeutralButton,
    String namePositiveButton = "Ok",
    Color colorPositiveButton = primary,
    required Function() onPressedPositiveButton,
  }) {
    Get.dialog(
      WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: titleSession(
            title: title,
            icon: icon,
            iconColor: iconColor,
            iconSize: iconSize,
          ),
          content: Text(
            contentText,
            style: TextStyle(
              color: titleColor,
            ),
          ),
          actions: [
            CCTextButton(
              text: nameNeutralButton.toUpperCase(),
              textColor: colorNeutralButton,
              onPressed: onPressedNeutralButton,
            ),
            CCTextButton(
              text: namePositiveButton.toUpperCase(),
              textColor: colorPositiveButton,
              onPressed: onPressedPositiveButton,
            ),
          ],
        ),
      ),
    );
  }

  void dialogInputText({
    required String title,
    Color titleColor = onSurface,
    IconData? titleIcon,
    Color? titleIconColor = primary,
    double titleIconSize = 22,
    IconData? prefixIcon,
    Color? prefixIconColor = primary,
    double prefixIconSize = 22,
    required String initialValue,
    required String hint,
    Color hintColor = neutral,
    int maxLine = 1,
    required String? Function(String) validator,
    required String nameNeutralButton,
    Color colorNeutralButton = neutral,
    required Function() onPressedNeutralButton,
    required String namePositiveButton,
    Color colorPositiveButton = primary,
    required Function onPressedPositiveButton,
  }) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController controller = TextEditingController();
    controller.text = initialValue;
    Get.dialog(
      WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: titleSession(
            title: title,
            icon: titleIcon,
            iconColor: titleIconColor,
            iconSize: titleIconSize,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Form(
                key: formKey,
                child: TextFormField(
                  controller: controller,
                  maxLines: maxLine,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      prefixIcon,
                      color: prefixIconColor,
                      size: prefixIconSize,
                    ),
                    border: const UnderlineInputBorder(),
                    hintText: hint,
                    hintStyle: TextStyle(color: hintColor),
                  ),
                  validator: (value) => validator(value!),
                ),
              ),
            ],
          ),
          actions: [
            CCTextButton(
              text: nameNeutralButton.toUpperCase(),
              textColor: colorNeutralButton,
              onPressed: () => onPressedNeutralButton(),
            ),
            CCTextButton(
              text: namePositiveButton.toUpperCase(),
              textColor: colorPositiveButton,
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  Get.back();
                  onPressedPositiveButton(controller.text);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void dialogInputMonetaryValue({
    required String title,
    Color titleColor = onSurface,
    IconData? titleIcon,
    Color? titleIconColor = primary,
    double titleIconSize = 22,
    IconData? prefixIcon,
    Color? prefixIconColor = primary,
    double prefixIconSize = 22,
    required String initialValue,
    required String hint,
    Color hintColor = neutral,
    required String? Function(String) validator,
    required String nameNeutralButton,
    Color colorNeutralButton = neutral,
    required Function() onPressedNeutralButton,
    required String namePositiveButton,
    Color colorPositiveButton = primary,
    required Function onPressedPositiveButton,
  }) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController controller = TextEditingController();
    controller.text = initialValue;
    Get.dialog(
      WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: titleSession(
            title: title,
            icon: titleIcon,
            iconColor: titleIconColor,
            iconSize: titleIconSize,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Form(
                key: formKey,
                child: TextFormField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.end,
                  inputFormatters: [
                    CurrencyTextInputFormatter(
                      locale: "pt-BR",
                      symbol: "R\$",
                    ),
                  ],
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      prefixIcon,
                      color: prefixIconColor,
                      size: prefixIconSize,
                    ),
                    border: const UnderlineInputBorder(),
                    hintText: hint,
                    hintStyle: TextStyle(color: hintColor),
                  ),
                  validator: (value) => validator(value!),
                ),
              ),
            ],
          ),
          actions: [
            CCTextButton(
              text: nameNeutralButton.toUpperCase(),
              textColor: colorNeutralButton,
              onPressed: () => onPressedNeutralButton(),
            ),
            CCTextButton(
              text: namePositiveButton.toUpperCase(),
              textColor: colorPositiveButton,
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  Get.back();
                  onPressedPositiveButton(controller.text);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void dialogDropDown({
    required String title,
    Color titleColor = onSurface,
    IconData? icon,
    Color? iconColor = primary,
    double iconSize = 22,
    required String initialValue,
    required List<String> list,
    required String nameNeutralButton,
    Color colorNeutralButton = neutral,
    required Function() onPressedNeutralButton,
    required String namePositiveButton,
    Color colorPositiveButton = primary,
    required Function onPressedPositiveButton,
  }) {
    final RxString dropdownValue = initialValue.obs;
    Get.dialog(
      WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: titleSession(
            title: title,
            icon: icon,
            iconColor: iconColor,
            iconSize: iconSize,
          ),
          content: Obx(
            () => DropdownButton<String>(
              value: dropdownValue.value,
              isExpanded: true,
              items: list.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                  ),
                );
              }).toList(),
              onChanged: (String? value) {
                dropdownValue.value = value!;
              },
            ),
          ),
          actions: [
            CCTextButton(
              text: nameNeutralButton.toUpperCase(),
              textColor: colorNeutralButton,
              onPressed: () => onPressedNeutralButton(),
            ),
            CCTextButton(
              text: namePositiveButton.toUpperCase(),
              textColor: colorPositiveButton,
              onPressed: () {
                Get.back();
                onPressedPositiveButton(dropdownValue.value);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget titleSession({
    required String title,
    IconData? icon,
    Color? iconColor,
    double? iconSize,
  }) {
    return Row(
      children: [
        Visibility(
          visible: icon != null,
          child: Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Icon(
              icon,
              color: iconColor,
              size: iconSize,
            ),
          ),
        ),
        Flexible(
          child: Text(title),
        ),
      ],
    );
  }
}
