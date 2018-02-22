Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932983AbeBVPVu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 10:21:50 -0500
Received: from esa1.dell-outbound.iphmx.com ([68.232.153.90]:14795 "EHLO
        esa1.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932828AbeBVPVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 10:21:48 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2G/AQCx3o5ah8mZ6ERcGQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQcBAQEBAYQlgQAoCoNemB+CAoEWaocXjk2CFgqFNAIaghRWFgECAQEBAQE?=
 =?us-ascii?q?BAgECEAEBAQoLCQgoL4I4IoJKAQEBBCMROgsMBAIBCBEEAQEBAgIjAwICAh8lA?=
 =?us-ascii?q?QgIAgQBDQUIigMDFap/gieDV4NgDYEyghMBAQEBAQEBAwEBAQEBAQEBAQEBHYE?=
 =?us-ascii?q?PhAqCJ4M9AYMugUkBgSKCPh8Ugl2CZQWSVpE0NQmRA4UCgimGKIt8jlSJVoE8J?=
 =?us-ascii?q?QGCBHBPgkOCZIISeAGMFYEZAQEB?=
X-IPAS-Result: =?us-ascii?q?A2G/AQCx3o5ah8mZ6ERcGQEBAQEBAQEBAQEBAQcBAQEBAYQ?=
 =?us-ascii?q?lgQAoCoNemB+CAoEWaocXjk2CFgqFNAIaghRWFgECAQEBAQEBAgECEAEBAQoLC?=
 =?us-ascii?q?QgoL4I4IoJKAQEBBCMROgsMBAIBCBEEAQEBAgIjAwICAh8lAQgIAgQBDQUIigM?=
 =?us-ascii?q?DFap/gieDV4NgDYEyghMBAQEBAQEBAwEBAQEBAQEBAQEBHYEPhAqCJ4M9AYMug?=
 =?us-ascii?q?UkBgSKCPh8Ugl2CZQWSVpE0NQmRA4UCgimGKIt8jlSJVoE8JQGCBHBPgkOCZII?=
 =?us-ascii?q?SeAGMFYEZAQEB?=
From: <Mario.Limonciello@dell.com>
X-LoopCount0: from 10.166.132.172
X-IronPort-AV: E=Sophos;i="5.47,377,1515477600";
   d="scan'208";a="621242620"
X-DLP: DLP_GlobalPCIDSS
To: <notmart@gmail.com>, <jeremy@jcline.org>
CC: <pali.rohar@gmail.com>, <andriy.shevchenko@linux.intel.com>,
        <mjg59@srcf.ucam.org>, <dvhart@infradead.org>,
        <platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: Regression: Dell XPS 13 9360 keyboard no longer works
Thread-Topic: Regression: Dell XPS 13 9360 keyboard no longer works
Thread-Index: AQHTq5v56OaYoDnjuECSi8YlbIDbbaOwiM4igAAAcxA=
Date: Thu, 22 Feb 2018 15:21:45 +0000
Message-ID: <b9b9ad823d9e49df82fc4626124c2a14@ausx13mpc120.AMER.DELL.COM>
References: <01000161bbeed4e3-8160ffbc-0998-453d-9afd-14b7dd80dd53-000000@email.amazonses.com>
 <1628582.nV6hDClBbL@phobos>
 <01000161bdd7f206-c8d87cce-1b8c-4888-8d6a-5247198b3ead-000000@email.amazonses.com>
 <CAD6_Bos5Qrvz=Mr_rYCZXZ1s=5+8rawfZXxzXSvyc-tLBO07fg@mail.gmail.com>
In-Reply-To: <CAD6_Bos5Qrvz=Mr_rYCZXZ1s=5+8rawfZXxzXSvyc-tLBO07fg@mail.gmail.com>
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
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1MFLrgs006776

> -----Original Message-----
> From: Marco Martin [mailto:notmart@gmail.com]
> Sent: Thursday, February 22, 2018 9:16 AM
> To: Jeremy Cline <jeremy@jcline.org>
> Cc: Limonciello, Mario <Mario_Limonciello@Dell.com>; Pali Rohár
> <pali.rohar@gmail.com>; Andy Shevchenko <andriy.shevchenko@linux.intel.com>;
> Matthew Garrett <mjg59@srcf.ucam.org>; Darren Hart <dvhart@infradead.org>;
> Platform Driver <platform-driver-x86@vger.kernel.org>; Linux Kernel Mailing List
> <linux-kernel@vger.kernel.org>
> Subject: Re: Regression: Dell XPS 13 9360 keyboard no longer works
> 
> On Thu, Feb 22, 2018 at 3:08 PM, Jeremy Cline <jeremy@jcline.org> wrote:
> > Input driver version is 1.0.1
> > Input device ID: bus 0x19 vendor 0x0 product 0x0 version 0x0
> > Input device name: "Intel Virtual Button driver"
> > Supported events:
> >   Event type 0 (EV_SYN)
> >   Event type 1 (EV_KEY)
> >     Event code 114 (KEY_VOLUMEDOWN)
> >     Event code 115 (KEY_VOLUMEUP)
> >     Event code 116 (KEY_POWER)
> >     Event code 125 (KEY_LEFTMETA)
> >     Event code 240 (KEY_UNKNOWN)
> >     Event code 561 (?)
> >   Event type 4 (EV_MSC)
> >     Event code 4 (MSC_SCAN)
> >   Event type 5 (EV_SW)
> >     Event code 1 (SW_TABLET_MODE) state 1
> > Properties:
> > Testing ... (interrupt to exit)
> 
> Indeed, it's thinking a switch exists and that is on, which is wrong,
> then i guess VGBS() reports a wrong status..
> Mario, do you have any ideas about that?
> 
> --
> Marco Martin

I guess that means we got this wrong and the patch should be reverted
until we figure this out.

Jeremy,

Can you please confirm what BIOS version you are on?
Also Is this a 9360 with 7th or 8th gen Intel CPU?

I'll see if I can find out anything more relative to this.
