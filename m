Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933177AbeBVQRz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 11:17:55 -0500
Received: from esa5.dell-outbound.iphmx.com ([68.232.153.95]:10780 "EHLO
        esa5.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933108AbeBVQRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 11:17:53 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2G/AQBN7I5ah8uZ6ERcGQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQcBAQEBAYQlgQAoCoNemCCCAoEWaocXjk2CFgqFNAIaghRWFgECAQEBAQE?=
 =?us-ascii?q?BAgECEAEBAQoLCQgoL4I4IoJKAQEBBCMRRQwEAgEIEQQBAQECAiMDAgICHyUBC?=
 =?us-ascii?q?AgCBAENBQiKAwMVqyOCJ4c2DYEyghMBAQEBAQEBAQEBAQEBAQEBAQEBAQEdgQ+?=
 =?us-ascii?q?ECoInhmyBSQGBIoI+ECOCXYJlBaQKNQmRA4UCgimGKIt8jlSJVoE8JgiBfHCDE?=
 =?us-ascii?q?oJkghJ4AYwVgRkBAQE?=
X-IPAS-Result: =?us-ascii?q?A2G/AQBN7I5ah8uZ6ERcGQEBAQEBAQEBAQEBAQcBAQEBAYQ?=
 =?us-ascii?q?lgQAoCoNemCCCAoEWaocXjk2CFgqFNAIaghRWFgECAQEBAQEBAgECEAEBAQoLC?=
 =?us-ascii?q?QgoL4I4IoJKAQEBBCMRRQwEAgEIEQQBAQECAiMDAgICHyUBCAgCBAENBQiKAwM?=
 =?us-ascii?q?VqyOCJ4c2DYEyghMBAQEBAQEBAQEBAQEBAQEBAQEBAQEdgQ+ECoInhmyBSQGBI?=
 =?us-ascii?q?oI+ECOCXYJlBaQKNQmRA4UCgimGKIt8jlSJVoE8JgiBfHCDEoJkghJ4AYwVgRk?=
 =?us-ascii?q?BAQE?=
From: <Mario.Limonciello@dell.com>
X-LoopCount0: from 10.166.132.190
X-IronPort-AV: E=Sophos;i="5.47,378,1515477600";
   d="scan'208";a="1055115621"
X-DLP: DLP_GlobalPCIDSS
To: <jeremy@jcline.org>, <notmart@gmail.com>
CC: <pali.rohar@gmail.com>, <andriy.shevchenko@linux.intel.com>,
        <mjg59@srcf.ucam.org>, <dvhart@infradead.org>,
        <platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: Regression: Dell XPS 13 9360 keyboard no longer works
Thread-Topic: Regression: Dell XPS 13 9360 keyboard no longer works
Thread-Index: AQHTq5v56OaYoDnjuECSi8YlbIDbbaOwiM4igAAAcxCAAHAoAP//n4VwgABlkoD//5uHsA==
Date: Thu, 22 Feb 2018 16:17:50 +0000
Message-ID: <722a48c6c0354609bf34f86c4269aef9@ausx13mpc120.AMER.DELL.COM>
References: <01000161bbeed4e3-8160ffbc-0998-453d-9afd-14b7dd80dd53-000000@email.amazonses.com>
 <1628582.nV6hDClBbL@phobos>
 <01000161bdd7f206-c8d87cce-1b8c-4888-8d6a-5247198b3ead-000000@email.amazonses.com>
 <CAD6_Bos5Qrvz=Mr_rYCZXZ1s=5+8rawfZXxzXSvyc-tLBO07fg@mail.gmail.com>
 <b9b9ad823d9e49df82fc4626124c2a14@ausx13mpc120.AMER.DELL.COM>
 <01000161be3d1072-1c155203-359c-4566-9af6-2ebc33ad43ee-000000@email.amazonses.com>
 <c7694c9b4780413cb9621b0f3dd1501d@ausx13mpc120.AMER.DELL.COM>
 <01000161be4dbc6d-571d7479-35a2-4c6d-b3e0-f2405fc2064a-000000@email.amazonses.com>
In-Reply-To: <01000161be4dbc6d-571d7479-35a2-4c6d-b3e0-f2405fc2064a-000000@email.amazonses.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.18.86]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1MGI1GH029415

> -----Original Message-----
> From: platform-driver-x86-owner@vger.kernel.org [mailto:platform-driver-x86-
> owner@vger.kernel.org] On Behalf Of Jeremy Cline
> Sent: Thursday, February 22, 2018 10:17 AM
> To: Limonciello, Mario <Mario_Limonciello@Dell.com>; notmart@gmail.com
> Cc: pali.rohar@gmail.com; andriy.shevchenko@linux.intel.com;
> mjg59@srcf.ucam.org; dvhart@infradead.org; platform-driver-
> x86@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: Regression: Dell XPS 13 9360 keyboard no longer works
> 
> On 02/22/2018 11:14 AM, Mario.Limonciello@dell.com wrote:
> >> -----Original Message-----
> >> From: Jeremy Cline [mailto:jeremy@jcline.org]
> >> Sent: Thursday, February 22, 2018 9:59 AM
> >> To: Limonciello, Mario <Mario_Limonciello@Dell.com>; notmart@gmail.com
> >> Cc: pali.rohar@gmail.com; andriy.shevchenko@linux.intel.com;
> >> mjg59@srcf.ucam.org; dvhart@infradead.org; platform-driver-
> >> x86@vger.kernel.org; linux-kernel@vger.kernel.org
> >> Subject: Re: Regression: Dell XPS 13 9360 keyboard no longer works
> >>
> >> On 02/22/2018 10:21 AM, Mario.Limonciello@dell.com wrote:> I guess that
> >> means we got this wrong and the patch should be reverted
> >>> until we figure this out.
> >>>
> >>> Jeremy,
> >>>
> >>> Can you please confirm what BIOS version you are on?
> >>> Also Is this a 9360 with 7th or 8th gen Intel CPU?
> >>
> >> Hi Mario,
> >>
> >> I've got BIOS version 2.5.0 with the 7th gen Intel CPU.
> >>
> >>
> >> Regards,
> >> Jeremy
> >
> > Jeremy,
> >
> > Thanks.  Do you have any of the Dell docks (TB16/WD15)?  If so are you connected
> to any dock
> > when reproducing this problem?
> 
> Mario,
> 
> I do have a TB16. I can reproduce this whether or not I'm connected to
> the dock, though.
> 
> 
> Regards,
> Jeremy

Jeremy,

Can you try booting up from a cold boot with it connected to see if it still happens?
