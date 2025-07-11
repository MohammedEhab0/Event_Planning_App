import 'package:event_planning_app/Utils/AppColors.dart';
import 'package:flutter/material.dart';

import '../../../Modal/Event.dart';
import '../../../Utils/AppStyle.dart';
import 'MapTabProvider.dart';

class EventCardItem extends StatelessWidget {
  final Event event;


  final MapsTabProvider provider;

  const EventCardItem({super.key, required this.event, required this.provider});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      width: width * 0.9,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).secondaryHeaderColor,
        border: Border.all(color: Theme.of(context).primaryColor),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(width: width *.5,height:height,
                event.image,
                fit: BoxFit.cover,
              ),
            ),

          const SizedBox(width: 12), // spacing between image and text
          Expanded( // This prevents overflow by constraining text content
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis, // if title is too long
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                     Icon(
                      Icons.location_on_outlined,
                      color: AppColors.black,
                      size: 20,
                    ),
                    const SizedBox(width: 4),
                    Flexible(
                      child: Text(
                        '${event.city}, ${event.country}',
                        style: AppStyle.bold16Black,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
