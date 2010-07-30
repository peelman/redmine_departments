#Redmine Departments Plugin
##About
We needed to be able to track Departments as a separate entity in Redmine, with more flexibility and power than adding Custom Attributes allowed for.  Thus, Redmine\_Departments was born.  You can track departments, as well as basic contact information for each department, and relate departments to issues (many/many relationship).
###Features
+ Permissions for Viewing, Creating, and Removing Departments
+ Permissions for Viewing, Creating, and Removing Issue->Department relationships

###Version
+ Currently at 1.0
+ Requires Redmine 0.9.x (built/tested on 0.9.6, untested on previous versions, but it should work...)
+ Due to a change in Redmine 1.0, Departments won't work without some tweaking.  See my cc\_addresses plugin for details, as it shares the same issue.

###Bugs
+ If you find any bugs, or want to request a feature, feel free to contact me (info below) or create an issue here on GitHub.

###Usage
####Install
+ Requires Will\_Paginate gem to be installed
1. `cd [redmine]/vendor/plugins/`
2. `git clone http://github.com/peelman/redmine_departments.git`
3. `rake db:migrate_plugins`
4. `touch [redmine]/tmp/restart.txt`
5. Profit?

####Enabling and Permissions
+ Needs to be enabled per-project in the Modules tab
+ Permissions are set via the traditional role method

##Author
Nick Peelman

- Email: nick \[at\] peelman \[dot\] us
- Web: [peelman.us](http://peelman.us)
- Github: [Github.com/peelman](http://github.com/peelman)

##Credits
Inspiration and guidance provided by:

+ Daniel Vandersluis's Redmine Resources plugin \(http://github.com/dvandersluis/redmine_resources\)
+ Extra Special Thanks to Chris Moore (http://github.com/cdmwebs)

##Licensing
+ This plugin is open-source and licensed under the "GNU General Public License v2"  See: [GPL 2.0 Website](http://www.gnu.org/licenses/old-licenses/gpl-2.0.html) for more info.
+ &copy; 2010 Nick Peelman