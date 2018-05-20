Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751523AbeETLA2 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 07:00:28 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:44423 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750928AbeETLAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 07:00:25 -0400
X-Google-Smtp-Source: AB8JxZqB6kO7GSjSlP4iTnok4KSeIn8mxVASDJW61xput2zaCprAHexmTCXgQA9Q9ujVVkRJLAtPdHDnF8RwvyzCNEo=
MIME-Version: 1.0
In-Reply-To: <20180514165042.GA2746@agluck-desk>
References: <CAG=yYwmnHgAvauZLxfFcUEACF_J+qh4d2tvYY=AdjHvyeSFK_A@mail.gmail.com>
 <20180514162752.GG23049@pd.tnic> <20180514165042.GA2746@agluck-desk>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Sun, 20 May 2018 16:30:24 +0530
Message-ID: <CAG=yYw=b_b2vhOeYTiCrCJ9yCOebDW_i5LA27Ck-m44uhyw+8Q@mail.gmail.com>
Subject: Re: PROBLEM: mce: [Hardware Error] from dmesg -l emerg
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-edac@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

that system is  normally not crashing. as far as i know, there are no
other bad effects
it happens during every boot.it is not a one time message.

output for "sudo dmesg | grep -B 40 44919"  command related

---------------------------------------------------------------------------------------------------------------------------------------->
[    1.555315] intel_idle: MWAIT substates: 0x11142120
[    1.555316] intel_idle: v0.4.1 model 0x3D
[    1.555544] intel_idle: lapic_timer_reliable_states 0xffffffff
[    1.555866] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.556307] Linux agpgart interface v0.103
[    1.556388] AMD IOMMUv2 driver by Joerg Roedel <jroedel@suse.de>
[    1.556389] AMD IOMMUv2 functionality not available on this system
[    1.556679] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M]
at 0x60,0x64 irq 1,12
[    1.580570] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.580574] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.580706] mousedev: PS/2 mouse device common for all mice
[    1.580744] rtc_cmos 00:01: RTC can wake from S4
[    1.580907] rtc_cmos 00:01: registered as rtc0
[    1.580921] rtc_cmos 00:01: alarms up to one month, 242 bytes
nvram, hpet irqs
[    1.580935] intel_pstate: Intel P-state driver initializing
[    1.581160] ledtrig-cpu: registered to indicate activity on CPUs
[    1.582235] NET: Registered protocol family 10
[    1.587820] Segment Routing with IPv6
[    1.587871] mip6: Mobile IPv6
[    1.587876] NET: Registered protocol family 17
[    1.587885] mpls_gso: MPLS GSO support
[    1.588638] microcode: sig=0x306d4, pf=0x40, revision=0x2a
[    1.588899] microcode: Microcode Update Driver: v2.2.
[    1.588928] sched_clock: Marking stable (1588863300,
0)->(3178404073, -1589540773)
[    1.589452] registered taskstats version 1
[    1.589454] Loading compiled-in X.509 certificates
[    1.589489] zswap: loaded using pool lzo/zbud
[    1.589675] AppArmor: AppArmor sha1 policy hashing enabled
[    1.589680] ima: No TPM chip found, activating TPM-bypass! (rc=-19)
[    1.589687] ima: Allocated hash algorithm: sha256
[    1.590826] rtc_cmos 00:01: setting system clock to 2018-05-20
10:14:28 UTC (1526811268)
[    1.591506] input: AT Translated Set 2 keyboard as
/devices/platform/i8042/serio0/input/input0
[    1.922558] Freeing unused kernel memory: 1568K
[    1.936066] Write protecting the kernel read-only data: 16384k
[    1.938244] Freeing unused kernel memory: 2008K
[    1.941243] Freeing unused kernel memory: 812K
[    1.955715] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.955716] x86/mm: Checking user space page tables
[    1.964175] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    2.036680] hidraw: raw HID events driver (C) Jiri Kosina
[    2.044919] ACPI BIOS Error (bug): Failure looking up
[\_SB.PCI0.LPCB.HEC.ECWT], AE_NOT_FOUND (20180313/psargs-330)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->


On Mon, May 14, 2018 at 10:20 PM, Luck, Tony <tony.luck@intel.com> wrote:
> On Mon, May 14, 2018 at 06:27:52PM +0200, Borislav Petkov wrote:
>> On Mon, May 14, 2018 at 09:19:11PM +0530, Jeffrin Thalakkottoor wrote:
>> > hello,
>> >
>> > output related of  "sudo dmesg -l emerg" from my laptop...
>> >
>> > --------------------------------------------------------------------------------------------------->
>> > $sudo dmesg -l emerg
>> > [sudo] password for jeffrin:
>> > [    0.041023] mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 5:
>> > ee0000000040110b
>> > [    0.041028] mce: [Hardware Error]: TSC 0 ADDR 160000080 MISC 5040008086
>> > [    0.041034] mce: [Hardware Error]: PROCESSOR 0:306d4 TIME
>> > 1526300792 SOCKET 0 APIC 0 microcode 2a
>>
>> Run it through mcelog to see what it decodes to:
>>
>> dmesg | mcelog --ascii
>
> Is the system crashing? Or do you just see this message but
> no other bad effects?
>
> Does is happen every boot? Or was this a one time message?
>
> Can you grab some context lines from dmesg (say 40 lines
> leading up to this message) to see what else was going on?
>
> -Tony



-- 
software engineer
rajagiri school of engineering and technology
