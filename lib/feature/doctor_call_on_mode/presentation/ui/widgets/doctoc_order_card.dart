import 'package:allmed/common/presentation/widgets/star_rating.dart';
import 'package:allmed/common/theme/app_images.dart';
import 'package:allmed/common/theme/app_theme.dart';
import 'package:allmed/feature/doctor_service/data/model/doctor_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class DoctorOrderCard extends StatelessWidget {
  const DoctorOrderCard({
    super.key,
    this.onTap,
    required this.doctor,
    this.enableSelect = true,
  });

  final DoctorModel doctor;
  final Function()? onTap;
  final bool enableSelect;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: doctor.enable ? 1 : 0.3,
      child: ListTile(
        onTap: onTap,
        dense: true,
        title: Text(
          doctor.name,
          style: GoogleFonts.ubuntu(
            fontSize: 16,
            color: AppColors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        minVerticalPadding: 0,
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: AppStarRating(rating: doctor.doctorRating, size: 16),
        ),
        leading: CircleAvatar(
          radius: 20,
          backgroundImage: NetworkImage(doctor.image),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 38,
              child: IconButton(
                onPressed: () {},
                padding: EdgeInsets.zero,
                icon: SvgPicture.asset(AppSvgIcons.icInfoCircleFilled),
              ),
            ),
            Visibility(
              visible: enableSelect,
              child: Container(
                width: 24,
                height: 24,
                margin: const EdgeInsets.only(left: 8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.lightGray, width: 2),
                ),
              ),
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        tileColor: doctor.enable ? AppColors.superGray : Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }
}
