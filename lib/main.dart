import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(const MembershipApp());

class MembershipApp extends StatelessWidget {
  const MembershipApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.green[200],
        appBar: AppBar(
          backgroundColor: Colors.green[200],
          elevation: 0,
          title: Row(
            children: [
              Image.asset('assets/images/centralian_logo.png', height: 32),
              const SizedBox(width: 8),
              Text(
                'Centralian Membership Card',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        body: const SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: SizedBox(width: 350, child: MembershipCard()),
            ),
          ),
        ),
      ),
    );
  }
}

class MembershipCard extends StatelessWidget {
  const MembershipCard({super.key});

  // TODO: replace with your own values if these change
  static const String photoUrl =
      'https://res.cloudinary.com/ofe3srdc/image/upload/v1786542641/nikko_s_profile.jpg';
  static const String facebookUrl =
      'https://www.facebook.com/share/1LDPi8wTCY/';
  static const String memberName = 'Nikko Teopengco Delos Santos';
  static const String role =
      'Software Engineering Student of Central Philippine University';
  static const String memberId = 'ID No. 23-2477-54';

  Future<void> _launchFacebook() async {
    final Uri url = Uri.parse(facebookUrl);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $facebookUrl');
    }
  }

  Widget _detailChip(IconData icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: Colors.green[700]),
        const SizedBox(width: 4),
        Text(
          label,
          style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey[700]),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        // The card body
        Container(
          margin: const EdgeInsets.only(top: 55),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 65, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  memberName,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[800],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  role,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 12),
                const Divider(),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _detailChip(Icons.badge_outlined, memberId),
                    _detailChip(Icons.verified_outlined, 'Active'),
                  ],
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: _launchFacebook,
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.green[700],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.facebook,
                          color: Colors.white,
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Visit our Facebook',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // The circular photo, overlapping the top of the card
        Container(
          width: 100,
          height: 100,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(4),
          child: ClipOval(
            child: CachedNetworkImage(
              imageUrl: photoUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
              errorWidget: (context, url, error) =>
                  Icon(Icons.person, size: 50, color: Colors.grey[400]),
            ),
          ),
        ),
      ],
    );
  }
}
