import 'package:flutter/material.dart';
import 'package:modern_ecommerce/modern_ecommerce/theme/colors.dart';

class SuccessPopup extends StatefulWidget {
  final String title;
  final String message;
  final String buttonText;
  final VoidCallback? onPressed;

  const SuccessPopup({
    super.key,
    required this.title,
    required this.message,
    required this.buttonText,
    this.onPressed,
  });

  @override
  State<SuccessPopup> createState() => _SuccessPopupState();
}

class _SuccessPopupState extends State<SuccessPopup> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _iconScaleAnimation;
  late Animation<double> _rippleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
    );

    _iconScaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: 1.4),
        weight: 60,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 1.4, end: 1.0),
        weight: 40,
      ),
    ]).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    ));

    _rippleAnimation = Tween<double>(
      begin: 1.0,
      end: 2.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
    ));

    // Start the animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Success Icon with ripple effect
              SizedBox(
                height: 120,
                width: 120,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Ripple circles
                    AnimatedBuilder(
                      animation: _rippleAnimation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _rippleAnimation.value,
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: MEColors.primary.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                          ),
                        );
                      },
                    ),
                    AnimatedBuilder(
                      animation: _rippleAnimation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _rippleAnimation.value * 0.8,
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: MEColors.primary.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                          ),
                        );
                      },
                    ),
                    // Main icon
                    ScaleTransition(
                      scale: _iconScaleAnimation,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: MEColors.primary.withOpacity(0.1),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: MEColors.primary.withOpacity(0.3),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.check_circle,
                          color: MEColors.primary,
                          size: 40,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Success Text with fade animation
              FadeTransition(
                opacity: _fadeAnimation,
                child: Column(
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.message,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Continue Button with fade animation
              FadeTransition(
                opacity: _fadeAnimation,
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _controller.reverse().then((_) {
                        if (widget.onPressed != null) {
                          widget.onPressed!();
                        } else {
                          Navigator.of(context).pop();
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MEColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                    child: Text(
                      widget.buttonText,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}