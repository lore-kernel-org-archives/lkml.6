Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751724AbeECKBo convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 06:01:44 -0400
Received: from mail3.emtrion.de ([80.150.99.69]:44321 "EHLO mail3.emtrion.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750930AbeECKBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 06:01:40 -0400
From: =?iso-8859-1?Q?T=FCrk=2C_Jan?= <Jan.Tuerk@emtrion.de>
To: "'Shawn Guo'" <shawnguo@kernel.org>
CC: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Russell King <linux@armlinux.org.uk>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        LinuxArmKernelMailingListe <linux-arm-kernel@lists.infradead.org>
Date: Thu, 3 May 2018 12:01:38 +0200
Subject: AW: [PATCH v4 0/7] Add basic support for emtrion emCON-MX6 modules
Thread-Topic: [PATCH v4 0/7] Add basic support for emtrion emCON-MX6 modules
Thread-Index: AdPemYNSwfxogcJlRSmoh178twH+mgELASNw
Message-ID: <95F51F4B902CAC40AF459205F6322F01B83109E5C4@BMK019S01.emtrion.local>
References: <20180420125108.14197-1-jan.tuerk@emtrion.com>
 <20180427132445.3458-1-jan.tuerk@emtrion.com> <20180428023445.GA3693@dragon>
In-Reply-To: <20180428023445.GA3693@dragon>
Accept-Language: de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: de-DE
x-tm-as-product-ver: SMEX-11.0.0.4283-8.100.1062-23820.006
x-tm-as-result: No--22.037800-8.000000-31
x-tm-as-matchedid: 701625-704425-700685-139010-853813-703523-705386-710556-8
        61686-701182-700648-850298-704421-701762-700075-110462-704410-705441-188198
        -701236-702311-106230-708060-701005-703176-707410-702143-705167-704156-7088
        55-701604-702898-148004-148133-20043-42000-42003
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Ursprüngliche Nachricht-----
> Von: Shawn Guo [mailto:shawnguo@kernel.org]
> Gesendet: Samstag, 28. April 2018 04:35
> An: Türk, Jan
> Cc: Rob Herring; Mark Rutland; Thierry Reding; David Airlie; Sascha Hauer;
> Pengutronix Kernel Team; Fabio Estevam; Russell King;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; dri-
> devel@lists.freedesktop.org; LinuxArmKernelMailingListe
> Betreff: Re: [PATCH v4 0/7] Add basic support for emtrion emCON-MX6
> modules
> 
> On Fri, Apr 27, 2018 at 03:24:35PM +0200, jan.tuerk@emtrion.com wrote:
> > From: Jan Tuerk <jan.tuerk@emtrion.com>
> >
> > Changes for v4:
> >   - re-arrange the Patch-series to match the DT-submitting-patches
> >   - Additional patch for the Documentation of the new DT-bindings
> >
> > [PATCH v4 1/7] dt-bindings: display: Document the EDT et* displays in one
> file.
> >   - no change (re-arranged 3/6 => 1/7)
> >
> > [PATCH v4 2/7] drm/panel: Add support for the EDT ETM0700G0BDH6
> >   - no change (re-arranged 1/6 => 2/7)
> >
> > [PATCH v4 3/7] drm/panel: Add support for the EDT ETM0700G0EDH6
> >   - no change (re-arranged 2/6 => 3/7)
> 
> Please split the series into two, DRM driver (above) and platform part
> (below), to avoid posting one part over and over again with zero changes,
> but only because the other part needs update.
> 
> Shawn
Ok I'll split them. 
> 
> >
> > [PATCH v4 4/7] ARM: dts: imx: Add an cpu0 label for imx6dl devices.
> >   - no change
> >
> > [PATCH v4 5/7] dt-bindings: arm: Document emtrion emCON-MX6 bindings
> >   - separate patch for the emtrion emCON-MX6 DT-bindings
> >
> > [PATCH v4 6/7] ARM: dts: Add support for emtrion emCON-MX6 series
> >   - alphabetically sort the DT
> >   - moved duplicated Avari baseboard code into separate file.
> >
> > [PATCH v4 7/7] ARM: imx_v6_v7_defconfig: Enable DA0963 PMIC support.
> >   - unchaged
