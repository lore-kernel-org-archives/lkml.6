Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751654AbeEMOUc (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 10:20:32 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:46506 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751263AbeEMOU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 10:20:28 -0400
X-Google-Smtp-Source: AB8JxZqg6FczTERVn686GR0zPZqUi9rOy5hsSewo0JWkKO3CF5DhSt9Cm0iSho37Y9HdB5eiIe29rlmxUkjAP7/PBiU=
MIME-Version: 1.0
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Sun, 13 May 2018 19:50:27 +0530
Message-ID: <CAG=yYwkWt9bbKVWD93YT2S3jFQCt7s5yV7gxOw=JScFJtgO0NA@mail.gmail.com>
Subject: PROBLEM: "ACPI Error: Method parse/execution failed" and "ACPI BIOS
 Error (bug): Failure looking up" related
To: robert.moore@intel.com, erik.schmauss@intel.com,
        rafael.j.wysocki@intel.com, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hello ,

the error from "dmesg -l err"  related ...

------------------------------------------------------------------------------------------------->

[    1.709950] ACPI BIOS Error (bug): Failure looking up
[\_SB.PCI0.LPCB.HEC.ECWT], AE_NOT_FOUND (20180313/psargs-330)
[    1.710045] ACPI Error: Method parse/execution failed
\_TZ.FN00._ON, AE_NOT_FOUND (20180313/psparse-516)
[    1.710208] ACPI BIOS Error (bug): Failure looking up
[\_SB.PCI0.LPCB.HEC.ECWT], AE_NOT_FOUND (20180313/psargs-330)
[    1.710267] ACPI Error: Method parse/execution failed
\_TZ.FN00._ON, AE_NOT_FOUND (20180313/psparse-516)
[    1.710338] acpi PNP0C0B:00: Failed to set initial power state
[    1.710846] ACPI BIOS Error (bug): Failure looking up
[\_SB.PCI0.LPCB.HEC.ECRD], AE_NOT_FOUND (20180313/psargs-330)
[    1.710938] ACPI Error: Method parse/execution failed
\_TZ.TZ00._TMP, AE_NOT_FOUND (20180313/psparse-516)
[    1.711588] ACPI BIOS Error (bug): Failure looking up
[\_SB.PCI0.LPCB.HEC.ECRD], AE_NOT_FOUND (20180313/psargs-330)
[    1.711681] ACPI Error: Method parse/execution failed
\_TZ.TZ00._TMP, AE_NOT_FOUND (20180313/psparse-516)
[    1.711960] ACPI BIOS Error (bug): Failure looking up
[\_SB.PCI0.LPCB.HEC.ECRD], AE_NOT_FOUND (20180313/psargs-330)
[    1.712054] ACPI Error: Method parse/execution failed
\_TZ.TZ01._TMP, AE_NOT_FOUND (20180313/psparse-516)
[    1.712471] ACPI BIOS Error (bug): Failure looking up
[\_SB.PCI0.LPCB.HEC.ECRD], AE_NOT_FOUND (20180313/psargs-330)
[    1.712552] ACPI Error: Method parse/execution failed
\_TZ.TZ01._TMP, AE_NOT_FOUND (20180313/psparse-516)

----------------------------------------------------------------------------------------------------->



$awk -f scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux debian 4.17.0-rc4+ #24 SMP Sat May 12 19:26:27 IST 2018 x86_64 GNU/Linux

GNU Make            4.2.1
Binutils            2.30
Util-linux          2.31.1
Mount                2.31.1
Linux C Library      2.27
Dynamic linker (ldd) 2.27
readlink: missing operand
Try 'readlink --help' for more information.
Procps              3.3.14
Kbd                  2.0.4
Console-tools        2.0.4
Sh-utils            8.28
Udev                238
Modules Loaded      ac acpi_pad acpi_thermal_rel ahci autofs4 battery
binfmt_misc bluetooth bnep btbcm btintel btrfs btrtl btusb button
cdrom cfg80211 cmac coretemp cpuid crc32c_intel crc32_pclmul
crct10dif_pclmul cryptd drm drm_kms_helper ecdh_generic efi_pstore
efivarfs efivars ehci_hcd ehci_pci evdev fan fat fuse
ghash_clmulni_intel hid hp_wireless hp_wmi i2c_algo_bit i2c_hid
i2c_i801 i915 int3400_thermal int340x_thermal_zone intel_cstate
intel_pch_thermal intel_powerclamp intel_rapl intel_rapl_perf
intel_soc_dts_iosf intel_uncore ip_tables irqbypass
iTCO_vendor_support iTCO_wdt joydev kvm kvm_intel libahci libata
libcrc32c loop lp lpc_ich media mei mei_me mfd_core mii nls_ascii
nls_cp437 parport parport_pc pcspkr ppdev processor_thermal_device
psmouse r8169 raid6_pq rfcomm rfkill scsi_mod sd_mod serio_raw sg
shpchp snd snd_hda_codec snd_hda_codec_generic snd_hda_codec_hdmi
snd_hda_codec_realtek snd_hda_core snd_hda_intel snd_hwdep snd_pcm
snd_timer soundcore sparse_keymap sr_mod sunrpc thermal usbcore
uvcvideo vfat video videobuf2_common videobuf2_memops videobuf2_v4l2
videobuf2_vmalloc videodev wl wmi wmi_bmof x86_pkg_temp_thermal xfs
xhci_hcd xhci_pci xor x_tables xxhash zstd_compress zstd_decompress


$uname -a
Linux debian 4.17.0-rc4+ #24 SMP Sat May 12 19:26:27 IST 2018 x86_64 GNU/Linux
$

Reported-by: Jeffrin Jose T  <jeffrin@rajagiritech.edu.in>

-- 
software engineer
rajagiri school of engineering and technology
