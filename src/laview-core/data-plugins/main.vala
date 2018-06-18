using LAview, Core, GObject.Plugins;

extern const string GETTEXT_PACKAGE;

namespace LAview.DataExample {
	/**
	 * Data Plugin Example.
	 */
	public class Plugin : LAview.Core.PluginData {

		PreferencesDialog preferences_dialog = null;
		AppSettings settings;

		/**
		 * Constructs a new ``Plugin``.
		 */
		construct {
			// Initialize the data object, open database connection for example.
			stdout.puts ("DataExample.Plugin init () called\n");
			AppDirs.init ();
			try {
				settings = new AppSettings();
			} catch (Error err) {
				stderr.printf("Error: %s\n", err.message);
			}
		}

		/**
		 * Destroys the ``Plugin``.
		 */
		~Plugin () {
			// Deinitialize the data object, close database connection for example.
			stdout.puts ("DataExample.Plugin deinit () called\n");
		}

		/**
		 * Get plugin name.
		 */
		public override string get_name () {
			return "DataExample";
		}

		/**
		 * Any abstract method realization for PluginData.
		 */
		public override string get_readable_name () {
			return _("Data Example");
		}

		/**
		 * Open Preferences.
		 */
		public override void preferences (Object parent) throws Error {
			if (preferences_dialog == null) preferences_dialog = new PreferencesDialog (parent);

			preferences_dialog.show_all ();
		}

		/**
		 * transfer string data
		 */
		public string get_string_data (string id) {
			switch (id) {
				case "SampleRequest": return "Sample Answer";
				case "AnotherRequest": return "Another Answer";
				case "Manual.SampleRequest": return "Manual Sample Answer";
				case "MainChart":
					var cache_dir = (host as IHostCore).get_cache_dir ();
					// TODO: save picture in path: cache_dir + "MainChart.png";

					return "MainChart";
			}
			return "";
		}

		/**
		 * transfer array1D data
		 */
		public string[] get_array1d_data (string id) {
			return { "A1d", "B1d", "C1d", "D1d", "E1d" };
		}

		/**
		 * transfer array1D data
		 */
		public string[,] get_array2d_data (string id) {
			return { { "A2d", "B2d", "C2d", "D2d", "E2d"},
			         { "F2d", "G2d", "H2d", "I2d", "J2d"},
			         { "K2d", "L2d", "M2d", "N2d", "O2d"},
			         { "P2d", "Q2d", "R2d", "S2d", "T2d"},
			         { "U2d", "V2d", "W2d", "X2d", "Y2d"},
			       };
		}
	}
}

[ModuleInit]
Type plugin_init (GLib.TypeModule type_module) {
	return typeof (LAview.DataExample.Plugin);
}
