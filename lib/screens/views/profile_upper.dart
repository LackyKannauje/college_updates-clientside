// import 'package:college_updates/model/profile_model.dart';
// import 'package:college_updates/screens/setting.dart';
// import 'package:flutter/material.dart';

// class ProfileDescriptionView extends StatelessWidget {
//   const ProfileDescriptionView({
//     super.key,
//     required this.profileDetails,
//     required this.isMyAccount,
//   });

//   final ProfileModel profileDetails;
//   final bool isMyAccount;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             InkWell(
//               onTap: () {
//                 Navigator.pop(context);
//               },
//               child: Icon(
//                 Icons.arrow_back_ios,
//                 size: 20,
//               ),
//             ),
//             Text(
//               "${profileDetails.username}✅",
//               style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
//             ),
//             isMyAccount
//                 ? InkWell(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => SettingPage(),
//                         ),
//                       );
//                     },
//                     child: Icon(
//                       Icons.settings,
//                       size: 22,
//                     ),
//                   )
//                 : SizedBox(
//                     width: 20,
//                   )
//           ],
//         ),
//         SizedBox(height: 30),
//         Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(200),
//             border: Border.all(color: Color(0xFFC683E5), width: 2),
//           ),
//           child: ClipRRect(
//             child: Image.network(
//               profileDetails.profilePicture == ''
//                   ? "https://randomuser.me/api/portraits/thumb/women/81.jpg"
//                   : profileDetails.profilePicture,
//               height: 120,
//               width: 120,
//               fit: BoxFit.cover,
//             ),
//             borderRadius: BorderRadius.circular(200),
//           ),
//         ),
//         SizedBox(height: 15),
//         Text(
//           profileDetails.username,
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
//         ),
//         SizedBox(height: 10),
//         SizedBox(
//           width: 300,
//           child: Text(
//             profileDetails.bio,
//             style: TextStyle(
//               fontSize: 13,
//               color: Colors.grey,
//             ),
//             maxLines: 2,
//             textAlign: TextAlign.center,
//             overflow: TextOverflow.ellipsis,
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:college_updates/model/profile_model.dart';
import 'package:college_updates/screens/setting.dart';
import 'package:flutter/material.dart';

class ProfileDescriptionView extends StatelessWidget {
  const ProfileDescriptionView({
    Key? key,
    required this.profileDetails,
    required this.isMyAccount,
  }) : super(key: key);

  final ProfileModel profileDetails;
  final bool isMyAccount;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios, size: 20),
              ),
              Text(
                "${profileDetails.username}✅",
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              ),
              if (isMyAccount)
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingPage(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.settings, size: 22),
                )
              else
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_vert, size: 22),
                )
            ],
          ),
        ),
        const SizedBox(height: 30),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60),
            border: Border.all(color: Color(0xFFC683E5), width: 2),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(60),
            child: Image.network(
              profileDetails.profilePicture.isEmpty
                  ? "https://randomuser.me/api/portraits/thumb/women/81.jpg"
                  : profileDetails.profilePicture,
              height: 120,
              width: 120,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 15),
        Text(
          profileDetails.username,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: 300,
          child: Text(
            profileDetails.bio.isEmpty
                ? 'No bio available'
                : profileDetails.bio,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.grey,
            ),
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
