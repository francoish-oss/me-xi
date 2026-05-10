{ ... }:
{
  programs.plasma = {
    desktop = {
      mouseActions.rightClick = "contextmenu";

      widgets = [
        {
          name = "org.kde.plasma.icon";
          position = {
            horizontal = 100;
            vertical = 100;
          };
          size = {
            width = 100;
            height = 100;
          };
          config.General.url = "applications:firefox.desktop";
        }
      ];
    };

    # 2. THE PANEL (The Bottom Bar)
    panels = [
      {
        location = "bottom";
        widgets = [
          "org.kde.plasma.kickoff"          # Application Menu
          "org.kde.plasma.icontasks"        # Task Manager (Pinned/Open apps)
          "org.kde.plasma.marginsseparator" # Spacer
          "org.kde.plasma.systemtray"       # Tray (Wifi, Volume, Clock)
          "org.kde.plasma.digitalclock"     # Clock
        ];
      }
    ];

    # 3. WORKSPACE SETTINGS
    workspace = {
      clickItemTo = "open"; # Single-click to open
      lookAndFeel = "org.kde.breezedark.desktop";
    };
  };
}
