import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:intl/intl.dart";
import "package:page_penner/app/widgets/card/cc_card.dart";
import "package:page_penner/app/widgets/expansion_tile/cc_expansion_tile.dart";
import "package:page_penner/app/widgets/shimmer/cc_shimmer.dart";
import "package:page_penner/core/utils/color_utils.dart";
import "package:page_penner/core/utils/date_manager_utils.dart";
import "package:page_penner/core/values/colors.dart";
import "package:syncfusion_flutter_datepicker/datepicker.dart";

class CCCalendar extends StatelessWidget {
  final DateRangePickerController? controller;
  final RxString startDate;
  final RxString endDate;
  final RxDouble currentBalance;
  final RxBool isCalculatingCurrentBalance;
  final RxBool isExpanded;
  final Function(DateRangePickerSelectionChangedArgs) onSelectionChanged;
  final Function onSubmit;
  final Function onExpansionChanged;

  CCCalendar({
    Key? key,
    required this.controller,
    required this.startDate,
    required this.endDate,
    required this.currentBalance,
    required this.isCalculatingCurrentBalance,
    required this.isExpanded,
    required this.onSelectionChanged,
    required this.onSubmit,
    required this.onExpansionChanged,
  }) : super(key: key);

  // Utils
  final DateManagerUtils _dateManagerUtils = DateManagerUtils();
  final ColorUtils _colorUtils = ColorUtils();

  @override
  Widget build(BuildContext context) {
    return CCCard.surface(
      widgets: [
        Obx(
          () => CCExpansionTile(
            globalKey: GlobalKey(),
            title: "Pesquisar entre datas",
            subtitle: "${startDate.value} - ${endDate.value}",
            initiallyExpanded: isExpanded.value,
            onExpansionChanged: onExpansionChanged,
            widgets: [
              const Divider(color: outline),
              SfDateRangePicker(
                controller: controller,
                cancelText: "CANCELAR",
                confirmText: "OK",
                showTodayButton: false,
                onSelectionChanged: onSelectionChanged,
                selectionMode: DateRangePickerSelectionMode.range,
                showActionButtons: true,
                onCancel: () {
                  isExpanded.value = !isExpanded.value;
                  controller!.selectedRanges = null;
                },
                onSubmit: (val) {
                  isExpanded.value = !isExpanded.value;
                  onSubmit(context);
                },
                initialSelectedRange: PickerDateRange(
                  _dateManagerUtils.getFirstDayMonth(),
                  _dateManagerUtils.getLastDayMonth(),
                ),
              ),
            ],
          ),
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Saldo total atual: ",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            Obx(
              () => Visibility(
                visible: isCalculatingCurrentBalance.value == false,
                replacement: const CCShimmer(),
                child: Text(
                  NumberFormat.simpleCurrency(locale: "pt-br")
                      .format(currentBalance.value),
                  style: TextStyle(
                    color: _colorUtils.isRedValue(currentBalance.value),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
