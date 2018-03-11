Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932247AbeCKODS (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 10:03:18 -0400
Received: from esa7.dell-outbound.iphmx.com ([68.232.153.96]:57025 "EHLO
        esa7.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932136AbeCKODP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 10:03:15 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2GRAQABNqVah8mZ6ERdGQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQcBAQEBAYMjgQN/KAqDRpgOggSBFpQyghUKhSUCGoJ3ITUXAQIBAQEBAQE?=
 =?us-ascii?q?CAQIQAQEBCgsJCCgugjgigkoBAQEDASMRRQwEAgEIEQQBAQECAh8EAwICAkQBC?=
 =?us-ascii?q?AgCBA4FCBOEdQipW4ImiFmCGoENhCiCLoM8gy6FBQYdEAYbAoJOgmIEiBGSRQm?=
 =?us-ascii?q?QWY5rkUiBLB8BgglwgxKCMhAMFm0BCWx3AYpQgRgBAQE?=
X-IPAS-Result: =?us-ascii?q?A2GRAQABNqVah8mZ6ERdGQEBAQEBAQEBAQEBAQcBAQEBAYM?=
 =?us-ascii?q?jgQN/KAqDRpgOggSBFpQyghUKhSUCGoJ3ITUXAQIBAQEBAQECAQIQAQEBCgsJC?=
 =?us-ascii?q?CgugjgigkoBAQEDASMRRQwEAgEIEQQBAQECAh8EAwICAkQBCAgCBA4FCBOEdQi?=
 =?us-ascii?q?pW4ImiFmCGoENhCiCLoM8gy6FBQYdEAYbAoJOgmIEiBGSRQmQWY5rkUiBLB8Bg?=
 =?us-ascii?q?glwgxKCMhAMFm0BCWx3AYpQgRgBAQE?=
From: <Mario.Limonciello@dell.com>
X-LoopCount0: from 10.166.132.152
X-IronPort-AV: E=Sophos;i="5.47,455,1515477600";
   d="scan'208";a="148502568"
X-DLP: DLP_GlobalPCIDSS
To: <pali.rohar@gmail.com>
CC: <kai.heng.feng@canonical.com>, <mjg59@srcf.ucam.org>,
        <dvhart@infradead.org>, <andy@infradead.org>, <tiwai@suse.com>,
        <platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alsa-devel@alsa-project.org>
Subject: RE: [PATCH v2 3/3] ALSA: hda: Disabled unused audio controller for
 Dell platforms with Switchable Graphics
Thread-Topic: [PATCH v2 3/3] ALSA: hda: Disabled unused audio controller for
 Dell platforms with Switchable Graphics
Thread-Index: AQHTtr1XC+3UjKIddE2I55hGuXPKiaPIAceAgAAHyYD//5ufkIAAaMcA//+dHPCAAgPLgIABZOtw
Date: Sun, 11 Mar 2018 14:03:13 +0000
Message-ID: <ea9ab148c4bb45b9ae7369020300b74b@ausx13mpc124.AMER.DELL.COM>
References: <20180308091023.9061-1-kai.heng.feng@canonical.com>
 <20180308091023.9061-3-kai.heng.feng@canonical.com>
 <20180309090223.xb55ltac4pfesdrh@pali>
 <723DA929-C9FA-4F69-8D3A-03D8A75D09A6@canonical.com>
 <014795f5a3014cd3bf55de26f76a5af8@ausx13mpc124.AMER.DELL.COM>
 <20180309094600.m24d3zbzdsmls7aw@pali>
 <09eadabb264f401a88b427744505adf8@ausx13mpc124.AMER.DELL.COM>
 <20180310103809.5nnwoulua2u64rku@pali>
In-Reply-To: <20180310103809.5nnwoulua2u64rku@pali>
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
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2BE3Oik031485

> -----Original Message-----
> From: platform-driver-x86-owner@vger.kernel.org [mailto:platform-driver-x86-
> owner@vger.kernel.org] On Behalf Of Pali Rohár
> Sent: Saturday, March 10, 2018 6:38 PM
> To: Limonciello, Mario <Mario_Limonciello@Dell.com>
> Cc: kai.heng.feng@canonical.com; mjg59@srcf.ucam.org; dvhart@infradead.org;
> andy@infradead.org; tiwai@suse.com; platform-driver-x86@vger.kernel.org; linux-
> kernel@vger.kernel.org; alsa-devel@alsa-project.org
> Subject: Re: [PATCH v2 3/3] ALSA: hda: Disabled unused audio controller for Dell
> platforms with Switchable Graphics
> 
> On Friday 09 March 2018 09:59:39 Mario.Limonciello@dell.com wrote:
> > > > Pali is your concern that this code for matching vendor/subsystem is running
> > > > on non-Dell too?  The only other recommendation I think that can be to restrict
> > > > to matching Dell OEM strings in SMBIOS table, but I don't think that's any better
> > > > than the matching for VID/SSVID.
> > >
> > > My concern is about adding a new machine specific code into generic
> > > driver, which check is done just by PCI vendor and subvendor.
> > >
> > > In future there can be new models or other PCI devices which matches
> > > above condition even they would not have any switchable graphics, nor
> > > they would manufactured by Dell.
> >
> > Uh Dell subsystem ID means it's Dell no?
> 
> What would prevent you to take PCI device marked with Dell ID and put it
> into non-Dell computer? I do not believe that Dell PCI devices are
> configured to work only in Dell branded devices and refuse to power up
> in others.

I think the missing aspect is that this is only used in AIO and laptop form
factors where the discrete graphics is in a non-removable form factor.

Running with your hypothetical though, what would happen is if it's
on a non-Dell machine the PCI check would pass and then the code
would not be executed by dell-laptop (since dell-smbios didn't load).

If it was on a Dell machine it would load but the BIOS would return
either Switchable graphics turned off, or invalid token.

Even though these aren't real for switchable graphics on Dell I don't
see a problem with either of these situations if it ever came up.
 
> 
> If there is Dell ID then it just means that PCI device itself is Dell's.
> And not that machine in which that device is plugged is also Dell.
> 
> > > Also I can imagine that in future (or maybe already now?) it is possible
> > > to find PCI device which pass above checks and connect this PCI device
> > > into desktop /server / any non-laptop device.
> > >
> > > If this switchable graphics solution is specific to dell laptops, then
> > > rather checking for PCI vendor/subvevendor main check, there should be
> > > main check via DMI strings.
> >
> > Right now this is affected to both AIO desktop and laptops.
> >
> > IIRC you won't end up with switchable graphics in traditional desktop that you
> > can remove PCI card.  If this code was run on a traditional desktop with a
> > AMD PCI card that BIOS query result should be invalid token (which will infer
> > switchable off to this routine).
> >
> > >
> > > Hardware is changing relatively quickly and there is absolutely no
> > > guarantee that e.g. NVIDIA would not start providing audio controller in
> > > similar like AMD and it would be put in those Dell machines.
> >
> > Kai Heng can explain exactly why NVIDIA isn't affected.
> > This is probably good information to include in the commit message too.
> 
> Yes, extending commit message is a good idea.
> 
> But here I'm talking about future, NVIDIA cards could be in future.
> 
> I still think that whitelisting devices based on vendor ID by some
> measurements at one time is a bad idea. It is fragile which can stop
> working in the future.

Compiling a whitelist is a wasted effort because it will have to change
Every year for every new platform that has AMD switchable graphics.

This heuristic that is selected covers switchable graphics back for the
past generations that Canonical has tested and fixed, not just this
current one.

If that situation you refer to happens, it will be on new hardware that's
not yet enabled by the Linux kernel.  We can cross that bridge when we
come to it with either a newly proposed heuristic or some adjustments
for whitelist/blacklist.
