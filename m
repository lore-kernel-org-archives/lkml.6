Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162421AbeBOPWe (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 10:22:34 -0500
Received: from esa3.dell-outbound.iphmx.com ([68.232.153.94]:29845 "EHLO
        esa3.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1162407AbeBOPW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 10:22:29 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2GtCQBbpIVah8uZ6ERdGQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQcBAQEBAYQoEHAoCoNbmCkxgVGBF2sxhmOOW4IDChuBE4QNAhqCKFgUAQI?=
 =?us-ascii?q?BAQEBAQECAQIQAQEBCgsJCCgiDYI4IoE0WzsBAQEEIxFFDAQCAQgRBAEBAQICI?=
 =?us-ascii?q?wMCAgIfJQEICAIEAQ0FCIoVAxWuRoInhz4NgTKCEwEBAQEBAQEBAQEBAQEBAQE?=
 =?us-ascii?q?BAQEBAR2BD4N0gieGbYJrgX8EOxAjgl2CZQWKZYlgjzg1CYgghAiEUoUCgihnh?=
 =?us-ascii?q?UOLfY5NhVABg36BPDaBdHCDGAmCTBAMggZ4i3AqgQqBGQEBAQ?=
X-IPAS-Result: =?us-ascii?q?A2GtCQBbpIVah8uZ6ERdGQEBAQEBAQEBAQEBAQcBAQEBAYQ?=
 =?us-ascii?q?oEHAoCoNbmCkxgVGBF2sxhmOOW4IDChuBE4QNAhqCKFgUAQIBAQEBAQECAQIQA?=
 =?us-ascii?q?QEBCgsJCCgiDYI4IoE0WzsBAQEEIxFFDAQCAQgRBAEBAQICIwMCAgIfJQEICAI?=
 =?us-ascii?q?EAQ0FCIoVAxWuRoInhz4NgTKCEwEBAQEBAQEBAQEBAQEBAQEBAQEBAR2BD4N0g?=
 =?us-ascii?q?ieGbYJrgX8EOxAjgl2CZQWKZYlgjzg1CYgghAiEUoUCgihnhUOLfY5NhVABg36?=
 =?us-ascii?q?BPDaBdHCDGAmCTBAMggZ4i3AqgQqBGQEBAQ?=
From: <Mario.Limonciello@dell.com>
X-LoopCount0: from 10.166.132.198
X-IronPort-AV: E=Sophos;i="5.46,517,1511848800";
   d="scan'208";a="214953993"
X-DLP: DLP_GlobalPCIDSS
To: <pmenzel+linux-input@molgen.mpg.de>, <dmitry.torokhov@gmail.com>
CC: <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <it+linux-input@molgen.mpg.de>, <linux@leemhuis.info>
Subject: RE: i8042 AUX port [serio1] suspend takes a second on Dell XPS 13
 9360
Thread-Topic: i8042 AUX port [serio1] suspend takes a second on Dell XPS 13
 9360
Thread-Index: AQHTpbKybUmpckaH40yGvHCktg4tlqOkIKZggAFl4wCAAA1goA==
Date: Thu, 15 Feb 2018 15:22:25 +0000
Message-ID: <33355407b8d74575bab0c36e442141ea@ausx13mpc120.AMER.DELL.COM>
References: <5a74e1a7-2083-c6b2-f51a-f44908ac8bc4@molgen.mpg.de>
 <20180130175017.72inurhk5l7tcvae@dtor-ws>
 <20180130180736.ehucqywbz7zdl4v7@dtor-ws>
 <f02b699d-b130-c09f-3e09-db62ecf2df2c@molgen.mpg.de>
 <609c1f35df7346da8ac1d12c35e04cf7@ausx13mpc120.AMER.DELL.COM>
 <b9223169-2282-4ada-999a-7f50d205ca7d@molgen.mpg.de>
In-Reply-To: <b9223169-2282-4ada-999a-7f50d205ca7d@molgen.mpg.de>
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
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1FFMjjx015521

> -----Original Message-----
> From: Paul Menzel [mailto:pmenzel+linux-input@molgen.mpg.de]
> Sent: Thursday, February 15, 2018 2:26 AM
> To: Limonciello, Mario <Mario_Limonciello@Dell.com>; Dmitry Torokhov
> <dmitry.torokhov@gmail.com>
> Cc: linux-input@vger.kernel.org; linux-kernel@vger.kernel.org; it+linux-
> input@molgen.mpg.de; linux@leemhuis.info
> Subject: Re: i8042 AUX port [serio1] suspend takes a second on Dell XPS 13 9360
> 
> Dear Mario, dear Dmitry,
> 
> 
> On 02/14/18 18:11, Mario.Limonciello@dell.com wrote:
> >
> >
> >> -----Original Message-----
> >> From: Paul Menzel [mailto:pmenzel+linux-input@molgen.mpg.de]
> >> Sent: Wednesday, February 14, 2018 10:41 AM
> >> To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> >> Cc: linux-input@vger.kernel.org; linux-kernel@vger.kernel.org; it+linux-
> >> input@molgen.mpg.de; Limonciello, Mario <Mario_Limonciello@Dell.com>;
> >> Thorsten Leemhuis <linux@leemhuis.info>
> >> Subject: Re: i8042 AUX port [serio1] suspend takes a second on Dell XPS 13 9360
> 
> >> On 01/30/18 19:07, Dmitry Torokhov wrote:
> >>> On Tue, Jan 30, 2018 at 09:52:45AM -0800, Dmitry Torokhov wrote:
> >>
> >>>> On Tue, Jan 30, 2018 at 06:36:34PM +0100, Paul Menzel wrote:
> >>
> >>>>> I do not know, when it started, but with Linux 4.14-rc8 and 4.15,
> >>>>> benchmarking suspend and resume time with `sleepgraph.py` [1][2], there is
> a
> >>>>> regression, that i8042 AUX port [serio1] suspend takes a second on Dell XPS
> >>>>> 13 9360 and TUXEDO Book 1406.
> >>>>
> >>>> It would be really helpful to know when the regression started.
> >>>
> >>> So the reason it takes longer is because the touchpad does not want to
> >>> talk to us for some reason and we wait until commands time out:
> >>>
> >>> [   94.591636] calling  serio1+ @ 2299, parent: i8042
> >>> [   94.794292] psmouse serio1: Failed to disable mouse on isa0060/serio1
> >>> [   95.593303] call serio1+ returned 0 after 974280 usecs
> >>>
> >>> but it is not clear why it happens, I do not think we changed anything
> >>> in that path for a while, so it might be some other change affecting
> >>> things indirectly. I'm afraid you'll have to narrow the scope, and
> >>> ideally bisect.
> >
> > Please keep in mind the XPS 9360 has a touchpad that can operate in I2C
> > or PS2 modes.  It's connected to both buses and with the right initialization
> > sequence will come up in I2C mode.
> >
> > Assuming Paul M. has compiled and used hid-multitouch and i2c-hid the
> > touchpad should be operating in I2C mode.
> >
> > When this happens I expect that the touchpad shouldn't be responding
> > to PS2 commands.
> >
> > As a debugging tactic, you may consider to unload psmouse before
> > suspend and still see the touchpad operational.
> 
> Thank you! Unloading *psmouse* with `sudo modprobe -r psmouse` indeed
> worked on the Dell XPS 13 9360, that means, the cursor is still functioning.
> 
> >> Thank you for your replies. First of all, it looks like *only* the Dell
> >> system is effected as I was unable to reproduce it on the TUXEDO Book
> >> 1406. I have to verify that by finding old log files.
> >
> > Does this other laptop you are drawing a comparison to also have a
> > touchpad that can operate in multiple modes?
> >
> > To make an accurate comparison you should determine what mode it's in.
> 
> Yeah, removing the module *psmouse*, the cursor didn’t work there
> anymore. I was really sure, that I saw that problem once on the TUXEDO
> device too, but must have been mistaken, that’s why I corrected it.
> Sorry for the misunderstanding.
> 
> So, why does *psmouse* get loaded on the Dell XPS 13 9360 since at least
> Linux 4.13? Or where the modules added causing the touchpad to operate
> in I2C mode, which causes PS2 to stop to work?
> 

It was like that before this laptop even launched to the market.
It's been like that since way before 4.13.  I want to say maybe 3.13ish is when
I2C mode would come up instead.

The order of events goes something like this:
1) Touchpad is initially in PS2 mode
2) psmouse loads
3) It reports that it may be supportable by a different bus
4) The sequence to switch to I2C mode happens
5) i2c-hid and hid-multitouch get loaded
6) psmouse is no longer functional

Dmitry is there a way that we can connect the two events?  When i2c-hid finds
the touchpad notify psmouse to unload or at least stop trying to access it to prevent
the problem Paul is talking about with suspend?
