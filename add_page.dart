import 'dart:io';

///Usage dart run add_page.dart new_page_name
///do not include page at the end it will be added where needed
void main(List<String> args) {
  final rootDir =
      Directory.current.path; // Gets the directory where the script was called

  if (args.isEmpty) {
    throw Exception('No page name passed as argument e.g new_page');
  }

  String page_name = args[0];

  ///Convert to pascal Case for the class name usage
  String PageName = _toPascalCase(page_name);

  print(PageName);

  final directories = [
    '$rootDir/lib/ui/pages/$page_name',
    '$rootDir/lib/ui/pages/$page_name/view_model',
    '$rootDir/lib/ui/pages/$page_name/widgets',
  ];

  final files = {
    '$rootDir/lib/ui/pages/$page_name/${page_name}_page.dart': _newPageContent(PageName),
    '$rootDir/lib/ui/pages/$page_name/view_model/${page_name}_page_view_model.dart': _newPageViewModelContent(PageName),
  };

 // Create directories
  for (final dir in directories) {
    Directory(dir).createSync(recursive: true);
    print('Created directory: $dir');
  }

  // Create files
  files.forEach((path, content) {
    File(path).writeAsStringSync(content);
    print('Created file: $path');
  });

}

///Placeholder for the new page view model

String _newPageViewModelContent(String pageName)=>'''
import 'package:flutter/material.dart';

class ${pageName}PageViewModel extends ChangeNotifier {  
}

''';

///Placeholder for the new page

String _newPageContent(String pageName) => '''
import 'package:flutter/material.dart';

class ${pageName}Page extends StatelessWidget {
  const ${pageName}Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(      
      body: Placeholder(),
    );
  }
}
''';

String _toPascalCase(String input) {
  return input
      .split('_')
      .map(
        (word) =>
            word.isNotEmpty
                ? word[0].toUpperCase() + word.substring(1).toLowerCase()
                : '',
      )
      .join('');
}
