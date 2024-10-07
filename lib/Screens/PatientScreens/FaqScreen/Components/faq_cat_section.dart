import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/Providers/FaqProvider/faq_provider.dart';

import '../../../../constant.dart';
import '../../FindDoctorScreen/Components/suggestion_container.dart';

class FaqCatSection extends StatelessWidget {
  FaqCatSection({super.key});

  final List<Map<String, String>> suggestion = [
    {'title': 'General'},
    {'title': 'Login'},
    {'title': 'Account'},
    {'title': 'Doctor'},
    {'title': 'Label'},
  ];


  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 40,
        width: 100.w,
        child: Consumer<FaqProvider>(
          builder: (context, provider, child) {
            return ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.only(left: 20),
              scrollDirection: Axis.horizontal,
              itemCount: suggestion.length,
              itemBuilder: (context, index) {
                final isSelected = provider.selectFaqCat == index;
                return GestureDetector(
                  onTap: () {
                    provider.setFaqCat(index);
                  },
                  child: SuggestionContainer(
                      text: suggestion[index]["title"]!,
                      boxColor: isSelected ? themeColor : bgColor,
                      textColor: isSelected ? bgColor : themeColor),
                );
              },);
          },)
    );
  }
}
