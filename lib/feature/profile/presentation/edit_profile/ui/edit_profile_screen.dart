import 'package:allmed/common/contants/global_core_constants.dart';
import 'package:allmed/common/core/presentation/abstract/bloc/core_bloc_builder.dart';
import 'package:allmed/common/core/presentation/abstract/bloc/core_state.dart';
import 'package:allmed/common/presentation/widgets/app_hbox_widget.dart';
import 'package:allmed/common/presentation/widgets/app_keyboard_dismisser.dart';
import 'package:allmed/common/presentation/widgets/app_label_textfield.dart';
import 'package:allmed/common/presentation/widgets/app_loading_widget.dart';
import 'package:allmed/common/presentation/widgets/app_snack_bar_widget.dart';
import 'package:allmed/common/presentation/widgets/app_wbox_widget.dart';
import 'package:allmed/common/theme/app_images.dart';
import 'package:allmed/common/theme/app_theme.dart';
import 'package:allmed/feature/auth/domain/entity/global_user_detail_entity.dart';
import 'package:allmed/feature/auth/presentation/global_auth/cubit/global_auth_cubit.dart';
import 'package:allmed/feature/profile/presentation/edit_profile/cubit/edit_profile_cubit.dart';
import 'package:allmed/feature/profile/presentation/edit_profile/ui/widgets/select_gender_modal.dart';
import 'package:allmed/feature/profile/presentation/edit_profile/ui/widgets/upload_avatar_widget.dart';
import 'package:allmed/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen(this.user, {Key? key}) : super(key: key);

  final GlobalUserDetailEntity user;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _iin;
  late TextEditingController _gender;
  late TextEditingController _firstName;
  late TextEditingController _phoneNumber;
  late TextEditingController _secondName;
  late TextEditingController _middleName;
  late TextEditingController _dateOfBirth;

  final _phoneNumberFormatter = MaskTextInputFormatter(
    mask: '### ### ## ##',
    filter: {"#": RegExp(r'\d')},
    type: MaskAutoCompletionType.lazy,
  );

  final _dob = MaskTextInputFormatter(
    mask: '##.##.####',
    filter: {"#": RegExp(r'\d')},
    type: MaskAutoCompletionType.lazy,
  );

  @override
  void initState() {
    super.initState();
    if (widget.user.gender != 0) {
      _gender =
          TextEditingController(text: widget.user.gender == 1 ? S.current.male : S.current.female);
    } else {
      _gender = TextEditingController();
    }
    _iin = TextEditingController(text: widget.user.iin);
    _middleName = TextEditingController(text: widget.user.middleName);
    _dateOfBirth = TextEditingController(text: widget.user.birthDay);
    _firstName = TextEditingController(text: widget.user.userName);
    _secondName = TextEditingController(text: widget.user.lastName);
    _phoneNumber = TextEditingController(text: widget.user.shortNumber);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditProfileCubit(),
      child: CoreUpgradeBlocBuilder<EditProfileCubit, CoreState>(
        listener: (context, state) {
          if (state is SuccessChangedUserDataState) {
            context.read<GlobalAuthCubit>().checkVerifyStatus();
            successSnackBar(context, 'Success changed');
            Navigator.pop(context);
          }
        },
        buildWhen: (_, state) => state is EditProfileCommonState,
        builder: (context, state) {
          if (state is EditProfileCommonState) {
            return AppKeyboardDismisser(
              child: AppLoadingWidget(
                isLoading: state.isLoading,
                child: Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    leadingWidth: 100,
                    centerTitle: false,
                    backgroundColor: Colors.white,
                    surfaceTintColor: Colors.white,
                    leading: Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Center(
                        child: TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            S.current.back,
                            style: AppTextStyle.caption1,
                          ),
                        ),
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => context.read<EditProfileCubit>().updateUserData(
                              _firstName.text,
                              _secondName.text,
                              middleName: _middleName.text,
                              gender: _gender.text,
                              iin: _iin.text,
                              bdy: _dateOfBirth.text,
                            ),
                        child: Text(
                          S.current.save,
                          style: AppTextStyle.caption1.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                      const WBox(12),
                    ],
                  ),
                  body: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        UploadAvatarWidget(widget.user.firstSymbol),
                        const HBox(46),
                        Text(
                          S.current.yourProfile,
                          style: GoogleFonts.ubuntu(
                            fontSize: 20,
                            color: AppColors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const HBox(8),
                        Text(
                          S.current.infoAboutUserUsedOnlyForUs,
                          style: GoogleFonts.ubuntu(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.gray,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(16),
                          margin: const EdgeInsets.only(top: 24, bottom: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppColors.lightGray),
                          ),
                          child: IntrinsicHeight(
                            child: Row(
                              children: [
                                Text(
                                  '+7',
                                  style: AppTextStyle.caption1,
                                ),
                                const VerticalDivider(
                                  color: AppColors.lightGray,
                                  indent: 0,
                                  width: 20,
                                  endIndent: 0,
                                ),
                                Expanded(
                                  child: TextField(
                                    readOnly: true,
                                    controller: _phoneNumber,
                                    style: AppTextStyle.caption1,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      hintText: '--- --- -- --',
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      counterText: GlobalCoreConstants.empty,
                                      labelStyle: AppTextStyle.secondary
                                          .copyWith(fontWeight: FontWeight.w400),
                                      hintStyle: AppTextStyle.caption1.copyWith(
                                        color: AppColors.gray,
                                      ),
                                      contentPadding: const EdgeInsets.only(bottom: 3),
                                    ),
                                    inputFormatters: [_phoneNumberFormatter],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        AppLabelTextFieldWidget(
                          label: S.current.yourName,
                          controller: _firstName,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        ),
                        const HBox(16),
                        AppLabelTextFieldWidget(
                          label: S.current.yourSecondName,
                          controller: _secondName,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        ),
                        const HBox(16),
                        AppLabelTextFieldWidget(
                          controller: _middleName,
                          label: S.current.middleNameNotImportant,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        ),
                        const HBox(16),
                        AppLabelTextFieldWidget(
                          isEnabled: false,
                          label: S.current.iin,
                          controller: _iin,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        ),
                        const HBox(16),
                        AppLabelTextFieldWidget(
                          hintTextValue: '01.01.2000',
                          label: S.current.dateOfBirth,
                          controller: _dateOfBirth,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          textInputFormatters: [_dob],
                        ),
                        const HBox(16),
                        AppLabelTextFieldWidget(
                          onTap: () => showSelectGenderModal(
                            context,
                            _gender.text,
                            (gender) => _gender.text = gender,
                          ),
                          label: S.current.gender,
                          controller: _gender,
                          readOnly: true,
                          trailing: Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: SvgPicture.asset(AppSvgIcons.icAltArrowDown),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        ),
                        const HBox(56),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _gender.dispose();
    _dateOfBirth.dispose();
    _iin.dispose();
    _firstName.dispose();
    _secondName.dispose();
    _middleName.dispose();
    _phoneNumber.dispose();
  }
}
