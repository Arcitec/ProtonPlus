namespace ProtonPlus {
    public class Application : Adw.Application {
        Stores.Preferences preferences;

        public Application () {
            Object (application_id: "com.vysp3r.ProtonPlus", flags : ApplicationFlags.FLAGS_NONE);
        }

        construct {
            ActionEntry[] action_entries = {
                { "preferences", this.on_preferences_action },
                { "telegram", () => Gtk.show_uri (null, "https://t.me/ProtonPlusOfficial", Gdk.CURRENT_TIME) },
                { "documentation", () => Gtk.show_uri (null, "https://github.com/Vysp3r/ProtonPlus/wiki", Gdk.CURRENT_TIME) },
                { "donation", () => Gtk.show_uri (null, "https://www.youtube.com/watch?v=dQw4w9WgXcQ", Gdk.CURRENT_TIME) },
                { "about", this.on_about_action },
                { "quit", this.quit }
            };
            this.add_action_entries (action_entries, this);
        }

        public override void activate () {
            base.activate ();

            preferences = new Stores.Preferences ();
            if (Manager.Preferences.Load (ref preferences)) {
                Manager.Preferences.Apply (ref preferences);
                Manager.Themes.Load ();

                new Windows.Home (this);
            } else {
                stderr.printf ("There was an error loading the preferences and it will prevent the application from opening.\n");
            }
        }

        void on_about_action () {
            string[] devs = { "Charles Malouin (Vysp3r) https://github.com/Vysp3r" };
            string[] designers = { "Charles Malouin (Vysp3r) https://github.com/Vysp3r" };
            string[] thanks = {
                "GNOME Project https://www.gnome.org/",
                "ProtonUp-Qt Project https://davidotek.github.io/protonup-qt/",
                "LUG Helper Project https://github.com/starcitizen-lug/lug-helper",
                "Lahey"
            };

            var aboutDialog = new Adw.AboutWindow ();

            aboutDialog.set_application_name ("ProtonPlus");
            aboutDialog.set_application_icon ("com.vysp3r.ProtonPlus");
            aboutDialog.set_version ("v0.2.1");
            aboutDialog.set_comments ("A simple Wine and Proton-based compatiblity tools manager for GNOME");
            aboutDialog.add_link ("Github", "https://github.com/Vysp3r/ProtonPlus");
            aboutDialog.set_release_notes ("<ul>
                <li>🔨 Update appdata</li>
                <li>🐛 Fix tool renaming for nothing</li>
                <li>🐛 Fix selector window freezing</li>
                <li>🐛 Fix Gtk-Critical errors</li>
                <li>💬 Update the release notes</li>
            </ul>");
            aboutDialog.set_issue_url ("https://github.com/Vysp3r/ProtonPlus/issues/new/choose");
            aboutDialog.set_copyright ("© 2022 Vysp3r");
            aboutDialog.set_license_type (Gtk.License.GPL_3_0);
            aboutDialog.set_developers (devs);
            aboutDialog.set_designers (designers);
            aboutDialog.add_credit_section ("Special thanks to", thanks);

            aboutDialog.show ();
        }

        void on_preferences_action () {
            new ProtonPlus.Windows.Preferences (ref preferences);
        }
    }
}
