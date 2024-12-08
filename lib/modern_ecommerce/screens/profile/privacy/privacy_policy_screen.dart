import 'package:flutter/material.dart';
import 'package:modern_ecommerce/modern_ecommerce/theme/colors.dart';
import 'package:modern_ecommerce/modern_ecommerce/theme/text_styles.dart';
import 'package:modern_ecommerce/modern_ecommerce/widgets/common/base_screen.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Privacy Policy',
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection(
            title: 'Introduction',
            content:
                'This Privacy Policy describes how we collect, use, and handle your personal information when you use our services.',
          ),
          _buildSection(
            title: 'Information We Collect',
            content: '''
• Personal Information: Name, email address, phone number, and billing information.
• Device Information: IP address, browser type, and operating system.
• Usage Data: How you interact with our services.
• Location Data: Your general location based on IP address.
''',
          ),
          _buildSection(
            title: 'How We Use Your Information',
            content: '''
• To provide and maintain our services
• To notify you about changes to our services
• To provide customer support
• To gather analysis or valuable information
• To detect, prevent and address technical issues
''',
          ),
          _buildSection(
            title: 'Data Security',
            content:
                'We implement appropriate security measures to protect against unauthorized access, alteration, disclosure, or destruction of your personal information.',
          ),
          _buildSection(
            title: 'Third-Party Services',
            content:
                'We may employ third-party companies and individuals to facilitate our service, provide service-related services, or assist us in analyzing how our service is used.',
          ),
          _buildSection(
            title: 'Your Rights',
            content: '''
You have the right to:
• Access your personal data
• Correct inaccurate data
• Request deletion of your data
• Object to data processing
• Request data portability
''',
          ),
          _buildSection(
            title: 'Contact Us',
            content:
                'If you have any questions about this Privacy Policy, please contact us at privacy@moderncommerce.com',
          ),
          const SizedBox(height: 24),
          Text(
            'Last updated: March 15, 2024',
            style: METextStyles.bodySmall.copyWith(
              color: MEColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required String content,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: METextStyles.h3,
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: METextStyles.bodyMedium,
          ),
        ],
      ),
    );
  }
} 