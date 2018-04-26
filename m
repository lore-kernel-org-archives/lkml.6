Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752549AbeDZDGP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 23:06:15 -0400
Received: from mail-oi0-f51.google.com ([209.85.218.51]:37674 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751525AbeDZDGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 23:06:10 -0400
X-Google-Smtp-Source: AIpwx49Gh77QFE6U60INX/K1fa9HcTSOmK5DfdIHAzMGsp+89kK0nW/4ETzmVrtu1mwXJax6RLkCQw==
Message-ID: <9f3043be59108e5c7f75786ce11cf1018aa15880.camel@redhat.com>
Subject: Re: issues with suspend on Dell XPS 13 2-in-1
From: Dennis Gilmore <dgilmore@redhat.com>
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Mario.Limonciello@dell.com" <Mario.Limonciello@dell.com>
Date: Wed, 25 Apr 2018 22:06:03 -0500
In-Reply-To: <1524708778.7505.1.camel@intel.com>
References: <6ce634cb82617c2a9a060ba6e2accef2a15dcc15.camel@redhat.com>
         <b7c4434319bf4ff8877f882d219a60ba@ausx13mpc120.AMER.DELL.COM>
         <1524005977.31134.15.camel@intel.com>
         <CAJesf3MUUGo_MVpr9+8zy-Nm5OAuYu1uwo2z50T2KcN-G5B5ew@mail.gmail.com>
         <1524708778.7505.1.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1 (3.28.1-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

Yes I have latest bios, I have version 1.3.1 that was released on 18th
of  Feb.

Dennis

El jue, 26-04-2018 a las 02:13 +0000, Pandruvada, Srinivas escribió:
> 
> I see around 43% PC10 residency with power drop of 0.7W.
> Do you have the latest BIOS of Dell 9365?
> 
> 
> Thanks,
> Srinivas
> 
> On Fri, 2018-04-20 at 08:36 -0500, Dennis Gilmore wrote:
> > Here is the full output 
> > 
> > # turbostat
> > turbostat version 17.06.23 - Len Brown <lenb@kernel.org>
> > CPUID(0): GenuineIntel 22 CPUID levels; family:model:stepping
> > 0x6:8e:9 (6:142:9)
> > CPUID(1): SSE3 MONITOR SMX EIST TM2 TSC MSR ACPI-TM TM
> > CPUID(6): APERF, TURBO, DTS, PTM, HWP, HWPnotify, HWPwindow,
> > HWPepp, No-HWPpkg, EPB
> > cpu0: MSR_IA32_MISC_ENABLE: 0x00850089 (TCC EIST No-MWAIT PREFETCH
> > TURBO)
> > CPUID(7): SGX
> > cpu0: MSR_IA32_FEATURE_CONTROL: 0x0000ff07 (Locked )
> > CPUID(0x15): eax_crystal: 2 ebx_tsc: 134 ecx_crystal_hz: 0
> > TSC: 1608 MHz (24000000 Hz * 134 / 2 / 1000000)
> > CPUID(0x16): base_mhz: 1600 max_mhz: 3600 bus_mhz: 100
> > cpu0: MSR_MISC_PWR_MGMT: 0x00401cc0 (ENable-EIST_Coordination
> > DISable-EPB DISable-OOB)
> > RAPL: 58254 sec. Joule Counter Range, at 4 Watts
> > cpu0: MSR_PLATFORM_INFO: 0x804043df1011000
> > 4 * 100.0 = 400.0 MHz max efficiency frequency
> > 16 * 100.0 = 1600.0 MHz base frequency
> > cpu0: MSR_IA32_POWER_CTL: 0x0024005d (C1E auto-promotion: DISabled)
> > cpu0: MSR_TURBO_RATIO_LIMIT: 0x22222224
> > 34 * 100.0 = 3400.0 MHz max turbo 4 active cores
> > 34 * 100.0 = 3400.0 MHz max turbo 3 active cores
> > 34 * 100.0 = 3400.0 MHz max turbo 2 active cores
> > 36 * 100.0 = 3600.0 MHz max turbo 1 active cores
> > cpu0: MSR_CONFIG_TDP_NOMINAL: 0x0000000d (base_ratio=13)
> > cpu0: MSR_CONFIG_TDP_LEVEL_1: 0x0006001c (PKG_MIN_PWR_LVL1=0
> > PKG_MAX_PWR_LVL1=0 LVL1_RATIO=6 PKG_TDP_LVL1=28)
> > cpu0: MSR_CONFIG_TDP_LEVEL_2: 0x00100038 (PKG_MIN_PWR_LVL2=0
> > PKG_MAX_PWR_LVL2=0 LVL2_RATIO=16 PKG_TDP_LVL2=56)
> > cpu0: MSR_CONFIG_TDP_CONTROL: 0x00000000 ( lock=0)
> > cpu0: MSR_TURBO_ACTIVATION_RATIO: 0x0000000c
> > (MAX_NON_TURBO_RATIO=12 lock=0)
> > cpu0: MSR_PKG_CST_CONFIG_CONTROL: 0x1e008008 (UNdemote-C3,
> > UNdemote-C1, demote-C3, demote-C1, locked: pkg-cstate-limit=8:
> > unlimited)
> > cpu0: POLL: CPUIDLE CORE POLL IDLE
> > cpu0: C1: MWAIT 0x00
> > cpu0: C1E: MWAIT 0x01
> > cpu0: C3: MWAIT 0x10
> > cpu0: C6: MWAIT 0x20
> > cpu0: C7s: MWAIT 0x33
> > cpu0: C8: MWAIT 0x40
> > cpu0: C9: MWAIT 0x50
> > cpu0: C10: MWAIT 0x60
> > cpu0: cpufreq driver: intel_pstate
> > cpu0: cpufreq governor: powersave
> > cpufreq intel_pstate no_turbo: 0
> > cpu0: MSR_MISC_FEATURE_CONTROL: 0x00000000 (L2-Prefetch L2-
> > Prefetch-pair L1-Prefetch L1-IP-Prefetch)
> > cpu0: MSR_PM_ENABLE: 0x00000001 (HWP)
> > cpu0: MSR_HWP_CAPABILITIES: 0x01060d24 (high 36 guar 13 eff 6 low
> > 1)
> > cpu0: MSR_HWP_REQUEST: 0x80002404 (min 4 max 36 des 0 epp 0x80
> > window 0x0 pkg 0x0)
> > cpu0: MSR_HWP_INTERRUPT: 0x00000000 (Dis_Guaranteed_Perf_Change,
> > Dis_Excursion_Min)
> > cpu0: MSR_HWP_STATUS: 0x00000000 (No-Guaranteed_Perf_Change, No-
> > Excursion_Min)
> > cpu0: MSR_IA32_ENERGY_PERF_BIAS: 0x00000006 (balanced)
> > cpu0: MSR_RAPL_POWER_UNIT: 0x000a0e03 (0.125000 Watts, 0.000061
> > Joules, 0.000977 sec.)
> > cpu0: MSR_PKG_POWER_INFO: 0x00000024 (4 W TDP, RAPL 0 - 0 W,
> > 0.000000 sec.)
> > cpu0: MSR_PKG_POWER_LIMIT: 0x420078009c8048 (UNlocked)
> > cpu0: PKG Limit #1: ENabled (9.000000 Watts, 24.000000 sec, clamp
> > DISabled)
> > cpu0: PKG Limit #2: DISabled (15.000000 Watts, 0.002441* sec, clamp
> > DISabled)
> > cpu0: MSR_DRAM_POWER_LIMIT: 0x5400de00000000 (UNlocked)
> > cpu0: DRAM Limit: DISabled (0.000000 Watts, 0.000977 sec, clamp
> > DISabled)
> > cpu0: MSR_PP0_POLICY: 0
> > cpu0: MSR_PP0_POWER_LIMIT: 0x00000000 (UNlocked)
> > cpu0: Cores Limit: DISabled (0.000000 Watts, 0.000977 sec, clamp
> > DISabled)
> > cpu0: MSR_PP1_POLICY: 0
> > cpu0: MSR_PP1_POWER_LIMIT: 0x00000000 (UNlocked)
> > cpu0: GFX Limit: DISabled (0.000000 Watts, 0.000977 sec, clamp
> > DISabled)
> > cpu0: MSR_IA32_TEMPERATURE_TARGET: 0x0a640080 (100 C)
> > cpu0: MSR_IA32_PACKAGE_THERM_STATUS: 0x88380802 (44 C)
> > cpu0: MSR_IA32_PACKAGE_THERM_INTERRUPT: 0x00000003 (100 C, 100 C)
> > cpu0: MSR_PKGC3_IRTL: 0x0000884e (valid, 79872 ns)
> > cpu0: MSR_PKGC6_IRTL: 0x00008876 (valid, 120832 ns)
> > cpu0: MSR_PKGC7_IRTL: 0x00008894 (valid, 151552 ns)
> > cpu0: MSR_PKGC8_IRTL: 0x000088fa (valid, 256000 ns)
> > cpu0: MSR_PKGC9_IRTL: 0x0000894c (valid, 339968 ns)
> > cpu0: MSR_PKGC10_IRTL: 0x00008bf2 (valid, 1034240 ns)
> > Core    CPU    Avg_MHz    Busy%    Bzy_MHz    TSC_MHz    IRQ   
> > SMI    C1    C1E    C3    C6    C7s    C8    C9    C10    C1%   
> > C1E%    C3%    C6%    C7s%    C8%    C9%    C10%    CPU%c1   
> > CPU%c3    CPU%c6    CPU%c7    CoreTmp    PkgTmpGFX%rc6    GFXMHz   
> > Totl%C0    Any%C0    GFX%C0    CPUGFX%    Pkg%pc2    Pkg%pc3   
> > Pkg%pc6    Pkg%pc7    Pkg%pc8    Pkg%pc9    Pk%pc10    PkgWatt   
> > CorWatt    GFXWatt    RAMWatt    PKG_%    RAM_%
> > -    -    147    10.33    1419    1608    17129    0    7376   
> > 217    166    1316    0    1910    0    1103    3.91    1.10   
> > 0.21    4.78    0.00    30.31    0.00    49.44    17.99    0.28   
> > 5.43    65.98    43    43    96.22    300    38.30    32.37   
> > 3.69    2.57    6.64    46.01    0.00    0.00    0.00    0.00   
> > 0.00    2.27    0.69    0.01    0.43    0.00    0.00
> > 0    0    68    6.63    1029    1608    1727    0    4    10   
> > 7    276    0    502    0    303    0.05    0.10    0.11    4.67   
> > 0.00    31.11    0.00    57.36    18.70    0.41    4.57    69.69   
> > 43    43    96.22    300    38.30    32.37    3.69    2.57   
> > 6.64    46.01    0.00    0.00    0.00    0.00    0.00    2.27   
> > 0.69    0.01    0.43    0.00    0.00
> > 0    2    63    6.62    953    1608    9460    0    7279    109   
> > 92    396    0    279    0    264    12.36    1.69    0.49   
> > 3.83    0.00    25.00    0.00    50.30    18.70
> > 1    1    348    20.03    1738    1608    3535    0    39    58   
> > 32    296    0    497    0    274    1.44    2.48    0.14   
> > 5.33    0.00    25.55    0.00    45.03    11.28    0.14    6.29   
> > 62.27    43
> > 1    3    107    8.03    1330    1608    2407    0    54    40   
> > 35    348    0    632    0    262    1.80    0.14    0.12   
> > 5.29    0.00    39.59    0.00    45.07    23.27
> > Core    CPU    Avg_MHz    Busy%    Bzy_MHz    TSC_MHz    IRQ   
> > SMI    C1    C1E    C3    C6    C7s    C8    C9    C10    C1%   
> > C1E%    C3%    C6%    C7s%    C8%    C9%    C10%    CPU%c1   
> > CPU%c3    CPU%c6    CPU%c7    CoreTmp    PkgTmpGFX%rc6    GFXMHz   
> > Totl%C0    Any%C0    GFX%C0    CPUGFX%    Pkg%pc2    Pkg%pc3   
> > Pkg%pc6    Pkg%pc7    Pkg%pc8    Pkg%pc9    Pk%pc10    PkgWatt   
> > CorWatt    GFXWatt    RAMWatt    PKG_%    RAM_%
> > -    -    189    12.70    1491    1608    27037    0    18431   
> > 1102    620    2370    0    2566    0    869    8.81    1.59   
> > 0.62    7.29    0.00    33.68    0.00    35.44    27.56    0.59   
> > 7.34    51.81    43    43    96.59    300    43.49    34.75   
> > 3.35    2.21    4.41    31.19    0.00    0.00    0.00    0.00   
> > 0.00    2.41    0.80    0.04    0.44    0.00    0.00
> > 0    0    176    11.12    1582    1608    1476    0    86    163   
> > 131    494    0    800    0    235    0.36    1.56    0.45   
> > 7.36    0.00    44.74    0.00    34.42    43.67    0.89    4.91   
> > 39.40    43    43    96.59    300    43.49    34.75    3.35   
> > 2.21    4.41    31.19    0.00    0.00    0.00    0.00    0.00   
> > 2.41    0.80    0.04    0.44    0.00    0.00
> > 0    2    201    15.40    1303    1608    21985    0    18071   
> > 317    268    722    0    307    0    100    32.70    1.78   
> > 1.24    5.55    0.00    18.17    0.00    25.65    39.41
> > 1    1    190    12.76    1488    1608    2036    0    184   
> > 388    172    655    0    655    0    276    0.43    0.90   
> > 0.57    8.32    0.00    36.01    0.00    41.04    12.97    0.29   
> > 9.77    64.22    41
> > 1    3    191    11.52    1657    1608    1540    0    90    234   
> > 49    499    0    804    0    258    1.76    2.14    0.21   
> > 7.94    0.00    35.81    0.00    40.66    14.21
> > Core    CPU    Avg_MHz    Busy%    Bzy_MHz    TSC_MHz    IRQ   
> > SMI    C1    C1E    C3    C6    C7s    C8    C9    C10    C1%   
> > C1E%    C3%    C6%    C7s%    C8%    C9%    C10%    CPU%c1   
> > CPU%c3    CPU%c6    CPU%c7    CoreTmp    PkgTmpGFX%rc6    GFXMHz   
> > Totl%C0    Any%C0    GFX%C0    CPUGFX%    Pkg%pc2    Pkg%pc3   
> > Pkg%pc6    Pkg%pc7    Pkg%pc8    Pkg%pc9    Pk%pc10    PkgWatt   
> > CorWatt    GFXWatt    RAMWatt    PKG_%    RAM_%
> > -    -    96    5.13    1915    1565    4541    28    1129   
> > 1180    498    1878    0    1499    0    547    0.40    1.21   
> > 0.35    2.79    0.00    10.33    0.00    26.00    9.59    0.31   
> > 3.30    81.68    41    41    91.18    300    16.58    13.17   
> > 6.25    2.69    3.32    26.47    0.00    0.02    0.18    0.00   
> > 43.97    1.73    0.56    0.13    0.36    0.00    0.00
> > 0    0    82    5.14    1640    1565    1494    7    557    337   
> > 121    469    0    534    0    92    0.59    0.63    0.23   
> > 3.12    0.00    13.33    0.00    24.37    12.04    0.36    2.57   
> > 79.88    41    41    91.18    300    16.58    13.17    6.25   
> > 2.69    3.32    26.47    0.00    0.02    0.18    0.00    43.97   
> > 1.73    0.56    0.13    0.36    0.00    0.00
> > 0    2    125    5.94    2167    1565    807    7    310    210   
> > 140    384    0    229    0    173    0.58    0.48    0.52   
> > 1.95    0.00    8.19    0.00    24.78    11.25
> > 1    1    97    5.23    1907    1565    1079    7    123    404   
> > 127    407    0    308    0    168    0.20    2.65    0.16   
> > 2.12    0.00    8.36    0.00    28.75    6.99    0.25    4.03   
> > 83.51    41
> > 1    3    78    4.21    1904    1566    1161    7    139    229   
> > 110    618    0    428    0    114    0.23    1.08    0.49   
> > 3.98    0.00    11.46    0.00    26.08    8.06
> > Core    CPU    Avg_MHz    Busy%    Bzy_MHz    TSC_MHz    IRQ   
> > SMI    C1    C1E    C3    C6    C7s    C8    C9    C10    C1%   
> > C1E%    C3%    C6%    C7s%    C8%    C9%    C10%    CPU%c1   
> > CPU%c3    CPU%c6    CPU%c7    CoreTmp    PkgTmpGFX%rc6    GFXMHz   
> > Totl%C0    Any%C0    GFX%C0    CPUGFX%    Pkg%pc2    Pkg%pc3   
> > Pkg%pc6    Pkg%pc7    Pkg%pc8    Pkg%pc9    Pk%pc10    PkgWatt   
> > CorWatt    GFXWatt    RAMWatt    PKG_%    RAM_%
> > -    -    183    12.22    1496    1609    25545    0    16054   
> > 1105    588    3104    0    2351    0    947    7.49    2.30   
> > 0.87    8.77    0.00    29.96    0.00    38.56    26.73    1.32   
> > 8.99    50.74    42    42    95.39    300    41.70    33.24   
> > 4.64    2.58    8.98    28.79    0.00    0.00    0.00    0.00   
> > 0.00    2.52    0.85    0.07    0.45    0.00    0.00
> > 0    0    129    8.96    1442    1610    1306    0    282    331   
> > 132    650    0    569    0    270    0.39    0.78    1.11   
> > 8.95    0.00    34.47    0.00    45.42    46.16    0.62    6.30   
> > 37.97    42    42    95.39    300    41.70    33.23    4.64   
> > 2.58    8.98    28.79    0.00    0.00    0.00    0.00    0.00   
> > 2.52    0.85    0.07    0.45    0.00    0.00
> > 0    2    275    18.50    1486    1610    20238    0    15228   
> > 350    181    884    0    348    0    132    28.61    5.11   
> > 0.67    5.72    0.00    12.26    0.00    29.59    36.62
> > 1    1    177    10.93    1615    1610    1554    0    279   
> > 183    92    533    0    523    0    316    0.52    2.63    0.39   
> > 7.30    0.00    32.26    0.00    46.07    11.89    2.02    11.67   
> > 63.48    41
> > 1    3    151    10.50    1437    1608    2447    0    265   
> > 241    183    1037    0    911    0    229    0.45    0.67   
> > 1.31    13.11    0.00    40.84    0.00    33.17    12.24
> > Core    CPU    Avg_MHz    Busy%    Bzy_MHz    TSC_MHz    IRQ   
> > SMI    C1    C1E    C3    C6    C7s    C8    C9    C10    C1%   
> > C1E%    C3%    C6%    C7s%    C8%    C9%    C10%    CPU%c1   
> > CPU%c3    CPU%c6    CPU%c7    CoreTmp    PkgTmpGFX%rc6    GFXMHz   
> > Totl%C0    Any%C0    GFX%C0    CPUGFX%    Pkg%pc2    Pkg%pc3   
> > Pkg%pc6    Pkg%pc7    Pkg%pc8    Pkg%pc9    Pk%pc10    PkgWatt   
> > CorWatt    GFXWatt    RAMWatt    PKG_%    RAM_%
> > -    -    186    12.71    1465    1608    5928    0    201   
> > 1435    578    2054    0    1837    0    1155    0.31    2.04   
> > 0.75    7.03    0.00    33.91    0.00    43.21    13.64    0.57   
> > 8.32    64.76    41    42    98.75    300    45.25    38.20   
> > 1.34    0.98    14.64    44.34    0.00    0.00    0.00    0.00   
> > 0.00    2.98    1.36    0.01    0.48    0.00    0.00
> > 0    0    79    9.06    868    1608    1222    0    66    314   
> > 166    558    0    451    0    301    0.36    1.21    1.07   
> > 7.24    0.00    35.02    0.00    46.02    11.10    0.83    9.56   
> > 69.45    41    42    98.75    300    45.25    38.20    1.34   
> > 0.98    14.64    44.34    0.00    0.00    0.00    0.00    0.00   
> > 2.98    1.36    0.01    0.48    0.00    0.00
> > 0    2    87    8.34    1044    1608    1205    0    57    508   
> > 159    545    0    455    0    291    0.17    3.72    0.69   
> > 8.00    0.00    28.44    0.00    50.63    11.82
> > 1    1    240    14.08    1706    1608    1700    0    50    419   
> > 80    432    0    533    0    307    0.66    2.14    0.35   
> > 6.43    0.00    39.50    0.00    36.79    18.45    0.31    7.09   
> > 60.07    40
> > 1    3    338    19.34    1750    1608    1801    0    28    194   
> > 173    519    0    398    0    256    0.06    1.10    0.90   
> > 6.44    0.00    32.70    0.00    39.38    13.20
> > Core    CPU    Avg_MHz    Busy%    Bzy_MHz    TSC_MHz    IRQ   
> > SMI    C1    C1E    C3    C6    C7s    C8    C9    C10    C1%   
> > C1E%    C3%    C6%    C7s%    C8%    C9%    C10%    CPU%c1   
> > CPU%c3    CPU%c6    CPU%c7    CoreTmp    PkgTmpGFX%rc6    GFXMHz   
> > Totl%C0    Any%C0    GFX%C0    CPUGFX%    Pkg%pc2    Pkg%pc3   
> > Pkg%pc6    Pkg%pc7    Pkg%pc8    Pkg%pc9    Pk%pc10    PkgWatt   
> > CorWatt    GFXWatt    RAMWatt    PKG_%    RAM_%
> > -    -    332    17.65    1881    1608    15736    0    4620   
> > 990    543    2445    0    1778    0    939    2.07    1.74   
> > 0.58    8.79    0.00    27.36    0.00    41.79    16.43    0.38   
> > 9.86    55.66    42    42    96.50    300    55.08    40.16   
> > 3.42    2.67    7.65    42.05    0.00    0.00    0.00    0.00   
> > 0.00    3.38    1.75    0.02    0.50    0.00    0.00
> > 0    0    341    19.51    1750    1608    2663    0    126   
> > 144    112    521    0    496    0    221    0.46    0.47   
> > 0.58    7.39    0.00    27.37    0.00    44.17    19.41    0.45   
> > 6.99    53.64    42    42    96.50    300    55.08    40.16   
> > 3.42    2.67    7.65    42.05    0.00    0.00    0.00    0.00   
> > 0.00    3.38    1.75    0.02    0.50    0.00    0.00
> > 0    2    371    19.14    1937    1608    7358    0    4130   
> > 398    190    646    0    265    0    198    5.91    3.69   
> > 0.72    6.79    0.00    21.76    0.00    42.06    19.78
> > 1    1    338    16.84    2005    1608    2630    0    221   
> > 195    123    561    0    472    0    287    1.43    0.55   
> > 0.56    7.55    0.00    32.61    0.00    40.42    12.41    0.32   
> > 12.74    57.69    40
> > 1    3    279    15.12    1843    1608    3085    0    143   
> > 253    118    717    0    545    0    233    0.46    2.26   
> > 0.47    13.45    0.00    27.69    0.00    40.53    14.14
> > ^C
> > 
> > 
> > On Tue, Apr 17, 2018 at 5:59 PM, Pandruvada, Srinivas <srinivas.pan
> > druvada@intel.com> wrote:
> > > On Mon, 2018-04-16 at 16:07 +0000, Mario.Limonciello@dell.com
> > > wrote:
> > > > Hi Dennis,
> > > > 
> > > > > -----Original Message-----
> > > > > From: Dennis Gilmore [mailto:dgilmore@redhat.com]
> > > > > Sent: Friday, April 13, 2018 9:03 PM
> > > > > To: linux-kernel@vger.kernel.org; linux-acpi@vger.kernel.org
> > > > > Cc: Limonciello, Mario
> > > > > Subject: issues with suspend on Dell XPS 13 2-in-1
> > > > > 
> > > > > Hi All,
> > > > > 
> > > > > I have a Dell XPS 13 2-in-1 (9365) that when I supend gets
> > > warm and
> > > > > has
> > > > > much shorter than expected battery life, it is about the same
> > > as if
> > > > > the
> > > > > laptop just runs. I am currently running Fedora 28 with
> > > 4.16.2
> > > > > kernel.
> > > > > 
> > > > 
> > > > Since battery consumption is quite relative I think It would be
> > > good
> > > > if
> > > > you can make a comparable benchmark as this is further
> > > discussed.
> > > > Eg fully charge your notebook, pull the plug, suspend it at
> > > 100% and
> > > > check the power left after some repeatable amount of time.
> > > > 
> > > > > My laptop has NVMe for storage and is configured for AHCI
> > > mode in
> > > > > the
> > > > > bios.
> > > > > 
> > > > > powertop by default shows
> > > > > > > Bad           VM writeback timeout
> > > > > 
> > > > >    Bad           NMI watchdog should be turned off
> > > > >    Bad           Autosuspend for unknown USB device 1-7
> > > (138a:0091)
> > > > >    Bad           Runtime PM for I2C Adapter i2c-0 (i915 gmbus
> > > dpc)
> > > > >    Bad           Runtime PM for I2C Adapter i2c-1 (i915 gmbus
> > > dpb)
> > > > >    Bad           Runtime PM for I2C Adapter i2c-2 (i915 gmbus
> > > dpd)
> > > > >    Bad           Runtime PM for PCI Device Intel Corporation
> > > > > Wireless
> > > > > 8265 / 8275
> > > > >    Bad           Runtime PM for PCI Device Intel Corporation
> > > Device
> > > > > 590c
> > > > >    Bad           Runtime PM for PCI Device Realtek
> > > Semiconductor
> > > > > Co.,
> > > > > Ltd. RTS525A PCI Express Card Reader
> > > > >    Bad           Runtime PM for PCI Device Intel Corporation
> > > Device
> > > > > 9d3d
> > > > >    Bad           Runtime PM for PCI Device Sandisk Corp WD
> > > Black
> > > > > NVMe
> > > > > SSD
> > > > >    Bad           Runtime PM for PCI Device Intel Corporation
> > > > > Sunrise
> > > > > Point-LP PCI Express Root Port #9
> > > > >    Bad           Runtime PM for PCI Device Intel Corporation
> > > > > Sunrise
> > > > > Point-LP Thermal subsystem
> > > > >    Bad           Runtime PM for PCI Device Intel Corporation
> > > > > Sunrise
> > > > > Point-LP USB 3.0 xHCI Controller
> > > > >    Bad           Runtime PM for PCI Device Intel Corporation
> > > > > Sunrise
> > > > > Point-LP PMC
> > > > >    Bad           Runtime PM for PCI Device Intel Corporation
> > > > > Sunrise
> > > > > Point-LP HD Audio
> > > > >    Bad           Runtime PM for PCI Device Intel Corporation
> > > > > Sunrise
> > > > > Point-LP PCI Express Root Port #1
> > > > >    Bad           Runtime PM for PCI Device Intel Corporation
> > > Device
> > > > > 9d4b
> > > > >    Bad           Runtime PM for PCI Device Intel Corporation
> > > Xeon
> > > > > E3-
> > > > > 1200 v5/E3-1500 v5/6th Gen Core Processor Thermal Subsystem
> > > > >    Bad           Runtime PM for PCI Device Intel Corporation
> > > > > Sunrise
> > > > > Point-LP Integrated Sensor Hub
> > > > >    Bad           Runtime PM for PCI Device Intel Corporation
> > > Device
> > > > > 591e
> > > > 
> > > > After you've adjusted all of these in powertop, have you
> > > compared
> > > > your performance of the battery over sleep (and actually over
> > > runtime
> > > > usage really too)?
> > > > 
> > > > They should help to allow the CPU to get into deeper states.
> > > > 
> > > > After you've made that change you should also see on the "Idle
> > > Stats"
> > > > page that your CPU is spending more time in the lower C states
> > > > (hopefully
> > > > more in C9/10).
> > > > 
> > > > Srinivas,
> > > > 
> > > > Do you know why Runtime PM is defaulting to disabled for all of
> > > these
> > > > devices?  Is that a default kernel policy problem or a distro
> > > policy
> > > > problem?
> > > This is default kernel policy.
> > > I suggest run
> > > #turbostat
> > > then suspend and wake
> > > when wake up let the turbostat collect data for next sampling
> > > interval.
> > > We have to see what are PkgC% residencies are?
> > > 
> > > Thanks,
> > > Srinivas
> > > 
> > > > 
> > > > 
> > > > >    Good          Bluetooth device interface status
> > > > >    Good          Enable Audio codec power management
> > > > >    Good          Runtime PM for I2C Adapter i2c-8 (Synopsys
> > > > > DesignWare
> > > > > I2C adapter)
> > > > >    Good          Autosuspend for USB device
> > > Integrated_Webcam_HD
> > > > > [CNFGE16N092020028362]
> > > > >    Good          Autosuspend for USB device xHCI Host
> > > Controller
> > > > > [usb1]
> > > > >    Good          Autosuspend for USB device xHCI Host
> > > Controller
> > > > > [usb2]
> > > > >    Good          Runtime PM for I2C Adapter i2c-7 (SMBus I801
> > > > > adapter
> > > > > at efa0)
> > > > >    Good          Autosuspend for unknown USB device 1-2
> > > (8087:0a2b)
> > > > >    Good          Runtime PM for I2C Adapter i2c-6 (Synopsys
> > > > > DesignWare
> > > > > I2C adapter)
> > > > >    Good          I2C Device i2c-DLL077A:01 has no runtime
> > > power
> > > > > management
> > > > >    Good          I2C Device i2c-WCOM482F:00 has no runtime
> > > power
> > > > > management
> > > > >    Good          Runtime PM for PCI Device Intel Corporation
> > > > > Sunrise
> > > > > Point-LP PCI Express Root Port #10
> > > > >    Good          Runtime PM for PCI Device Intel Corporation
> > > > > Sunrise
> > > > > Point-LP CSME HECI #1
> > > > >    Good          Runtime PM for PCI Device Intel Corporation
> > > > > Sunrise
> > > > > Point-LP Serial IO I2C Controller #1
> > > > >    Good          Runtime PM for PCI Device Intel Corporation
> > > > > Sunrise
> > > > > Point-LP SMBus
> > > > >    Good          Runtime PM for PCI Device Intel Corporation
> > > > > Sunrise
> > > > > Point-LP PCI Express Root Port #5
> > > > >    Good          Runtime PM for PCI Device Intel Corporation
> > > > > Sunrise
> > > > > Point-LP Serial IO I2C Controller #0
> > > > >    Good          Wake-on-lan status for device virbr0-nic
> > > > >    Good          Wake-on-lan status for device virbr0
> > > > >    Good          Wake-on-lan status for device wlp60s0
> > > > > 
> > > > > Regards
> > > > > 
> > > > > Dennis
> > > 
