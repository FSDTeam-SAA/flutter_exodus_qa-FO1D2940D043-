import 'package:exodus/core/constants/app/app_gap.dart';
import 'package:exodus/presentation/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(title: const Text('About App')),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi lobortis risus eget magna euismod rhoncus. Vivamus eu lectus a lectus interdum placerat. Praesent consectetur ante orci, non mattis massa posuere in. Integer blandit ut mi eu efficitur. Praesent congue, arcu vitae malesuada vehicula, lacus velit facilisis velit, ut vehicula sapien erat id dui. Proin nisi ante, ullamcorper vitae libero eu, mollis venenatis lectus. Integer auctor et sem at sollicitudin. Sed eget diam nisi. Nulla in id.',
            textAlign: TextAlign.justify,
          ),

          Gap.h16,
          const Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi lobortis risus eget magna euismod rhoncus. Vivamus eu lectus a lectus interdum placerat. Praesent consectetur ante orci, non mattis massa posuere in. Integer blandit ut mi eu efficitur. Praesent congue, arcu vitae malesuada vehicula, lacus velit facilisis velit, ut vehicula sapien erat id dui. Proin nisi ante, ullamcorper vitae libero eu, mollis venenatis lectus. Integer auctor et sem at sollicitudin. Sed eget diam nisi. Nulla in id.',
            textAlign: TextAlign.justify,
          ),

          Gap.h16,
          const Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi lobortis risus eget magna euismod rhoncus. Vivamus eu lectus a lectus interdum placerat. Praesent consectetur ante orci, non mattis massa posuere in. Integer blandit ut mi eu efficitur. Praesent congue, arcu vitae malesuada vehicula, lacus velit facilisis velit, ut vehicula sapien erat id dui. Proin nisi ante, ullamcorper vitae libero eu, mollis venenatis lectus. Integer auctor et sem at sollicitudin. Sed eget diam nisi. Nulla in id.',
            textAlign: TextAlign.justify,
          ),
          
          Gap.h16,
          const Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi lobortis risus eget magna euismod rhoncus. Vivamus eu lectus a lectus interdum placerat. Praesent consectetur ante orci, non mattis massa posuere in. Integer blandit ut mi eu efficitur. Praesent congue, arcu vitae malesuada vehicula, lacus velit facilisis velit, ut vehicula sapien erat id dui. Proin nisi ante, ullamcorper vitae libero eu, mollis venenatis lectus. Integer auctor et sem at sollicitudin. Sed eget diam nisi. Nulla in id.',
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
