Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752066AbeCZHdI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 03:33:08 -0400
Received: from esa1.dell-outbound.iphmx.com ([68.232.153.90]:52691 "EHLO
        esa1.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751713AbeCZHdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 03:33:05 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2E5AABUobhamMqZ6EReGQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQcBAQEBAYQUfigKg1KIAI0NgXSBEWCRcRSBcguFBQIag14hNBgBAgEBAQE?=
 =?us-ascii?q?BAQIBAhABAQEBAQgLCwYoL4I4IoJMAQEBBCMEDUUMBAIBCBEDAQEBAQICIwMCA?=
 =?us-ascii?q?gJEAQgIAgQBDQUIhQarOIFrNYg9ghqBCIZQghSBDIMHhDs/ECOCR4JUA4cnhE2?=
 =?us-ascii?q?LSwiOKYE4g1eHMo92gSUcggtwT4JDgiEOCo4Xb48SgRcBAQ?=
X-IPAS-Result: =?us-ascii?q?A2E5AABUobhamMqZ6EReGQEBAQEBAQEBAQEBAQcBAQEBAYQ?=
 =?us-ascii?q?UfigKg1KIAI0NgXSBEWCRcRSBcguFBQIag14hNBgBAgEBAQEBAQIBAhABAQEBA?=
 =?us-ascii?q?QgLCwYoL4I4IoJMAQEBBCMEDUUMBAIBCBEDAQEBAQICIwMCAgJEAQgIAgQBDQU?=
 =?us-ascii?q?IhQarOIFrNYg9ghqBCIZQghSBDIMHhDs/ECOCR4JUA4cnhE2LSwiOKYE4g1eHM?=
 =?us-ascii?q?o92gSUcggtwT4JDgiEOCo4Xb48SgRcBAQ?=
From: <Mario.Limonciello@dell.com>
X-LoopCount0: from 10.166.132.195
X-IronPort-AV: E=Sophos;i="5.48,364,1517896800";
   d="scan'208";a="1123102723"
X-DLP: DLP_GlobalPCIDSS
To: <pmenzel+linux-media@molgen.mpg.de>,
        <laurent.pinchart@ideasonboard.com>
CC: <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <it+linux-media@molgen.mpg.de>
Subject: RE: uvcvideo: Unknown video
 format,00000032-0002-0010-8000-00aa00389b71
Thread-Topic: uvcvideo: Unknown video
 format,00000032-0002-0010-8000-00aa00389b71
Thread-Index: AQHTwGsBJ4Wdud+nkUKVlZnwRh0K/aPawCUAgAA0zoCABzNNsA==
Date: Mon, 26 Mar 2018 07:32:54 +0000
Message-ID: <37ca77636fcf4c4185881f713a881120@ausx13mpc120.AMER.DELL.COM>
References: <8f7d4aef-84f7-ae22-8adc-cba4fa881675@molgen.mpg.de>
 <6647791.pjJyibMGYG@avalon>
 <2b332247-72f6-d9ad-306d-d900759ea5a8@molgen.mpg.de>
 <2929738.Pf5m835D8F@avalon>
 <c94135f6-8087-4c46-b0f2-0650906aa140@molgen.mpg.de>
In-Reply-To: <c94135f6-8087-4c46-b0f2-0650906aa140@molgen.mpg.de>
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
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2Q7XD2u011037

> -----Original Message-----
> From: Paul Menzel [mailto:pmenzel+linux-media@molgen.mpg.de]
> Sent: Wednesday, March 21, 2018 7:35 AM
> To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: linux-media@vger.kernel.org; linux-kernel@vger.kernel.org; it+linux-
> media@molgen.mpg.de; Limonciello, Mario <Mario_Limonciello@Dell.com>
> Subject: Re: uvcvideo: Unknown video format,00000032-0002-0010-8000-
> 00aa00389b71
> 
> Dear Laurent,
> 
> 
> On 03/21/2018 10:25 AM, Laurent Pinchart wrote:
> 
> > On Tuesday, 20 March 2018 18:46:24 EET Paul Menzel wrote:
> >> On 03/20/18 14:30, Laurent Pinchart wrote:
> >>> On Tuesday, 20 March 2018 14:20:14 EET Paul Menzel wrote:
> >>>> On the Dell XPS 13 9370, Linux 4.16-rc6 outputs the messages below.
> >>>>
> >>>> ```
> >>
> >> […]
> >>
> >>>> [    2.340736] input: Integrated_Webcam_HD: Integrate as
> >>>> /devices/pci0000:00/0000:00:14.0/usb1/1-5/1-5:1.0/input/input9
> >>>> [    2.341447] uvcvideo: Unknown video format
> >>>> 00000032-0002-0010-8000-00aa00389b71 >> [    2.341450] uvcvideo: Found
> >>>> UVC 1.00 device Integrated_Webcam_HD (0bda:58f4)
> >>
> >> […]
> >>
> >>>> ```
> >>>>
> >>>> Please tell me, what I can do to improve the situation.
> >>>
> >>> Some vendors routinely implement new formats without bothering to send a
> >>> patch for the uvcvideo driver. It would be easy to do so, but it requires
> >>> knowing which format is meant by the GUID. Most format GUIDs are of the
> >>> form 32595559-0000-0010-8000-00aa00389b71 that starts with a 4CC, but
> >>> that's not the case here.
> >>
> >> I am adding Mario to the receiver list, though he is currently on vacation.
> >>
> >>> Could you send me the output of
> >>>
> >>> lsusb -v -d 0bda:58f4
> >>>
> >>> running as root if possible ?
> >>
> >> Sure, please find it attached.
> >
> > Thank you.
> >
> > Could you please try the following patch ?
> >
> > commit 7b3dea984b380f5b4b5c1956a9c6c23966af2149
> > Author: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Date:   Wed Mar 21 11:16:40 2018 +0200
> >
> >      media: uvcvideo: Add KSMedia 8-bit IR format support
> >
> >      Add support for the 8-bit IR format GUID defined in the Microsoft Kernel
> >      Streaming Media API.
> >
> >      Reported-by: Paul Menzel <pmenzel+linux-media@molgen.mpg.de>
> >      Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >
> > diff --git a/drivers/media/usb/uvc/uvc_driver.c
> b/drivers/media/usb/uvc/uvc_driver.c
> > index 2469b49b2b30..3691d87ef869 100644
> > --- a/drivers/media/usb/uvc/uvc_driver.c
> > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > @@ -99,6 +99,11 @@ static struct uvc_format_desc uvc_fmts[] = {
> >   		.guid		= UVC_GUID_FORMAT_D3DFMT_L8,
> >   		.fcc		= V4L2_PIX_FMT_GREY,
> >   	},
> > +	{
> > +		.name		= "IR 8-bit (L8_IR)",
> > +		.guid		= UVC_GUID_FORMAT_KSMEDIA_L8_IR,
> > +		.fcc		= V4L2_PIX_FMT_GREY,
> > +	},
> >   	{
> >   		.name		= "Greyscale 10-bit (Y10 )",
> >   		.guid		= UVC_GUID_FORMAT_Y10,
> > diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> > index be5cf179228b..6b955e0dd956 100644
> > --- a/drivers/media/usb/uvc/uvcvideo.h
> > +++ b/drivers/media/usb/uvc/uvcvideo.h
> > @@ -157,6 +157,9 @@
> >   #define UVC_GUID_FORMAT_D3DFMT_L8 \
> >   	{0x32, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x00, \
> >   	 0x80, 0x00, 0x00, 0xaa, 0x00, 0x38, 0x9b, 0x71}
> > +#define UVC_GUID_FORMAT_KSMEDIA_L8_IR \
> > +	{0x32, 0x00, 0x00, 0x00, 0x02, 0x00, 0x10, 0x00, \
> > +	 0x80, 0x00, 0x00, 0xaa, 0x00, 0x38, 0x9b, 0x71}
> >
> >
> >   /* ------------------------------------------------------------------------
> 
> Sure. After fighting how to apply with Mozilla Thunderbird as my mailer
> – hints are welcome –, the warning is gone.
> 
> ```
> [    2.569788] calling  uvc_init+0x0/0x1000 [uvcvideo] @ 297
> [    2.570011] calling  cryptd_init+0x0/0x1000 [cryptd] @ 287
> [    2.570018] cryptd: max_cpu_qlen set to 1000
> [    2.570022] initcall cryptd_init+0x0/0x1000 [cryptd] returned 0 after
> 7 usecs
> [    2.570030] calling  init_nls_cp437+0x0/0x1000 [nls_cp437] @ 332
> [    2.570033] initcall init_nls_cp437+0x0/0x1000 [nls_cp437] returned 0
> after 0 usecs
> [    2.570502] uvcvideo: Found UVC 1.00 device Integrated_Webcam_HD
> (0bda:58f4)
> [    2.573583] uvcvideo 1-5:1.0: Entity type for entity Extension 4 was
> not initialized!
> [    2.573585] uvcvideo 1-5:1.0: Entity type for entity Extension 7 was
> not initialized!
> [    2.573586] uvcvideo 1-5:1.0: Entity type for entity Processing 2 was
> not initialized!
> [    2.573587] uvcvideo 1-5:1.0: Entity type for entity Camera 1 was not
> initialized!
> [    2.573652] input: Integrated_Webcam_HD: Integrate as
> /devices/pci0000:00/0000:00:14.0/usb1/1-5/1-5:1.0/input/input10
> [    2.574192] uvcvideo: Found UVC 1.00 device Integrated_Webcam_HD
> (0bda:58f4)
> [    2.575629] proc_thermal 0000:00:04.0: enabling device (0000 -> 0002)
> [    2.576052] uvcvideo: Unable to create debugfs 1-2 directory.
> [    2.576118] uvcvideo 1-5:1.2: Entity type for entity Extension 10 was
> not initialized!
> [    2.576119] uvcvideo 1-5:1.2: Entity type for entity Extension 12 was
> not initialized!
> [    2.576120] uvcvideo 1-5:1.2: Entity type for entity Processing 9 was
> not initialized!
> [    2.576121] uvcvideo 1-5:1.2: Entity type for entity Camera 11 was
> not initialized!
> [    2.576184] input: Integrated_Webcam_HD: Integrate as
> /devices/pci0000:00/0000:00:14.0/usb1/1-5/1-5:1.2/input/input11
> [    2.576229] usbcore: registered new interface driver uvcvideo
> [    2.576230] USB Video Class driver (1.1.1)
> [    2.576236] initcall uvc_init+0x0/0x1000 [uvcvideo] returned 0 after
> 6290 usecs
> ```
> 
> Tested-by: Paul Menzel <pmenzel+linux-media@molgen.mpg.de>
> 

Great to hear.  Laurent, when you submit this with Paul's tag would you
please consider to also CC @stable.
