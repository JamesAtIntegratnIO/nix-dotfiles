{
  config,
  pkgs,
  withGUI,
  ...
}: {
  # Add cert for pfsense
  age = {
    identityPaths = [
      "/etc/ssh/ssh_host_ed25519_key"
      "/home/boboysdadda/.ssh/id_ed25519"
    ];
    secrets.pfsense_ca = {
      file = ../../secrets/lappy-pfsense-ca.age;
      name = "pfsense-ca.pem";
      mode = "444";
    };
  };
  # Add cert for pfsense
  programs.firefox = {
    enable = true;
    preferencesStatus = "default";
    # Read more about policies here: https://github.com/mozilla/policy-templates/blob/master/README.md
    policies = {
      # To get extension details navigate to `manage extensions` > `cog wheel` > `debug addons`. You can find the info there
      Certificates = {
        ImportEnterpriseRoots = true;
        Install = [
          config.age.secrets.pfsense_ca.path
        ];
      };
      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
        };
        "{d634138d-c276-4fc8-924b-40a0ea21d284}" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/file/3918810/1password-latest-fx.xpi";
        };
        "jid0-adyhmvsP91nUO8pRv0Mn2VKeB84@jetpack" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4040837/raindropio-latest.xpi";
        };
      };
      ExtensionUpdate = true;
      OfferToSaveLogins = false;
      DisableTelemetry = true;
      DNSOverHTTPS = {
        Enabled = false;
      };
      DontCheckDefaultBrowser = true;
      EnableTrackingProtection = {
        Value = true;
        Cryptomining = true;
        Fingerprinting = true;
        Exceptions = [];
      };
      FirefoxHome = {
        Search = true;
        TopSites = false;
        SponsoredTopSites = false;
        Highlights = false;
        Pocket = false;
        SponsoredPocket = false;
        Snippets = false;
      };
      NetworkPrediction = false;
      OverrideFirstRunPage = "";
      OverridePostUpdatePage = "";
      PasswordManagerEnabled = false;
      ShowHomeButton = true;
      StartDownloadsInTempDirectory = true;
    };
    # This is copied out of a semi sane export from ffprofile.com
    preferences = {
      "app.normandy.api_url" = "";
      "app.normandy.enabled" = false;
      "app.shield.optoutstudies.enabled" = false;
      "app.update.auto" = false;
      "beacon.enabled" = false;
      "breakpad.reportURL" = "";
      "browser.aboutConfig.showWarning" = false;
      "browser.cache.offline.enable" = false;
      "browser.crashReports.unsubmittedCheck.autoSubmit" = false;
      "browser.crashReports.unsubmittedCheck.autoSubmit2" = false;
      "browser.crashReports.unsubmittedCheck.enabled" = false;
      "browser.disableResetPrompt" = true;
      "browser.newtab.preload" = false;
      "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
      "browser.newtabpage.enhanced" = false;
      "browser.newtabpage.introShown" = true;
      "browser.safebrowsing.appRepURL" = "";
      "browser.safebrowsing.blockedURIs.enabled" = false;
      "browser.safebrowsing.downloads.enabled" = false;
      "browser.safebrowsing.downloads.remote.enabled" = false;
      "browser.safebrowsing.downloads.remote.url" = "";
      "browser.safebrowsing.enabled" = false;
      "browser.safebrowsing.malware.enabled" = false;
      "browser.safebrowsing.phishing.enabled" = false;
      "browser.selfsupport.url" = "";
      "browser.send_pings" = false;
      "browser.sessionstore.privacy_level" = 0;
      "browser.shell.checkDefaultBrowser" = false;
      "browser.startup.homepage_override.mstone" = "ignore";
      "browser.tabs.crashReporting.sendReport" = false;
      "browser.tabs.firefox-view" = false;
      "browser.urlbar.groupLabels.enabled" = false;
      "browser.urlbar.quicksuggest.enabled" = false;
      "browser.urlbar.speculativeConnect.enabled" = false;
      "browser.urlbar.trimURLs" = false;
      "datareporting.healthreport.service.enabled" = false;
      "datareporting.healthreport.uploadEnabled" = false;
      "datareporting.policy.dataSubmissionEnabled" = false;
      "toolkit.telemetry.archive.enabled" = false;
      "toolkit.telemetry.bhrPing.enabled" = false;
      "toolkit.telemetry.cachedClientID" = "";
      "toolkit.telemetry.enabled" = false;
      "toolkit.telemetry.firstShutdownPing.enabled" = false;
      "toolkit.telemetry.hybridContent.enabled" = false;
      "toolkit.telemetry.newProfilePing.enabled" = false;
      "toolkit.telemetry.prompted" = 2;
      "toolkit.telemetry.rejected" = true;
      "toolkit.telemetry.reportingpolicy.firstRun" = false;
      "toolkit.telemetry.server" = "";
      "toolkit.telemetry.shutdownPingSender.enabled" = false;
      "toolkit.telemetry.unified" = false;
      "toolkit.telemetry.unifiedIsOptIn" = false;
      "toolkit.telemetry.updatePing.enabled" = false;
      "experiments.enabled" = false;
      "extensions.greasemonkey.stats.optedin" = false;
      "extensions.greasemonkey.stats.url" = "";
      "extensions.pocket.enabled" = false;
      "extensions.shield-recipe-client.enabled" = false;
      "device.sensors.enabled" = false;
      "network.dns.disablePrefetch" = true;
      "network.dns.disablePrefetchFromHTTPS" = true;
      "network.allow-experiments" = false;
      "network.captive-portal-service.enabled" = false;
      "network.cookie.cookieBehavior" = 1;
      "network.http.referer.spoofSource" = true;
      "network.http.speculative-parallel-limit" = 0;
      "network.predictor.enable-prefetch" = false;
      "network.predictor.enabled" = false;
      "network.prefetch-next" = false;
      "privacy.donottrackheader.enabled" = true;
      "privacy.donottrackheader.value" = 1;
      "privacy.query_stripping" = true;
      "privacy.trackingprotection.cryptomining.enabled" = true;
      "privacy.trackingprotection.enabled" = true;
      "privacy.trackingprotection.fingerprinting.enabled" = true;
      "privacy.trackingprotection.pbmode.enabled" = true;
      "privacy.usercontext.about_newtab_segregation.enabled" = true;
    };
  };
}
