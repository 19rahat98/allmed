import 'package:allmed/common/contants/global_core_constants.dart';
import 'package:allmed/common/presentation/widgets/app_hbox_widget.dart';
import 'package:allmed/common/presentation/widgets/app_modal_header.dart';
import 'package:allmed/common/theme/app_images.dart';
import 'package:allmed/common/theme/app_theme.dart';
import 'package:allmed/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectGenderModal extends StatefulWidget {
  const SelectGenderModal({
    Key? key,
    required this.gender,
    required this.onChangeGender,
  }) : super(key: key);

  final String gender;
  final Function(String) onChangeGender;

  @override
  State<SelectGenderModal> createState() => _SelectGenderModalState();
}

class _SelectGenderModalState extends State<SelectGenderModal> {
  var _isMale = true;

  @override
  void initState() {
    _isMale = widget.gender == S.current.male;
    if (widget.gender == GlobalCoreConstants.empty) {
      widget.onChangeGender.call(S.current.male);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppModalHeader(
            onTap: () => Navigator.pop(context),
            S.current.selectSex,
          ),
          const HBox(12),
          InkWell(
            onTap: () {
              setState(() => _isMale = true);
              widget.onChangeGender.call(_isMale ? S.current.male : S.current.female);
            },
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 20,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      S.current.male,
                      style: GoogleFonts.ubuntu(
                        fontSize: 16,
                        color: AppColors.black,
                        fontWeight: _isMale ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _isMale,
                    child: SvgPicture.asset(AppSvgIcons.icTickCircle),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() => _isMale = false);
              widget.onChangeGender.call(_isMale ? S.current.male : S.current.female);
            },
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 20,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      S.current.female,
                      style: GoogleFonts.ubuntu(
                        fontSize: 16,
                        color: AppColors.black,
                        fontWeight: !_isMale ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: !_isMale,
                    child: SvgPicture.asset(AppSvgIcons.icTickCircle),
                  ),
                ],
              ),
            ),
          ),
          const HBox(24),
        ],
      ),
    );
  }
}

Future<String?> showSelectGenderModal(
  BuildContext context,
  String gender,
  Function(String) onChangeGender,
) {
  return showModalBottomSheet<String>(
    context: context,
    elevation: 0,
    enableDrag: true,
    useSafeArea: true,
    useRootNavigator: true,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
    ),
    backgroundColor: Colors.white,
    barrierColor: Colors.black.withOpacity(0.4),
    builder: (context) => SelectGenderModal(gender: gender, onChangeGender: onChangeGender),
  );
}
