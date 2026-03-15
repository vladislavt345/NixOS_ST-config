{ config, pkgs, ... }:

{
  environment.systemPackages = [ pkgs.deepfilternet ];

  services.pipewire.extraConfig.pipewire."99-deepfilter" = {
    "context.modules" = [
      {
        name = "libpipewire-module-filter-chain";
        args = {
          "node.description" = "DeepFilter Noise Cancelling";
          "media.name"       = "DeepFilter Noise Cancelling";
          "filter.graph" = {
            nodes = [
              {
                type    = "ladspa";
                name    = "deep_filter";
                plugin  = "${pkgs.deepfilternet}/lib/ladspa/libdeep_filter_ladspa.so";
                label   = "deep_filter_mono";
                control = {
                  "Attenuation Limit (dB)" = 100;
                };
              }
            ];
          };
          "audio.rate"     = 48000;
          "audio.channels" = 1;
          "audio.position" = [ "MONO" ];
          "capture.props" = {
            "node.name"          = "effect_input.deep_filter";
            "media.class"        = "Audio/Sink";
            "audio.rate"         = 48000;
            "audio.channels"     = 1;
            "stream.capture.sink" = true;
            "node.passive"       = true;
          };
          "playback.props" = {
            "node.name"      = "effect_output.deep_filter";
            "media.class"    = "Audio/Source";
            "audio.rate"     = 48000;
            "audio.channels" = 1;
          };
        };
      }
      {
        name = "libpipewire-module-loopback";
        args = {
          "node.description" = "DeepFilter Loopback";
          "capture.props" = {
            "node.name"  = "loopback.deep_filter";
            "node.target" = "alsa_input.pci-0000_00_1b.0.analog-stereo";
            "audio.rate" = 48000;
          };
          "playback.props" = {
            "node.name"   = "loopback.deep_filter.out";
            "node.target" = "effect_input.deep_filter";
            "audio.rate"  = 48000;
          };
        };
      }
    ];
  };
}
