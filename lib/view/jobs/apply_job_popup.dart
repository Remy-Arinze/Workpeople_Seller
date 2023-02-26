import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer_seller/services/app_string_service.dart';
import 'package:qixer_seller/services/jobs/job_details_service.dart';
import 'package:qixer_seller/view/utils/common_helper.dart';
import 'package:qixer_seller/view/utils/constant_styles.dart';
import 'package:qixer_seller/view/utils/custom_input.dart';
import 'package:qixer_seller/view/utils/others_helper.dart';
import 'package:qixer_seller/view/profile/components/textarea_field.dart';

class ApplyJobPopup extends StatelessWidget {
  const ApplyJobPopup({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final priceController = TextEditingController();
    final coverController = TextEditingController();

    return Consumer<JobDetailsService>(
      builder: (context, provider, child) => Consumer<AppStringService>(
        builder: (context, ln, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Name ============>
            // CommonHelper().labelCommon('Your offer price'),

            CustomInput(
              controller: priceController,
              validation: (value) {
                if (value == null || value.isEmpty) {
                  return ln.getString('Please enter a price');
                }
                return null;
              },
              hintText: ln.getString('Offer price'),
              paddingHorizontal: 20,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(
              height: 5,
            ),

            TextareaField(
              hintText: ln.getString('Cover letter'),
              notesController: coverController,
            ),

            sizedBoxCustom(20),

            CommonHelper().buttonPrimary('Apply', () {
              if (provider.applyLoading == true) return;

              if (double.tryParse(priceController.text.trim()) == null) {
                //if not integer value
                OthersHelper().showToast(
                    ln.getString(ln.getString('You must enter a valid price')),
                    Colors.black);
                return;
              }
              print('job id ${provider.jobDetails.id}');

              provider.applyToJob(context,
                  buyerId: provider.jobDetails.buyerId,
                  jobPostId: provider.jobDetails.id,
                  offerPrice: priceController.text,
                  coverLetter: coverController.text,
                  jobPrice: provider.jobDetails.price);
            }, isloading: provider.applyLoading),
          ],
        ),
      ),
    );
  }
}
