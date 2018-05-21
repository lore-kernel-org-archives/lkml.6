Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751141AbeEUVNm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 17:13:42 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:43881 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750837AbeEUVNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 17:13:39 -0400
X-Google-Smtp-Source: AB8JxZpEu7SQFg1rW7lzcYMGbMZbUKZlACJWcCxRvQnAHeLmXrQ8kWGIasgWEdAF7xAyAp6El1ASgvSC7lk8R2FQKs4=
MIME-Version: 1.0
In-Reply-To: <20180521205751.GA19282@agluck-desk>
References: <CAG=yYwmnHgAvauZLxfFcUEACF_J+qh4d2tvYY=AdjHvyeSFK_A@mail.gmail.com>
 <20180514162752.GG23049@pd.tnic> <CAG=yYwk-dbMF_7eS9bUraAru8b4fyCosxp+MpQA=1ZYH0nd_hg@mail.gmail.com>
 <20180520204032.GA19845@pd.tnic> <CAG=yYw=bdgsTSW80R1Wt9uUTtXeMwX5macbjrPBNzVLihk-Ufw@mail.gmail.com>
 <20180521165803.GA15717@agluck-desk> <CAG=yYw=OQ7zpyK-5iqg7uQvcykTvuhQfX=RFg3GpQGvCRowd=Q@mail.gmail.com>
 <20180521205751.GA19282@agluck-desk>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Tue, 22 May 2018 02:43:37 +0530
Message-ID: <CAG=yYwmgceOCf3TeefFN-i54Z4Qxsp7asD0uhqah5P7md94kWw@mail.gmail.com>
Subject: Re: PROBLEM: mce: [Hardware Error] from dmesg -l emerg
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-edac@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 2:27 AM, Luck, Tony <tony.luck@intel.com> wrote:
> How about this:
>
> $ sudo dmesg -r | grep -C 30 Bank
>
> -Tony

-------------------------------------------------------------------------------------->
$sudo dmesg -r | grep -C 30 Bank
x2apic: IRQ remapping doesn't support X2APIC mode
..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
tsc: Fast TSC calibration using PIT
tsc: Detected 1895.567 MHz processor
clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles:
0x36a5a03c965, max_idle_ns: 881590412318 ns
Calibrating delay loop (skipped), value calculated using timer
frequency.. 3791.13 BogoMIPS (lpj=7582268)
pid_max: default: 32768 minimum: 301
Security Framework initialized
Yama: becoming mindful.
AppArmor: AppArmor initialized
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Mountpoint-cache hash table entries: 8192 (order: 4, 65536 bytes)
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)
mce: CPU supports 7 MCE banks
CPU0: Thermal monitoring enabled (TM1)
process: using mwait in idle threads
Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
Spectre V2 : Mitigation: Full generic retpoline
Spectre V2 : Spectre v2 mitigation: Enabling Indirect Branch Prediction Barrier
Spectre V2 : Enabling Restricted Speculation for firmware calls
Freeing SMP alternatives memory: 32K
TSC deadline timer enabled
smpboot: CPU0: Intel(R) Pentium(R) CPU 3825U @ 1.90GHz (family: 0x6,
model: 0x3d, stepping: 0x4)
mce: [Hardware Error]: Machine check events logged
mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 5: ee0000000040110b
mce: [Hardware Error]: TSC 0 ADDR 160000080 MISC 5040008086
mce: [Hardware Error]: PROCESSOR 0:306d4 TIME 1526932210 SOCKET 0 APIC
0 microcode 2a
Performance Events: PEBS fmt2+, Broadwell events, 16-deep LBR,
full-width counters, Intel PMU driver.
... version:                3
... bit width:              48
... generic registers:      4
... value mask:             0000ffffffffffff
... max period:             00007fffffffffff
... fixed-purpose events:   3
... event mask:             000000070000000f
Hierarchical SRCU implementation.
NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
smp: Bringing up secondary CPUs ...
x86: Booting SMP configuration:
.... node  #0, CPUs:      #1 #2 #3
smp: Brought up 1 node, 4 CPUs
smpboot: Max logical packages: 1
smpboot: Total of 4 processors activated (15164.53 BogoMIPS)
devtmpfs: initialized
x86/mm: Memory block size: 128MB
PM: Registering ACPI NVS region [mem 0x9cc8e000-0x9cf8dfff] (3145728 bytes)
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff,
max_idle_ns: 7645041785100000 ns
futex hash table entries: 1024 (order: 4, 65536 bytes)
pinctrl core: initialized pinctrl subsystem
NET: Registered protocol family 16
audit: initializing netlink subsys (disabled)
audit: type=2000 audit(1526932210.048:1): state=initialized
audit_enabled=0 res=1
cpuidle: using governor ladder
cpuidle: using governor menu
Simple Boot Flag at 0x44 set to 0x1
$
-------------------------------------------------------------------------->

-- 
software engineer
rajagiri school of engineering and technology
