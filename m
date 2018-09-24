Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF27C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90CD12087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:54:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90CD12087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732660AbeIXU5M convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:57:12 -0400
Received: from mga04.intel.com ([192.55.52.120]:56740 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730426AbeIXU5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:57:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2018 07:54:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,298,1534834800"; 
   d="scan'208";a="266226533"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by fmsmga006.fm.intel.com with ESMTP; 24 Sep 2018 07:50:27 -0700
Received: from fmsmsx101.amr.corp.intel.com (10.18.124.199) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Mon, 24 Sep 2018 07:50:27 -0700
Received: from BGSMSX108.gar.corp.intel.com (10.223.4.192) by
 fmsmsx101.amr.corp.intel.com (10.18.124.199) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Mon, 24 Sep 2018 07:50:26 -0700
Received: from bgsmsx106.gar.corp.intel.com ([169.254.1.92]) by
 BGSMSX108.gar.corp.intel.com ([169.254.8.229]) with mapi id 14.03.0319.002;
 Mon, 24 Sep 2018 20:20:23 +0530
From:   "Banik, Subrata" <subrata.banik@intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rajat Jain <rajatja@google.com>
CC:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatxjain@gmail.com>,
        "Bohra, Aamir" <aamir.bohra@intel.com>
Subject: RE: [PATCH] pinctrl: icelake: Fix the resource number for
 community-4/5
Thread-Topic: [PATCH] pinctrl: icelake: Fix the resource number for
 community-4/5
Thread-Index: AQHUS7Gax6fem7zxmUSF6DZCTbC4SKTvBtIAgADjIICAAAkCgIAJJagAgAYRc4CAAGl+YA==
Date:   Mon, 24 Sep 2018 14:50:23 +0000
Message-ID: <70D28D5DAE32E9429B09AA8B7C84AC472C0000CB@BGSMSX106.gar.corp.intel.com>
References: <20180913223143.12664-1-rajatja@google.com>
 <CAHp75VcVkp6i_4oNVJvzde13MwaRQge91mvZF2aXgneZC9nzWg@mail.gmail.com>
 <CACK8Z6FhJhhfgk1zPMv5M0oRwz=o75YOKFmU+4Wx-X9-prPnKA@mail.gmail.com>
 <CACK8Z6GeZ+2uRsRDPfdd=i+WrdQwQgEBvEyDxQuKLygXqPp4dw@mail.gmail.com>
 <CACK8Z6FLPVSJpPuAXZsqHV2rY2zy3L-Fvd=QPn=+Ynp3aHyhaQ@mail.gmail.com>
 <20180924135935.GP15943@smile.fi.intel.com>
In-Reply-To: <20180924135935.GP15943@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYWRjY2I3OWItMzNkMy00YTA4LWI1M2ItMGQxZWJjMTg0NTcxIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoicUJ0YzRZTXJodGI0Q25nMWJEd2FRT0N2NHZuM3FBUVJiMkdkUU5SbTlQSjljU1llaWtPME9SZ3o3a01OUFo3MiJ9
x-originating-ip: [10.223.10.10]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Andy,

You are right that this ASL code is not same with Intel reference BIOS code because BIOS sources are different between what you are looking vs what Chrome OS is using. In Coreboot BIOS, we are more relying on EDS spec and as COM 3 is dedicated for CPU GPIO hence we are mapping, 0/1/2/4/5 (whatever present in EDS vol 1.1)

We have ensured that PCR ID and offsets are correct in ASL code for respective community, I don't think anything else really matter from BIOS unless you tell me, that you are having any required that your drive code will only probe for 4 COMM for LP and 5 for ICL-H?

Thanks,
Subrata

-----Original Message-----
From: Andy Shevchenko [mailto:andy.shevchenko@gmail.com] 
Sent: Monday, September 24, 2018 7:30 PM
To: Rajat Jain <rajatja@google.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>; Linus Walleij <linus.walleij@linaro.org>; linux-gpio@vger.kernel.org; Linux Kernel Mailing List <linux-kernel@vger.kernel.org>; Rajat Jain <rajatxjain@gmail.com>; Banik, Subrata <subrata.banik@intel.com>; Bohra, Aamir <aamir.bohra@intel.com>
Subject: Re: [PATCH] pinctrl: icelake: Fix the resource number for community-4/5

On Thu, Sep 20, 2018 at 10:19:34AM -0700, Rajat Jain wrote:
> On Fri, Sep 14, 2018 at 2:38 PM Rajat Jain <rajatja@google.com> wrote:
> > On Fri, Sep 14, 2018 at 2:06 PM Rajat Jain <rajatja@google.com> wrote:
> > > On Fri, Sep 14, 2018 at 12:41 AM Andy Shevchenko 
> > > <andy.shevchenko@gmail.com> wrote:
> > > > On Fri, Sep 14, 2018 at 1:54 AM Rajat Jain <rajatja@google.com> wrote:
> > > > >
> > > > > The Icelake does not have a community-3, and the memory 
> > > > > resources are laid out in the following order in the ACPI:
> > > > >
> > > > > resource-0: community-0 registers
> > > > > resource-1: community-1 registers
> > > > > resource-2: community-2 registers
> > > > > resource-3: community-4 registers
> > > > > resource-4: community-5 registers
> > > > >
> > > > > (EDS also describes the communities in the above order).
> > > > >
> > > > > Since the pinctrl driver exposes communities 0, 1, 4, 5, it 
> > > > > needs to get the corresponding community registers by getting the resourse number right.
> > > > > Currently the resourse number is not correct for community 4 
> > > > > and 5, thus fix that.
> > > > >
> > > >
> > > > Can you share link to the ACPI dump of the tables? (you may get 
> > > > one by running `acpidump -o tables.dat`)
> 
> Hello Andy,
> 
> Any feedback on this patch? I provided a dump of the ACPI below, 
> please let me know if you need more info.

Sorry it took a while (I had to get tested on our reference BIOS(es) on Ice Lake platforms we have).
See my reply below.

> > > I don't have that command on my system, but I took 
> > > /sys/firmware/acpi/tables/DSDT from the system and disassembled it 
> > > using Intel disassembler (iasl -d) and here is the relevant 
> > > portion that describes the GPIO controller. The port IDs for 
> > > communities can be seen in the below output (i.e. the PCRB()):
> >
> > I realized PCRB() is an ACPI method defined in the same disasembly:
> >
> >             Method (PCRB, 1, NotSerialized)
> >             {
> >                 Return ((0xFD000000 + (Arg0 << 0x10)))
> >             }
> >
> > >
> > >             Device (GPIO)
> > >             {
> > >                 Name (_HID, "INT3455")  // _HID: Hardware ID
> > >                 Name (_UID, Zero)  // _UID: Unique ID
> > >                 Name (_DDN, "GPIO Controller")  // _DDN: DOS Device Name
> > >                 Name (RBUF, ResourceTemplate ()
> > >                 {
> > >                     Memory32Fixed (ReadWrite,
> > >                         0x00000000,         // Address Base
> > >                         0x00000000,         // Address Length
> > >                         _Y06)
> > >                     Memory32Fixed (ReadWrite,
> > >                         0x00000000,         // Address Base
> > >                         0x00000000,         // Address Length
> > >                         _Y07)
> > >                     Memory32Fixed (ReadWrite,
> > >                         0x00000000,         // Address Base
> > >                         0x00000000,         // Address Length
> > >                         _Y08)
> > >                     Memory32Fixed (ReadWrite,
> > >                         0x00000000,         // Address Base
> > >                         0x00000000,         // Address Length
> > >                         _Y09)
> > >                     Memory32Fixed (ReadWrite,
> > >                         0x00000000,         // Address Base
> > >                         0x00000000,         // Address Length
> > >                         _Y0A)
> > >                     Interrupt (ResourceConsumer, Level, ActiveLow, Shared, ,, )
> > >                     {
> > >                         0x0000000E,
> > >                     }
> > >                 })
> > >                 Method (_CRS, 0, NotSerialized)  // _CRS: Current 
> > > Resource Settings
> > >                 {
> > >                     CreateDWordField (RBUF, 
> > > \_SB.PCI0.GPIO._Y06._BAS,
> > > BAS0)  // _BAS: Base Address
> > >                     CreateDWordField (RBUF, 
> > > \_SB.PCI0.GPIO._Y06._LEN,
> > > LEN0)  // _LEN: Length
> > >                     BAS0 = PCRB (0x6E)
> > >                     LEN0 = 0x00010000
> > >                     CreateDWordField (RBUF, 
> > > \_SB.PCI0.GPIO._Y07._BAS,
> > > BAS1)  // _BAS: Base Address
> > >                     CreateDWordField (RBUF, 
> > > \_SB.PCI0.GPIO._Y07._LEN,
> > > LEN1)  // _LEN: Length
> > >                     BAS1 = PCRB (0x6D)
> > >                     LEN1 = 0x00010000
> > >                     CreateDWordField (RBUF, 
> > > \_SB.PCI0.GPIO._Y08._BAS,
> > > BAS2)  // _BAS: Base Address
> > >                     CreateDWordField (RBUF, 
> > > \_SB.PCI0.GPIO._Y08._LEN,
> > > LEN2)  // _LEN: Length
> > >                     BAS2 = PCRB (0x6C)
> > >                     LEN2 = 0x00010000
> > >                     CreateDWordField (RBUF, 
> > > \_SB.PCI0.GPIO._Y09._BAS,
> > > BAS4)  // _BAS: Base Address
> > >                     CreateDWordField (RBUF, 
> > > \_SB.PCI0.GPIO._Y09._LEN,
> > > LEN4)  // _LEN: Length
> > >                     BAS4 = PCRB (0x6A)
> > >                     LEN4 = 0x00010000
> > >                     CreateDWordField (RBUF, 
> > > \_SB.PCI0.GPIO._Y0A._BAS,
> > > BAS5)  // _BAS: Base Address
> > >                     CreateDWordField (RBUF, 
> > > \_SB.PCI0.GPIO._Y0A._LEN,
> > > LEN5)  // _LEN: Length
> > >                     BAS5 = PCRB (0x69)
> > >                     LEN5 = 0x00010000
> > >                     Return (RBUF) /* \_SB_.PCI0.GPIO.RBUF */
> > >                 }
> > >
> > >                 Method (_STA, 0, NotSerialized)  // _STA: Status
> > >                 {
> > >                     Return (0x0F)
> > >                 }
> > >             }
> > >
> > > Please let me know if this helps, or if you need more info.

First of all, this is pre-production chip, so, I don't think there is a bug in the driver (yet) discovered.

Looking to the above ASL code I may conclude that is definitely is *not* from our reference BIOS.
I have checked two versions of it and found that in both we have the following mapping:
for LP variant: there are only 4 communities are exported for H variant: there are only 5 communities are exported

So, I guess the problem is in ASL code you provided. It simple should not export that community at all.

In case you need to do so, there are ways:
 - contact Intel and ask for a change in reference BIOS
 - acquire another ACPI ID for the case, or, perhaps use special constants like
   _HRV for that purpose (also need to contact Intel while doing that)

P.S. I think EDS covers it as it present in HW, though not exported by FW.

--
With Best Regards,
Andy Shevchenko


