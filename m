Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752572AbeBFP6e (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 10:58:34 -0500
Received: from esa6.dell-outbound.iphmx.com ([68.232.149.229]:25476 "EHLO
        esa6.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752222AbeBFP60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 10:58:26 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2F0AQBuz3lah2Ka6ERcGQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQcBAQEBAYQnEHAoCoNbmFWCAokTjkqCAwojhRgCGoJCWBQBAQEBAQEBAQI?=
 =?us-ascii?q?BAhABAQEKCwkIKC+COCIRS1kBAQEBAQEjAg1dAQEBBCMROgsMBAIBCBEEAQEDA?=
 =?us-ascii?q?iMDAgICHyUBCAgCBAENBQiKFQMVELYRgieHPw2BMYF4AQEBAQEBAQEBAQEBAQE?=
 =?us-ascii?q?BAQEBAQEBGAWBD4NbghWGbYJrRASBNz8zgl2CZQWjcD6IGohThH6CJ4Yni3eNc?=
 =?us-ascii?q?UiJR4E8NoFzcFKCRoJlghJ4jgOBFwEBAQ?=
X-IPAS-Result: =?us-ascii?q?A2F0AQBuz3lah2Ka6ERcGQEBAQEBAQEBAQEBAQcBAQEBAYQ?=
 =?us-ascii?q?nEHAoCoNbmFWCAokTjkqCAwojhRgCGoJCWBQBAQEBAQEBAQIBAhABAQEKCwkIK?=
 =?us-ascii?q?C+COCIRS1kBAQEBAQEjAg1dAQEBBCMROgsMBAIBCBEEAQEDAiMDAgICHyUBCAg?=
 =?us-ascii?q?CBAENBQiKFQMVELYRgieHPw2BMYF4AQEBAQEBAQEBAQEBAQEBAQEBAQEBGAWBD?=
 =?us-ascii?q?4NbghWGbYJrRASBNz8zgl2CZQWjcD6IGohThH6CJ4Yni3eNcUiJR4E8NoFzcFK?=
 =?us-ascii?q?CRoJlghJ4jgOBFwEBAQ?=
From: <Mario.Limonciello@dell.com>
X-LoopCount0: from 10.166.132.195
X-IronPort-AV: E=Sophos;i="5.46,469,1511848800";
   d="scan'208";a="1046809081"
X-DLP: DLP_GlobalPCIDSS
To: <pmenzel+platform-driver-x86@molgen.mpg.de>, <pali.rohar@gmail.com>,
        <it+platform-driver-x86@molgen.mpg.de>
CC: <platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: dell-smbios makes wireless card unusable on Dell XPS 13 9360
Thread-Topic: dell-smbios makes wireless card unusable on Dell XPS 13 9360
Thread-Index: AQHTn2JDQNvMUU6uc0OEu0w66Mk5pKOXhwfw
Date: Tue, 6 Feb 2018 15:58:23 +0000
Message-ID: <3e2d3a0bb0f8495b8b77d282a371b28c@ausx13mpc120.AMER.DELL.COM>
References: <7a59dd8f-c6a1-e412-931f-629ac5aa2800@molgen.mpg.de>
In-Reply-To: <7a59dd8f-c6a1-e412-931f-629ac5aa2800@molgen.mpg.de>
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
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w16Fwdk6001865

Hi Paul,

> -----Original Message-----
> From: Paul Menzel [mailto:pmenzel+platform-driver-x86@molgen.mpg.de]
> Sent: Tuesday, February 6, 2018 9:50 AM
> To: Pali Rohár <pali.rohar@gmail.com>; Limonciello, Mario
> <Mario_Limonciello@Dell.com>; it+platform-driver-x86@molgen.mpg.de
> Cc: platform-driver-x86@vger.kernel.org; Linux Kernel Mailing List <linux-
> kernel@vger.kernel.org>
> Subject: dell-smbios makes wireless card unusable on Dell XPS 13 9360
> 
> Dear Linux folks,
> 
> 
> Adding `dell-smbios` to `/etc/modules` on the Dell XPS 13 9360, it seems
> to badly effect the Wireless LAN device, causing it to be absent or to
> not work.
> 
> In one case, the whole system lagged, that means, the log in screen
> stayed grayed out for 15 seconds, and the mouse pointer stopped moving
> every 20(?) seconds for some seconds.
> 

Can you please confirm if you're indicating this is a regression in 4.15?
Or was this present in earlier kernels too?

If it's specific to 4.15, I've got a few steps I'd like you to try to better
characterize.

1) can you please apply https://patchwork.kernel.org/patch/10194287/
and let us know if it helps?

2) If you blacklist dell-smbios-wmi does it help?

Thanks,
