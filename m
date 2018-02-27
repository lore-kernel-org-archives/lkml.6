Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752693AbeB0QPK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 11:15:10 -0500
Received: from esa1.dell-outbound.iphmx.com ([68.232.153.90]:26750 "EHLO
        esa1.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752130AbeB0QPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 11:15:08 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2HTAABWg5Vah8mZ6EReGQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQcBAQEBAYQmgQAoCoNKmCGCAoEWhyGPHgqFMgIagjJXFQECAQEBAQEBAgE?=
 =?us-ascii?q?CEAEBAQoLCQgoL4I4IoJKAQEBAQMjEUUMBAIBCBEEAQEBAgIjAwICAh8lAQgIA?=
 =?us-ascii?q?gQOBQiEdQMVqzuCJ4czDYEwghQBAQEBAQEBAQEBAQEBAQEBAQEBH4EPhjuDPYM?=
 =?us-ascii?q?tgmqCPhAjEoJBgmIFmh4wCY04gzCOfYozhx2BLjSBdHCDEoJAEwyBe3eLO4EXA?=
 =?us-ascii?q?QEB?=
X-IPAS-Result: =?us-ascii?q?A2HTAABWg5Vah8mZ6EReGQEBAQEBAQEBAQEBAQcBAQEBAYQ?=
 =?us-ascii?q?mgQAoCoNKmCGCAoEWhyGPHgqFMgIagjJXFQECAQEBAQEBAgECEAEBAQoLCQgoL?=
 =?us-ascii?q?4I4IoJKAQEBAQMjEUUMBAIBCBEEAQEBAgIjAwICAh8lAQgIAgQOBQiEdQMVqzu?=
 =?us-ascii?q?CJ4czDYEwghQBAQEBAQEBAQEBAQEBAQEBAQEBH4EPhjuDPYMtgmqCPhAjEoJBg?=
 =?us-ascii?q?mIFmh4wCY04gzCOfYozhx2BLjSBdHCDEoJAEwyBe3eLO4EXAQEB?=
From: <Mario.Limonciello@dell.com>
X-LoopCount0: from 10.166.132.172
X-IronPort-AV: E=Sophos;i="5.47,401,1515477600";
   d="scan'208";a="220318912"
X-DLP: DLP_GlobalPCIDSS
To: <andy.shevchenko@gmail.com>
CC: <dvhart@infradead.org>, <pali.rohar@gmail.com>,
        <linux-kernel@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>
Subject: RE: [PATCH 1/3] platform/x86: dell-smbios: Correct some style
 warnings
Thread-Topic: [PATCH 1/3] platform/x86: dell-smbios: Correct some style
 warnings
Thread-Index: AQHTr+UtT1WLSfvhjkKlO8GzrUNc7aO4bGQQ
Date: Tue, 27 Feb 2018 16:15:04 +0000
Message-ID: <a7bb6d4240f04d7ba5b1f07a1087ee64@ausx13mpc124.AMER.DELL.COM>
References: <1519747014-17561-1-git-send-email-mario.limonciello@dell.com>
 <CAHp75VfS4vif1_S1Z=z2jAZfERmsiqG0h0j5k6zrmjiQwPGekA@mail.gmail.com>
In-Reply-To: <CAHp75VfS4vif1_S1Z=z2jAZfERmsiqG0h0j5k6zrmjiQwPGekA@mail.gmail.com>
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
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1RGFHI7000910

> -----Original Message-----
> From: platform-driver-x86-owner@vger.kernel.org [mailto:platform-driver-x86-
> owner@vger.kernel.org] On Behalf Of Andy Shevchenko
> Sent: Tuesday, February 27, 2018 10:04 AM
> To: Limonciello, Mario <Mario_Limonciello@Dell.com>
> Cc: Darren Hart <dvhart@infradead.org>; Pali Rohár <pali.rohar@gmail.com>;
> LKML <linux-kernel@vger.kernel.org>; Platform Driver <platform-driver-
> x86@vger.kernel.org>
> Subject: Re: [PATCH 1/3] platform/x86: dell-smbios: Correct some style warnings
> 
> On Tue, Feb 27, 2018 at 5:56 PM, Mario Limonciello
> <mario.limonciello@dell.com> wrote:
> 
> >         /* 4 bytes of table header, plus 7 bytes of Dell header, plus at least
> > -          6 bytes of entry */
> > +        * 6 bytes of entry
> > +        */
> 
> I would prefer not to mix with net style, since you are fixing this, perhaps
> 
> /*
>  * 4 ...
>  * 6 ...
>  */
> 
> ?
> 
Thanks, will adjust again when I resubmit with changes for 3/3.
