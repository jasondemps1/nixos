{ inputs, ... }:
{
  imports = [ inputs.ucodenix.nixosModules.ucodenix ];

  services.ucodenix = {
    enable = true;
    cpuSerialNumber = "0087-0F10-0000-0000-0000-0000"; # cpuid | sed -n 's/^.*processor serial number = //p' | head -n1
  };
}

