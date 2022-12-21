namespace Utils {
    public class Theme {
        public static void Load() {
            var provider = new Gtk.CssProvider();
            provider.load_from_resource("/com/vysp3r/ProtonPlus/application.css");
            Gtk.StyleContext.add_provider_for_display(Gdk.Display.get_default(),
                                                      provider,
                                                      Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);
        }
    }
}
