import 'package:flutter/material.dart';
import 'package:modern_ecommerce/modern_ecommerce/theme/colors.dart';
import 'package:modern_ecommerce/modern_ecommerce/theme/text_styles.dart';
import 'package:modern_ecommerce/modern_ecommerce/widgets/common/base_screen.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Help & Support',
      body: ListView(
        children: [
          _buildFAQSection(),
          const SizedBox(height: 24),
          _buildContactSection(),
          const SizedBox(height: 24),
          _buildSupportTicketSection(),
        ],
      ),
    );
  }

  Widget _buildFAQSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: Text('Frequently Asked Questions', style: METextStyles.h3),
        ),
        Container(
          color: MEColors.cardBackground,
          child: ExpansionPanelList.radio(
            elevation: 0,
            children: _getFAQItems(),
          ),
        ),
      ],
    );
  }

  List<ExpansionPanelRadio> _getFAQItems() {
    final faqs = [
      {
        'question': 'How do I track my order?',
        'answer':
            'You can track your order by going to My Orders section and clicking on the Track Order button for the specific order.',
      },
      {
        'question': 'What payment methods do you accept?',
        'answer':
            'We accept credit/debit cards, PayPal, and various digital wallets including Apple Pay and Google Pay.',
      },
      {
        'question': 'How can I return an item?',
        'answer':
            'To return an item, go to My Orders, select the order containing the item you wish to return, and click on Return Item. Follow the instructions to complete the return process.',
      },
      {
        'question': 'What is your delivery timeframe?',
        'answer':
            'Standard delivery typically takes 3-5 business days. Express delivery options are available at checkout.',
      },
    ];

    return faqs.asMap().entries.map((entry) {
      return ExpansionPanelRadio(
        value: entry.key,
        headerBuilder: (context, isExpanded) {
          return ListTile(
            title: Text(
              entry.value['question']!,
              style: METextStyles.bodyLarge.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        },
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Text(entry.value['answer']!),
        ),
      );
    }).toList();
  }

  Widget _buildContactSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: Text('Contact Us', style: METextStyles.h3),
        ),
        Container(
          color: MEColors.cardBackground,
          child: Column(
            children: [
              _buildContactItem(
                icon: Icons.email_outlined,
                title: 'Email Support',
                subtitle: 'support@moderncommerce.com',
                onTap: () {},
              ),
              const Divider(height: 1),
              _buildContactItem(
                icon: Icons.phone_outlined,
                title: 'Phone Support',
                subtitle: '+1 (800) 123-4567',
                onTap: () {},
              ),
              const Divider(height: 1),
              _buildContactItem(
                icon: Icons.chat_outlined,
                title: 'Live Chat',
                subtitle: 'Available 24/7',
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContactItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: MEColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: MEColors.primary),
      ),
      title: Text(
        title,
        style: METextStyles.bodyLarge.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  Widget _buildSupportTicketSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: Text('Submit a Ticket', style: METextStyles.h3),
        ),
        Container(
          color: MEColors.cardBackground,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Can\'t find what you\'re looking for? Submit a support ticket and we\'ll get back to you within 24 hours.',
                style: METextStyles.bodyMedium.copyWith(
                  color: MEColors.textSecondary,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Create Support Ticket'),
              ),
            ],
          ),
        ),
      ],
    );
  }
} 