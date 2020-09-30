import 'package:bacg/model/app_state.dart';
import 'package:bacg/services/local_data.service.dart';
import 'package:flutter/material.dart';
import 'package:bacg/components/custom_button.dart';
import 'package:provider/provider.dart';

class Rules extends StatelessWidget {
  Rules({Key key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        child: Column(
          children: [
            Text("Terms and conditions",
                style: Theme.of(context).textTheme.headline1),
            SizedBox(
              height: 8,
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In in augue nec elit ornare tempus. Sed finibus sem pretium, cursus lectus quis, blandit odio. Phasellus rutrum ipsum eu maximus semper. Mauris vulputate ipsum sed turpis faucibus, et blandit tortor mollis. Nam ultricies mi a elit molestie interdum. Phasellus et libero eget dui ultrices maximus. Morbi euismod sem quis dui eleifend dapibus. Phasellus sagittis ligula vel lorem mattis mattis. Vivamus quis ligula iaculis, euismod est volutpat, efficitur sem. Aenean ut dui at lacus consectetur venenatis id at mauris. Mauris nec erat scelerisque, hendrerit ipsum non, sagittis orci. Pellentesque et dolor a odio fringilla elementum sed elementum est. Sed pharetra magna id lorem pellentesque cursus. Quisque at arcu nec odio mollis facilisis. Sed ac est in orci dapibus egestas sit amet vehicula tortor. Phasellus eget magna vitae libero finibus blandit. Morbi tempus est in velit ultrices, et dapibus justo ullamcorper. Proin molestie est non efficitur placerat. Vestibulum vel augue eu lacus ullamcorper condimentum. In dignissim dolor nec lacus volutpat, sit amet pellentesque justo dignissim. Nam eu est quis nulla aliquet ullamcorper. Proin vel sapien aliquet, efficitur ipsum sed, convallis lacus. Duis at sem non diam rhoncus ultricies eleifend a ex. Suspendisse sed lorem tempor, pharetra mi quis, sagittis purus. Nullam id turpis ac lacus volutpat tincidunt vel quis elit. Vestibulum at diam vel ipsum convallis vestibulum. Sed ac turpis quis massa consectetur faucibus. Phasellus quis sem mattis, posuere eros et, tincidunt leo. Maecenas dignissim tortor nec mollis volutpat. Vivamus vel justo eu leo viverra facilisis a et tellus. Nullam sit amet quam ut sem facilisis posuere. Duis vitae arcu ac sem tempus facilisis. Nam blandit arcu in ante ullamcorper, ac auctor massa varius. Donec in dolor in felis blandit aliquet. Sed blandit augue ut ligula tempor commodo. Duis auctor eros vitae libero ullamcorper vehicula at in lacus.",
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            !Provider.of<AppState>(context, listen: false).rulesAccepted
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BacgButton(
                          text: "Decline",
                          type: ButtonType.Warning,
                          onPressed: () {
                            Provider.of<AppState>(context, listen: false)
                                .logout();
                          }),
                      SizedBox(
                        width: 30,
                      ),
                      BacgButton(
                          text: "Accept",
                          type: ButtonType.Action,
                          onPressed: () {
                            Provider.of<AppState>(context, listen: false)
                                .acceptRules();
                            // LocalData.getInstance.acceptRules();
                          }),
                    ],
                  )
                : SizedBox(
                    height: 0,
                  ),
          ],
        ),
      ),
    );
  }
}
