Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95E6C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 17:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EBE9218EA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 17:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbeLZRJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 12:09:56 -0500
Received: from mout.gmx.net ([212.227.15.19]:44473 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726930AbeLZRJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 12:09:56 -0500
Received: from [192.168.123.38] ([84.118.159.3]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M4nYT-1haLF01owH-00z0xq; Wed, 26
 Dec 2018 18:09:15 +0100
Subject: Re: [PATCH v2 1/1] arm64: dts: marvell: armada-ap806: reserve PSCI
 area
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Emmanuel Vadot <manu@freebsd.org>,
        Russell King <rmk+kernel@armlinux.org.uk>
References: <20181221164503.5128-1-xypron.glpk@gmx.de>
 <87h8f09sbe.fsf@bootlin.com>
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
Openpgp: preference=signencrypt
Autocrypt: addr=xypron.glpk@gmx.de; prefer-encrypt=mutual; keydata=
 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 Eg==
Message-ID: <dce82ebf-81d4-c5d3-2739-053c81afb31c@gmx.de>
Date:   Wed, 26 Dec 2018 18:09:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <87h8f09sbe.fsf@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:65dBU0JpHRgb/nge19+XQLp6p7bBagAarny4J80/dNGvYnbyskI
 ZZKJZPmRN8asCLgj8OvjwTbW2/9y6EGdSssid+J5TNlUXZMz8PPTNRbdrF9Y8EZjyD4jx47
 mq4Eqi4SKX+CL2/ZFvwhvcHJCzfLMmpqIgia2k0ZyHnGArFxEeqrRMAYuKUOUf028d+gzko
 KInS9t3CUXVAbdJf2K2Zg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wTpbqhRofWU=:yy/gTFhGLWAIheoQ14p+Po
 bA65snlIlTFXGGrzRpJJKkLCxzPqdg4jVncD+BLCgVK7ujh9nJrICektc7a2W5VxRJX+5Rmck
 7fXoAc2ofwvFlfbY9ccjsnCo4J8oDqYQrGhDn9OSC2ft9Pi/kIa7CAOXuafrQAyCNw509JgEz
 VVx6XohdN7UD6adbR9WxUlhjcianmeq/v3ags7K8/KzDgxJKUAl+aoM9mjqi6Bk0WcEsGb+wz
 oihWrn7J60UcVBhkiU0RhRBEIBSj6mdgkYZ5WBOBLGR2vn2UoBWq9jfuhivAXFItVZGDrWk/C
 k18+wZmPjSkjHW9USdqhdv3ABVrWR1kCopKsjHQV1A54mF+rj20ZXPaMD0SqYJ75GforByny0
 QLe3mdYIiqe7/80JaqocmOPHLBgWPnpTewaKyQUsZyUH1cmqzB7/NhqdnfW3hsBDGOqCbKma1
 fRjix+GMNHtyHvG6HYTRvRymuR9jrIwShJfFs/CGgSpsDF4W7aWKbRdIXFPgzyheHC/gMuEkB
 fQIP1hkd3ZsDEi7TXQySLBV0Br9Ai0/OMn1Z4eoM/xMoO/LYojEJNmst4xjRbFawMKBYDE3i0
 fdbZXmBm2MR1oPIi/lxSWE26oiJndyKmiqJYyzVihyodeFQrOTLXgEzuJrDeCnaL1bO5WfXDp
 kcT5pETwn89bYW1tKaVM98Rd8qPztQf82G+wOu7cU+BgsHwWX/z7jklgW6OabYO4RrVutA+Y9
 VbmQQB6G2FhQKx3QbFYpX4q+ulJ4bFOO030DvlWeskJg3N6upZYlNc/0kNlN+UOYzp13SG+KP
 u6+ysIWBCgNTb5Udji9KUxPkyg2kVL8NtG1Bjo4DkB7qlZTKo/J/pMYr5hU1eNhFkklPQfDtF
 Cqz+GCPtPjs7uZSHbJnVtg/HjdQxsQMcjZhZSR1MBb+rF7maG/VOm1M+/DOlNK
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/26/18 5:16 PM, Gregory CLEMENT wrote:
> Hi Heinrich,
>  
>  On ven., déc. 21 2018, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> 
>> The memory area [0x4000000-0x4200000[ is occupied by the PSCI firmware. Any
>> attempt to access it from Linux leads to an immediate crash.
>>
>> So let's make the same memory reservation as the vendor kernel.
>>
>> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> 
> We got a similar patch one month ago and Russell King pointed that it
> didn't match waht he saw on his MACCHIATObin:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2018-November/612360.html
> 
> on mine under U-Boot I got:
> 
> Marvell>> md 0x4000000
> 04000000: 00000000 00000007 00000005 00000040    ............@...
> 04000010: 00000001 00001000 00000007 00000001    ................
> 04000020: 00000008 00000000 00000009 00000000    ................
> 04000030: 0000000a 00000000 ffffffff ffffffff    ................
> 04000040: ffffffff ffffffff ffffffff ffffffff    ................
> 04000050: ffffffff ffffffff ffffffff ffffffff    ................
> 04000060: ffffffff ffffffff ffffffff ffffffff    ................
> 04000070: ffffffff ffffffff ffffffff ffffffff    ................
> 04000080: ffffffff ffffffff ffffffff ffffffff    ................
> 04000090: ffffffff ffffffff ffffffff ffffffff    ................
> 040000a0: ffffffff ffffffff ffffffff ffffffff    ................
> 040000b0: ffffffff ffffffff ffffffff ffffffff    ................
> 040000c0: ffffffff ffffffff ffffffff ffffffff    ................
> 040000d0: ffffffff ffffffff ffffffff ffffffff    ................
> 040000e0: ffffffff ffffffff ffffffff ffffffff    ................
> 040000f0: ffffffff ffffffff ffffffff ffffffff    ................
> 
> In my case I have an old ATF, however this kind of setting should be
> done by the bootloader.
> 
> I am interested by your claim about causing an immediate crash when
> accessing this region. How did you trigger it?
> 
> Gregory

Hello Gregory,

judging from you U-Boot prompt you are not using mainline U-Boot. With
the legacy Marvell U-Boot I get the same output as you provide above.
But you are looking in the wrong place to confirm that this is ATF:

Marvell>> md 04017200
04017200: 616d6920 74206567 5043206f 474d2031     image to CP1 MG
04017210: 746f6e20 70757320 74726f70 000a6465     not supported..
04017220: 4f525245 20203a52 50435320 324c425f    ERROR:   SCP_BL2
04017230: 6f727720 6920676e 6620676d 616d726f     wrong img forma
04017240: 63282074 745f336d 3d657079 0a296425    t (cm3_type=%d).
04017250: 544f4e00 3a454349 43532020 6d492050    .NOTICE:  SCP Im
04017260: 20656761 73656f64 2074276e 746e6f63    age doesn't cont
04017270: 206e6961 66204d50 776d7269 0a657261    ain PM firmware.
04017280: 00000000 00000000 040144d0 00000000    .........D......
04017290: 00000001 00000019 4f525245 20203a52    ........ERROR:
040172a0: 6e695720 20776f64 203a6425 65736162     Window %d: base
040172b0: 64646120 73736572 616e7520 6e67696c     address unalign
040172c0: 74206465 7830206f 000a7825 67696c41    ed to 0x%x..Alig
040172d0: 7075206e 65687420 73616220 64612065    n up the base ad
040172e0: 73657264 6f742073 25783020 000a786c    dress to 0x%lx..
040172f0: 4f525245 20203a52 6e695720 20776f64    ERROR:   Window

Possibly the legacy Marvell U-Boot is running at exception level 3
(EL3). This would explain why you cannot reproduce the crash with that
U-Boot.

The legacy Marvell U-Boot is in bad shape: their booti command cannot
load the initrd.img created by Debian. This is why I use mainline
U-Boot. Here you can find my recipe:

https://github.com/xypron/u-boot-build/blob/macchiatobin/Makefile (for
U-Boot v2018.11)

When I issue the md command for the region in mainline U-Boot  I get a
crash:

=> md 0x4000000


04000000:"Synchronous Abort" handler, esr 0x96000210


elr: 000000000006b878 lr : 000000000006b7f4 (reloc)


elr: 000000007ff8b878 lr : 000000007ff8b7f4


x0 : 0000000000000009 x1 : 0000000000000000


x2 : 000000000000003a x3 : 0000000004000000


x4 : 0000000000000000 x5 : 000000007ffae306


x6 : 0000000000000004 x7 : 000000007fb0a1e0


x8 : 000000007fb0a0a0 x9 : 0000000000000008


x10: 00000000ffffffd0 x11: 0000000000000006


x12: 000000000001869f x13: 000000000000440c


x14: 000000007fb0a43c x15: 0000000000000008


x16: 000000007ffb49ea x17: 000000007ffb49ea


x18: 000000007fb0fdd8 x19: 0000000000000040


x20: 0000000004000000 x21: 0000000004000000


x22: 000000007ffacff1 x23: 0000000000000008


x24: 0000000000000004 x25: 0000000000000004


x26: 0000000000000004 x27: 000000007fb0a268


x28: 0000000000000000 x29: 000000007fb0a1e0



Resetting CPU ...

In Linux 4.20 without my patch I regularly experience crashes like the
one below. With the patch I never experience such a crash.

[  683.992558] Internal error: synchronous external a
bort: 96000210 [#1] PREEMPT SMP

[  684.000084] Modules linked in: crct10dif_ce omap_rng rng_core sg
ip_tables x_tables ipv6 sr_mod cdrom n
vme nvme_core marvell

[  684.011369] CPU: 2 PID: 2607 Comm: dd Not tainted 4.20.0-rc7-arm64 #3

[  684.017839] Hardware name: Marvell 8040 MACCHIATOBin (DT)

[  684.023265] pstate: 20000005 (nzCv daif -PAN -UAO)

[  684.028090] pc : __arch_copy_to_user+0x180/0x220

[  684.032732] lr : copyout+0x54/0x68

[  684.036148] sp : ffff00000d803c30

[  684.039477] x29: ffff00000d803c30 x28: ffff800073661d98

[  684.044815] x27: ffff8000695900d8 x26: 000000000006f09e

[  684.050153] x25: 0000000000000000 x24: ffff00000d803d78

[  684.055490] x23: 000000000009e000 x22: 0000000000001000

[  684.060827] x21: ffff00000d803db0 x20: 0000000000001000

[  684.066164] x19: ffff800004000000 x18: 0000000000000000

[  684.071501] x17: 0fffc00000020016 x16: 0000000000000000

[  684.076838] x15: 0000000000000000 x14: 0000000000000000

[  684.082175] x13: 0000000000000000 x12: 0000000000000000

[  684.087515] x11: 0000000000000000 x10: 0000000000000000

[  684.092852] x9 : 0000000000000000 x8 : 0000000000000000

[  684.098189] x7 : 000000000006f09e x6 : 0000ffffb58a2000

[  684.103526] x5 : 0000ffffb58a3000 x4 : 0000000000000000

[  684.108864] x3 : 0000ffffb58a2000 x2 : 0000000000000f80

[  684.114201] x1 : ffff800004000000 x0 : 0000ffffb58a2000

[  684.119540] Process dd (pid: 2607, stack limit = 0x0000000004d531a7)

[  684.125924] Call trace:

[  684.128385]  __arch_copy_to_user+0x180/0x220

[  684.132676]  copy_page_to_iter+0xec/0x320

[  684.136706]  generic_file_read_iter+0x2ec/0x7b0

[  684.141260]  blkdev_read_iter+0x38/0x48

[  684.145115]  __vfs_read+0x110/0x148

[  684.148620]  vfs_read+0x8c/0x160

[  684.151863]  ksys_read+0x5c/0xc0

[  684.155106]  __arm64_sys_read+0x18/0x20

[  684.158963]  el0_svc_common+0x84/0xd8

[  684.162642]  el0_svc_handler+0x2c/0x80

[  684.166410]  el0_svc+0x8/0xc

[  684.169306] Code: d503201f d503201f d503201f d503201f (a8c12027)

[  684.175429] ---[ end trace 5fd69e42c5988a37 ]---

[  684.180240] SError Interrupt on CPU2, code 0xbf000002 -- SError

[  684.180242] CPU: 2 PID: 2607 Comm: dd Tainted: G      D
4.20.0-rc7-arm64 #3
[  684.180243] Hardware name: Marvell 8040 MACCHIATOBin (DT)

[  684.180244] pstate: a0000005 (NzCv daif -PAN -UAO)

[  684.180245] pc : unmap_page_range+0x468/0xa38

[  684.180246] lr : unmap_page_range+0x414/0xa38

[  684.180247] sp : ffff00000d803750

[  684.180248] x29: ffff00000d803750 x28: ffff00000d8038f0

[  684.180250] x27: ffff800055c6b130 x26: 0400000000000001

[  684.180253] x25: 0000000000000000 x24: ffff7e00019b6500

[  684.180255] x23: 0000aaaad4c27000 x22: 0000aaaad4c26000

[  684.180257] x21: ffff00000d803838 x20: 0000aaaad4c27000

[  684.180259] x19: 0000aaaad4c30000 x18: 0000000000000010

[  684.180261] x17: 00000000ffffffff x16: 0000000000000000

[  684.180263] x15: ffffffffffffffff x14: 0720072007200720

[  684.180266] x13: 0720072007200720 x12: 0720072007200720

[  684.180268] x11: ffff80007ffaa650 x10: 0720072007200720

[  684.180270] x9 : 0720072007200720 x8 : ffff80007ffaa640

[  684.180272] x7 : 0000000000000010 x6 : ffff80007ffaa640

[  684.180274] x5 : 0000aaaad4c26000 x4 : ffff800055c7e3c0

[  684.180276] x3 : 0000000000066d94 x2 : 0020000066d94fd3

[  684.180278] x1 : 0000000000000009 x0 : 0000000000000009

[  684.180281] Kernel panic - not syncing: Asynchronous SError Interrupt

[  684.180295] SMP: stopping secondary CPUs

[  684.180296] Kernel Offset: disabled

[  684.180297] CPU features: 0x2,21806000

[  684.180298] Memory Limit: none

[  684.317162] ---[ end Kernel panic - not syncing: Asynchronous SError
Interrupt ]---

Best regards

Heinrich

> 
> 
>> ---
>> v2
>> 	Move the change from armada-8040-mcbin.dts to armada-ap806.dtsi.
>> 	I only have a MACCHIATObin for testing but
>> 	https://github.com/MarvellEmbeddedProcessors/linux-marvell
>> 	has the reservation in that file.
>> ---
>>  arch/arm64/boot/dts/marvell/armada-ap806.dtsi | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
>> index 7d94c1fa592a..f8dafef83db0 100644
>> --- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
>> +++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
>> @@ -28,6 +28,17 @@
>>  		method = "smc";
>>  	};
>>  
>> +	reserved-memory {
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		ranges;
>> +
>> +		psci-area@4000000 {
>> +			reg = <0x0 0x4000000 0x0 0x200000>;
>> +			no-map;
>> +		};
>> +	};
>> +
>>  	ap806 {
>>  		#address-cells = <2>;
>>  		#size-cells = <2>;
>> -- 
>> 2.19.2
>>
> 

