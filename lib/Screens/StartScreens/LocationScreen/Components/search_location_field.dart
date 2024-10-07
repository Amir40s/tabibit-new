import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/constant.dart';

import '../../../../Providers/Location/location_provider.dart';
import '../../../../model/res/constant/app_icons.dart';

class SearchLocationField extends StatelessWidget {
  const SearchLocationField({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationProvider>(
      builder: (context, provider, child) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              child: TextFormField(
                onTap: (){
                  provider.suggestions = true;
                },
                onChanged: (value){
                  provider.onChanged(value.toString());
                },
                controller: provider.searchController,

                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 3.h,horizontal: 20),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(AppIcons.radioIcon,height: 35,),
                  ),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius. circular(20.0)),
                    borderSide: BorderSide(
                      color: themeColor
                    )
                  ),
                  focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius. circular(20.0)),
                      borderSide: BorderSide(
                          color: themeColor
                      )
                  ),
                  enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius. circular(20.0)),
                      borderSide: BorderSide(
                          color: themeColor
                      )
                  ),
                  hintText: "Search Places with Name",
                ),
              ),
            ),
            provider.suggestions == true ? SizedBox(
                height: 30.h,
                width: 100.w,
                child: ListView.builder(
                    itemCount: provider.placesList.length,
                    itemBuilder: (context,index){
                      return GestureDetector(
                        onTap: () async {
                          provider.suggestions = false;
                          FocusScope.of(context).unfocus();
                          List<Location> locations = await locationFromAddress(
                              provider.placesList[index]["description"]
                          );
                          provider.moveLocation(locations.last.latitude, locations.last.longitude,index);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          width: 100.w,
                          decoration: const BoxDecoration(color: Colors.white),
                          child: Text(provider.placesList[index]["description"]),
                        ),
                      );
                    }))
                :const SizedBox(),
          ],
        );
    },);
  }
}
