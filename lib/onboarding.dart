import 'package:flutter/material.dart';

const _backgroundColor = Color(0xFFE8D5D5);
const _pointColor = Color(0xFF24466B);
const _buttonColor = Color(0xFFF1AF39);

class Onboarding extends StatefulWidget {
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final _pageController = PageController();
  int _currentPage = 0;
  static const _countPages = 3;

  void _changePage(int index) {
    setState(() => _currentPage = index);
    _pageController.animateToPage(_currentPage,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) => setState(() => _currentPage = index),
                children: [
                  _Page(
                    assetUrl: 'assets/onboarding.png',
                    title: 'Шаг 1',
                    description: _description,
                  ),
                  _Page(
                    assetUrl: 'assets/onboarding2.png',
                    title: 'Шаг 2',
                    description: _description,
                  ),
                  _Page(
                    assetUrl: 'assets/onboarding3.png',
                    title: 'Шаг 3',
                    description: _description,
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.green,
              height: 15,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (var i = 0; i < _countPages; i++)
                    _PagePoint(i == _currentPage),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: 85,
              // color: Colors.green,
              child: _currentPage == _countPages - 1
                  ? Container(
                      color: _buttonColor,
                      alignment: Alignment.center,
                      child: const Text(
                        'Стартануть!',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _currentPage == 0
                            ? const SizedBox.shrink()
                            : _LeftButton(
                                onPressed: () => _changePage(_currentPage - 1),
                              ),
                        _RightButton(
                          onPressed: () => _changePage(_currentPage + 1),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Page extends StatelessWidget {
  final String assetUrl;
  final String title;
  final String description;

  const _Page({
    required this.assetUrl,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(
            image: AssetImage(
              assetUrl,
            ),
            fit: BoxFit.fitHeight,
            height: 450,
          ),
          const SizedBox(height: 30),
          Center(
            child: Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              description,
              style: const TextStyle(fontSize: 16),
              overflow: TextOverflow.ellipsis,
              maxLines: 5,
            ),
          ),
        ],
      );
}

class _PagePoint extends StatelessWidget {
  final bool _isActive;

  const _PagePoint(this._isActive);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: AnimatedContainer(
        height: 15,
        width: 15,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _isActive ? _pointColor : Colors.grey,
        ),
        duration: const Duration(milliseconds: 200),
      ),
    );
  }
}

class _LeftButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _LeftButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return _Button(
      onTap: onPressed,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          const Icon(Icons.arrow_back),
          const Align(
            child: const Text(
              'Назад',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

class _RightButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _RightButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return _Button(
      onTap: onPressed,
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          const Align(
            child: const Text(
              'Вперед',
              style: TextStyle(fontSize: 16),
            ),
          ),
          const Icon(Icons.arrow_forward),
        ],
      ),
    );
  }
}

class _Button extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  const _Button({required this.child, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 140,
        height: 60,
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          color: Colors.orange,
        ),
        child: child,
      ),
    );
  }
}

const _description =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.';
