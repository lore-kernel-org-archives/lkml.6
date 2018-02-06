Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753391AbeBFTvq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 14:51:46 -0500
Received: from esa2.dell-outbound.iphmx.com ([68.232.149.220]:8508 "EHLO
        esa2.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751632AbeBFTvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 14:51:44 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2GEAQDeBnpahz+a6ERcGQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQcBAQEBAYQngQAoCoNbmFWCAokTjkqCAwqFOwIagkJYFAEBAQEBAQEBAgE?=
 =?us-ascii?q?CEAEBAQgNCQgoL4I4IoJKAQEBBCMROgsMBAIBCBEEAQEBAgIREgMCAgIfJQEIC?=
 =?us-ascii?q?AIEDgUIihUDFbUdgieHOw2BMYIGAQEBAQEBAQEBAQEBAQEBAQEBAQEBHYEPg1u?=
 =?us-ascii?q?CFYY3NoJrRASBKg0/ECMFDYJLgmUFimKJXo8wPpBthH6CJ4YnhBmHXo45iUeBP?=
 =?us-ascii?q?DaBc3BSgkaCVRAMggZ4jE+BJYECFQEBAQ?=
X-IPAS-Result: =?us-ascii?q?A2GEAQDeBnpahz+a6ERcGQEBAQEBAQEBAQEBAQcBAQEBAYQ?=
 =?us-ascii?q?ngQAoCoNbmFWCAokTjkqCAwqFOwIagkJYFAEBAQEBAQEBAgECEAEBAQgNCQgoL?=
 =?us-ascii?q?4I4IoJKAQEBBCMROgsMBAIBCBEEAQEBAgIREgMCAgIfJQEICAIEDgUIihUDFbU?=
 =?us-ascii?q?dgieHOw2BMYIGAQEBAQEBAQEBAQEBAQEBAQEBAQEBHYEPg1uCFYY3NoJrRASBK?=
 =?us-ascii?q?g0/ECMFDYJLgmUFimKJXo8wPpBthH6CJ4YnhBmHXo45iUeBPDaBc3BSgkaCVRA?=
 =?us-ascii?q?MggZ4jE+BJYECFQEBAQ?=
From: <Mario.Limonciello@dell.com>
X-LoopCount0: from 10.166.132.187
X-IronPort-AV: E=Sophos;i="5.46,469,1511848800";
   d="scan'208";a="1212117566"
X-DLP: DLP_GlobalPCIDSS
To: <pmenzel+platform-driver-x86@molgen.mpg.de>
CC: <pali.rohar@gmail.com>, <it+platform-driver-x86@molgen.mpg.de>,
        <platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: dell-smbios makes wireless card unusable on Dell XPS 13 9360
Thread-Topic: dell-smbios makes wireless card unusable on Dell XPS 13 9360
Thread-Index: AQHTn2JDQNvMUU6uc0OEu0w66Mk5pKOXhwfwgABoIgD//9gmoA==
Date: Tue, 6 Feb 2018 19:51:41 +0000
Message-ID: <675694ab854f40548d57d7943cb4475f@ausx13mpc120.AMER.DELL.COM>
References: <7a59dd8f-c6a1-e412-931f-629ac5aa2800@molgen.mpg.de>
 <3e2d3a0bb0f8495b8b77d282a371b28c@ausx13mpc120.AMER.DELL.COM>
 <9b358453-915f-0721-1541-6ff793f5e811@molgen.mpg.de>
In-Reply-To: <9b358453-915f-0721-1541-6ff793f5e811@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.242.75]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w16JppB6024073

> -----Original Message-----
> From: platform-driver-x86-owner@vger.kernel.org [mailto:platform-driver-x86-
> owner@vger.kernel.org] On Behalf Of Paul Menzel
> Sent: Tuesday, February 6, 2018 10:08 AM
> To: Limonciello, Mario <Mario_Limonciello@Dell.com>
> Cc: Pali Rohár <pali.rohar@gmail.com>; it+platform-driver-x86@molgen.mpg.de;
> platform-driver-x86@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: dell-smbios makes wireless card unusable on Dell XPS 13 9360
> 
> Dear Mario,
> 
> 
> On 02/06/18 16:58, Mario.Limonciello@dell.com wrote:
> 
> >> -----Original Message-----
> >> From: Paul Menzel [mailto:pmenzel+platform-driver-x86@molgen.mpg.de]
> >> Sent: Tuesday, February 6, 2018 9:50 AM
> >> To: Pali Rohár <pali.rohar@gmail.com>; Limonciello, Mario
> >> <Mario_Limonciello@Dell.com>; it+platform-driver-x86@molgen.mpg.de
> >> Cc: platform-driver-x86@vger.kernel.org; Linux Kernel Mailing List <linux-
> >> kernel@vger.kernel.org>
> >> Subject: dell-smbios makes wireless card unusable on Dell XPS 13 9360
> 
> >> Adding `dell-smbios` to `/etc/modules` on the Dell XPS 13 9360, it seems
> >> to badly effect the Wireless LAN device, causing it to be absent or to
> >> not work.
> >>
> >> In one case, the whole system lagged, that means, the log in screen
> >> stayed grayed out for 15 seconds, and the mouse pointer stopped moving
> >> every 20(?) seconds for some seconds.
> >
> > Can you please confirm if you're indicating this is a regression in 4.15?
> > Or was this present in earlier kernels too?
> 
> Yes, it happened with Ubuntu’s 4.13 too. My original message had one log
> attached where the Wifi wasn’t visible at all.
> 

Looking at that log it looks to me that the ath10k firmware crashed, not that
dell-smbios lagging caused the crash.

[   15.262226] ath10k_pci 0000:3a:00.0: firmware crashed! (uuid a6c40788-b7ad-4f6a-890a-62e62c1f6e5f)
[   15.262233] ath10k_pci 0000:3a:00.0: qca6174 hw3.2 target 0x05030000 chip_id 0x00340aff sub 1a56:1535
[   15.262235] ath10k_pci 0000:3a:00.0: kconfig debug 0 debugfs 1 tracing 1 dfs 0 testmode 0
[   15.262645] ath10k_pci 0000:3a:00.0: firmware ver WLAN.RM.4.4-00022-QCARMSWPZ-2 api 6 features wowlan,ignore-otp crc32 4d458559
[   15.262941] ath10k_pci 0000:3a:00.0: board_file api 2 bmi_id N/A crc32 0e26ef70
[   15.262943] ath10k_pci 0000:3a:00.0: htt-ver 0.0 wmi-op 4 htt-op 3 cal otp max-sta 32 raw 0 hwcrypto 1
[   15.274887] ath10k_pci 0000:3a:00.0: failed to get memcpy hi address for firmware address 4: -16
[   15.274900] ath10k_pci 0000:3a:00.0: failed to read firmware dump area: -16
[   15.274909] ath10k_pci 0000:3a:00.0: Copy Engine register dump:

Do you have a strong correlation with dell-smbios loading and the wireless
firmware crashing?  You're the first account I've heard of this.

Also why are you putting it in /etc/modules rather than letting the udev
rules load from modaliases?  Or did you artificially prevent that in some way?
