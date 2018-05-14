Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753798AbeENPtO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 11:49:14 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:45131 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752338AbeENPtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 11:49:12 -0400
X-Google-Smtp-Source: AB8JxZoA57w11oFVfwZiitTONK3xa/CYiU74KPiHXglMXsy8XZgZdSSxkCW+Gp3WLDL998AufEap6t1EoHgCpYo56bY=
MIME-Version: 1.0
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Mon, 14 May 2018 21:19:11 +0530
Message-ID: <CAG=yYwmnHgAvauZLxfFcUEACF_J+qh4d2tvYY=AdjHvyeSFK_A@mail.gmail.com>
Subject: PROBLEM: mce: [Hardware Error] from dmesg -l emerg
To: Tony Luck <tony.luck@intel.com>, bp@alien8.de,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org
Cc: linux-edac@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hello,

output related of  "sudo dmesg -l emerg" from my laptop...

--------------------------------------------------------------------------------------------------->
$sudo dmesg -l emerg
[sudo] password for jeffrin:
[    0.041023] mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 5:
ee0000000040110b
[    0.041028] mce: [Hardware Error]: TSC 0 ADDR 160000080 MISC 5040008086
[    0.041034] mce: [Hardware Error]: PROCESSOR 0:306d4 TIME
1526300792 SOCKET 0 APIC 0 microcode 2a
$
---------------------------------------------------------------------------------------------------->

Linux debian 4.17.0-rc5+ #26 SMP Mon May 14 17:27:12 IST 2018 x86_64 GNU/Linux

GNU Make            4.2.1
Binutils            2.30
Util-linux          2.32
Mount                2.32
Linux C Library      2.27
Dynamic linker (ldd) 2.27
readlink: missing operand
Try 'readlink --help' for more information.
Procps              3.3.14
Kbd                  2.0.4
Console-tools        2.0.4
Sh-utils            8.28
Udev                238

Architecture:        x86_64
CPU op-mode(s):      32-bit, 64-bit
Byte Order:          Little Endian
CPU(s):              4
On-line CPU(s) list: 0-3
Thread(s) per core:  2
Core(s) per socket:  2
Socket(s):           1
NUMA node(s):        1
Vendor ID:           GenuineIntel
CPU family:          6
Model:               61
Model name:          Intel(R) Pentium(R) CPU 3825U @ 1.90GHz
Stepping:            4
CPU MHz:             1629.386
CPU max MHz:         1900.0000
CPU min MHz:         500.0000
BogoMIPS:            3790.98
Virtualization:      VT-x
L1d cache:           32K
L1i cache:           32K
L2 cache:            256K
L3 cache:            2048K
NUMA node0 CPU(s):   0-3
Flags:               fpu vme de pse tsc msr pae mce cx8 apic sep mtrr
pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts
rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq
dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg cx16 xtpr pdcm pcid
sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer xsave rdrand
lahf_lm abm 3dnowprefetch cpuid_fault epb invpcid_single pti
tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust erms invpcid
rdseed intel_pt xsaveopt ibpb ibrs stibp dtherm ida arat pln pts

Reported-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>

-- 
software engineer
rajagiri school of engineering and technology
