import 'package:flutter/material.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      // CRITICAL: Always explicitly set initialRoute and register '/' in routes
      initialRoute: '/',
      routes: {
        '/': (context) => const PortfolioHomePage(),
      },
    );
  }
}

class PortfolioHomePage extends StatefulWidget {
  const PortfolioHomePage({super.key});

  @override
  State<PortfolioHomePage> createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage> {
  final ScrollController _scrollController = ScrollController();
  
  // Keys to identify sections for scrolling
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Check if the screen is wide enough to show the desktop navigation
    final isDesktop = MediaQuery.of(context).size.width > 800;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'DevPortfolio', 
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2)
        ),
        elevation: 2,
        actions: isDesktop
            ? [
                TextButton(
                  onPressed: () => _scrollToSection(_homeKey), 
                  child: const Text('Home')
                ),
                TextButton(
                  onPressed: () => _scrollToSection(_aboutKey), 
                  child: const Text('About')
                ),
                TextButton(
                  onPressed: () => _scrollToSection(_projectsKey), 
                  child: const Text('Projects')
                ),
                TextButton(
                  onPressed: () => _scrollToSection(_contactKey), 
                  child: const Text('Contact')
                ),
                const SizedBox(width: 24),
              ]
            : null,
      ),
      drawer: isDesktop
          ? null
          : Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Menu', 
                          style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text('Home'), 
                    onTap: () { 
                      Navigator.pop(context); 
                      _scrollToSection(_homeKey); 
                    }
                  ),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('About'), 
                    onTap: () { 
                      Navigator.pop(context); 
                      _scrollToSection(_aboutKey); 
                    }
                  ),
                  ListTile(
                    leading: const Icon(Icons.work),
                    title: const Text('Projects'), 
                    onTap: () { 
                      Navigator.pop(context); 
                      _scrollToSection(_projectsKey); 
                    }
                  ),
                  ListTile(
                    leading: const Icon(Icons.mail),
                    title: const Text('Contact'), 
                    onTap: () { 
                      Navigator.pop(context); 
                      _scrollToSection(_contactKey); 
                    }
                  ),
                ],
              ),
            ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            HeroSection(key: _homeKey, onContactPressed: () => _scrollToSection(_contactKey)),
            AboutSection(key: _aboutKey),
            ProjectsSection(key: _projectsKey),
            ContactSection(key: _contactKey),
            const FooterSection(),
          ],
        ),
      ),
    );
  }
}

class HeroSection extends StatelessWidget {
  final VoidCallback onContactPressed;
  
  const HeroSection({super.key, required this.onContactPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 120, horizontal: 20),
      alignment: Alignment.center,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: Column(
          children: [
            CircleAvatar(
              radius: 80, 
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: Icon(
                Icons.person_outline, 
                size: 80, 
                color: Theme.of(context).colorScheme.onPrimaryContainer
              )
            ),
            const SizedBox(height: 32),
            Text(
              'Hi, I am a Web Developer', 
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'I build beautiful, responsive web applications using modern technologies.', 
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.grey[400]
              ), 
              textAlign: TextAlign.center
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: onContactPressed,
              icon: const Icon(Icons.arrow_forward),
              label: const Text('Get In Touch'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.3),
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
      alignment: Alignment.center,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About Me', 
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary
              )
            ),
            const SizedBox(height: 24),
            const Text(
              'I am a passionate software developer with experience in building responsive web and mobile applications. I love solving complex problems, learning new technologies, and creating intuitive user experiences that make an impact.', 
              style: TextStyle(fontSize: 18, height: 1.6)
            ),
            const SizedBox(height: 40),
            Text(
              'My Skills', 
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                'HTML5', 'CSS3', 'JavaScript', 'TypeScript', 
                'React', 'Flutter', 'Dart', 'Node.js', 
                'Git', 'Responsive Design', 'UI/UX'
              ].map((skill) => Chip(
                label: Text(skill),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
              )).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 800;
    
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
      alignment: Alignment.center,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1000),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Featured Projects', 
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary
              )
            ),
            const SizedBox(height: 40),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isDesktop ? 3 : 1,
                crossAxisSpacing: 24,
                mainAxisSpacing: 24,
                childAspectRatio: 0.85,
              ),
              itemCount: 3,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4,
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          color: Colors.grey[800],
                          width: double.infinity,
                          child: const Icon(Icons.web, size: 64, color: Colors.white38),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Project Title ${index + 1}', 
                                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'A responsive web application built with modern frontend technologies.',
                                style: TextStyle(color: Colors.grey[400], fontSize: 14),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const Spacer(),
                              TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(padding: EdgeInsets.zero),
                                child: const Text('View Details'),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.3),
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
      alignment: Alignment.center,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Column(
          children: [
            Text(
              'Contact Me', 
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary
              )
            ),
            const SizedBox(height: 16),
            const Text(
              'Interested in working together? Drop me a message!',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 40),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Name', 
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person)
              )
            ),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Email', 
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email)
              )
            ),
            const SizedBox(height: 20),
            const TextField(
              maxLines: 5, 
              decoration: InputDecoration(
                labelText: 'Message', 
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              )
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Message sent successfully!'))
                  );
                },
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.all(20),
                  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                ),
                child: const Text('Send Message'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      color: Colors.black26,
      alignment: Alignment.center,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.code)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.link)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            '© 2024 DevPortfolio. Built with Flutter for Web.', 
            style: TextStyle(color: Colors.white54)
          ),
        ],
      ),
    );
  }
}
