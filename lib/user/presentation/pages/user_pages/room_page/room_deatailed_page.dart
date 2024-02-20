import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:share/user/presentation/const/const_color.dart';
import 'package:share/user/presentation/widgets/common_widget.dart';

class RoomDeatailedShowingPage extends StatelessWidget {
  const RoomDeatailedShowingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: ListView(
          children: [
            Container(
              // margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: ConstColor().mainColorblue.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(20)),
              child: CarouselSlider(items: [], options: CarouselOptions()),
            ),
            Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'roomModel.hotelName',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.favorite,
                          size: 30,
                          color: Colors.red,
                        ),
                        onPressed: () {},
                      )
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.location_on, size: 20),
                Text(
                  // propertyModel.place,
                  'roomModel.place!',
                  style: Theme.of(context).textTheme.displayMedium,
                )
              ],
            ),
            Text('roomModel.roomNumber',
                style: Theme.of(context).textTheme.displayMedium),
            Text(
              '₹ }',
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(fontSize: 20),
            ),
            Row(
              children: [
                const Icon(
                  Icons.star,
                  size: 25,
                  color: Color.fromARGB(255, 230, 207, 5),
                ),
                Text(
                  // propertyModel.place,
                  '4.2 (250)',
                  style: Theme.of(context).textTheme.displaySmall,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Catogory',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                Text('view on Map')
              ],
            ),
            CommonWidget().bookingContainer(context: context),
            CommonWidget().totalpaymentContainer(context: context),
            Row(
              children: [
                CommonWidget().payNowButton(context: context),
                SizedBox(width: MediaQuery.of(context).size.width*0.03,),
                CommonWidget().bookAndPayAtHotel(context: context),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
