import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Bannière animée discrète (soleil + rayons + tajine + vapeur)
/// A poser sur chaque page (en fond) pour une touche orientale.
class OrientalBanner extends StatefulWidget {
  const OrientalBanner({
    super.key,
    this.size = 180,
    this.opacity = 0.12,
    this.alignment = Alignment.topRight,
    this.margin = const EdgeInsets.only(top: 24, right: 16),
    this.speed = const Duration(seconds: 18),
  });

  /// Taille globale de l’animation (carré).
  final double size;

  /// Opacité globale pour rester subtile.
  final double opacity;

  /// Position dans le Stack.
  final Alignment alignment;

  /// Marge par rapport aux bords.
  final EdgeInsets margin;

  /// Vitesse de rotation des rayons / ondulation vapeur.
  final Duration speed;

  @override
  State<OrientalBanner> createState() => _OrientalBannerState();
}

class _OrientalBannerState extends State<OrientalBanner>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: widget.speed)..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorSun = const Color(0xFFF6A21A); // soleil doré
    final colorRay = const Color(0xFFE88E0C);
    final colorTagine = const Color(0xFF8B4A2B); // terre cuite
    final colorSteam = const Color(0xFFFFE2B9);

    return Align(
      alignment: widget.alignment,
      child: Padding(
        padding: widget.margin,
        child: IgnorePointer(
          child: Opacity(
            opacity: widget.opacity,
            child: AnimatedBuilder(
              animation: _ctrl,
              builder: (_, __) {
                return CustomPaint(
                  size: Size.square(widget.size),
                  painter: _BannerPainter(
                    t: _ctrl.value,
                    colorSun: colorSun,
                    colorRay: colorRay,
                    colorTagine: colorTagine,
                    colorSteam: colorSteam,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _BannerPainter extends CustomPainter {
  _BannerPainter({
    required this.t,
    required this.colorSun,
    required this.colorRay,
    required this.colorTagine,
    required this.colorSteam,
  });

  final double t;
  final Color colorSun;
  final Color colorRay;
  final Color colorTagine;
  final Color colorSteam;

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width * 0.65;
    final cy = size.height * 0.35;
    final sunRadius = size.shortestSide * 0.18;

    // Fond radial léger (halo chaud)
    final halo = Paint()
      ..shader = RadialGradient(
        colors: [
          colorSun.withOpacity(0.35),
          Colors.transparent,
        ],
      ).createShader(Rect.fromCircle(center: Offset(cx, cy), radius: sunRadius * 2.2));
    canvas.drawCircle(Offset(cx, cy), sunRadius * 2.2, halo);

    // Rayons (rotation)
    final raysPaint = Paint()
      ..color = colorRay
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final rayCount = 14;
    final baseAngle = t * 2 * math.pi;
    for (int i = 0; i < rayCount; i++) {
      final a = baseAngle + (i * 2 * math.pi / rayCount);
      final r1 = sunRadius * 1.2;
      final r2 = sunRadius * 1.9 + math.sin(t * 2 * math.pi + i) * 2;
      final p1 = Offset(cx + r1 * math.cos(a), cy + r1 * math.sin(a));
      final p2 = Offset(cx + r2 * math.cos(a), cy + r2 * math.sin(a));
      canvas.drawLine(p1, p2, raysPaint);
    }

    // Soleil
    final sunPaint = Paint()..color = colorSun;
    canvas.drawCircle(Offset(cx, cy), sunRadius, sunPaint);

    // Tajine (base + couvercle)
    final baseY = size.height * 0.78;
    final baseW = size.width * 0.46;
    final baseH = size.height * 0.10;
    final baseRect = Rect.fromCenter(
        center: Offset(size.width * 0.42, baseY), width: baseW, height: baseH);

    final taginePaint = Paint()..color = colorTagine;
    final rrect = RRect.fromRectAndRadius(baseRect, const Radius.circular(18));
    canvas.drawRRect(rrect, taginePaint);

    // Couvercle conique
    final top = Path()
      ..moveTo(baseRect.left + baseW * 0.15, baseRect.top)
      ..lineTo(size.width * 0.42, baseRect.top - baseH * 1.4)
      ..lineTo(baseRect.right - baseW * 0.15, baseRect.top)
      ..close();
    canvas.drawPath(top, taginePaint);

    // Poignée du couvercle
    canvas.drawCircle(
        Offset(size.width * 0.42, baseRect.top - baseH * 1.55), 4.5, taginePaint);

    // Vapeur (trois courbes qui ondulent)
    final steamPaint = Paint()
      ..color = colorSteam
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < 3; i++) {
      final dx = size.width * (0.33 + i * 0.06);
      final h = baseH * (1.2 + i * 0.15);
      final wave = Path();
      final wobble = math.sin((t * 2 * math.pi) + i) * 6;
      wave.moveTo(dx, baseRect.top - 6);
      wave.cubicTo(
        dx - 8 - wobble, baseRect.top - h * 0.6,
        dx + 10 + wobble, baseRect.top - h * 1.1,
        dx, baseRect.top - h * 1.5,
      );
      canvas.drawPath(wave, steamPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _BannerPainter oldDelegate) =>
      oldDelegate.t != t;
}
