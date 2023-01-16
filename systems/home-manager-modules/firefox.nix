{
  config,
  pkgs,
  withGUI,
  ...
}: let
  defaultSettings = {
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
in {
  programs.firefox = {
    enable = withGUI;
    extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      onepassword-password-manager
      ublock-origin
    ];
    profiles.default = {
      id = 0;
      name = "James";
      isDefault = true;
      # // allows you to add overrides to the default settings
      settings =
        defaultSettings
        // {
          "app.update.auto" = false;
          "browser.startup.homepage" = "https://lobste.rs";
        };
    };
  };
}
