Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF54C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 18:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 189A3217F9
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 18:31:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbeL2Sb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 13:31:56 -0500
Received: from mout.gmx.net ([212.227.15.18]:49971 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726739AbeL2Sbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 13:31:55 -0500
Received: from corona.crabdance.com ([173.228.106.209]) by mail.gmx.com
 (mrgmx001 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0MC4R6-1gUTgf2nMO-008uZH; Sat, 29 Dec 2018 19:31:22 +0100
Received: by corona.crabdance.com (Postfix, from userid 1001)
        id EA5A26E85603; Sat, 29 Dec 2018 10:30:35 -0800 (PST)
From:   schaecsn <schaecsn@gmx.net>
To:     robh@kernel.org
CC:     mark.rutland@arm.com, joel@jms.id.au, andrew@aj.id.au,
        bp@alien8.de, mchehab@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-edac@vger.kernel.org,
        sschaeck@cisco.com
In-reply-to: <20181227220906.GA14320@bogus> (message from Rob Herring on Thu,
        27 Dec 2018 16:09:06 -0600)
Subject: Re: [PATCH 2/2] dt-bindings: edac: Aspeed AST2500
Reply-to: schaecsn@gmx.net
References: <1545026517-64069-1-git-send-email-schaecsn@gmx.net>
 <1545026517-64069-3-git-send-email-schaecsn@gmx.net> <20181227220906.GA14320@bogus>
Message-Id: <20181229183035.EA5A26E85603@corona.crabdance.com>
Date:   Sat, 29 Dec 2018 10:30:35 -0800 (PST)
X-Provags-ID: V03:K1:ZKj9KbCPurYlw/7WwnxbWusNZO5ZiEVJq1Soo2WXNMWBoRH3DMI
 ooy2DXAs2ahONv2XfDZg8m7qzDJnl1GGFUYFuVUPjSX3MAQSiMrgi+MOoURMp28LATVSZGu
 hAeKq8ALdXB4r586GZBVxQgoOVm8dMe3UeKZrWpJCQavtojfXQuqM6rvYL3VJJ0et9AxSKZ
 g8qFVALwsTP7DLO+jGg+g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HextMtTVsM0=:54Wusnx8KVkHQpSsJ8Q3zr
 VmGoCcE98/y4Gwm231BS5iU7lj5MiIEA/+vpIuBL5YbhkL5ilvLsn9AHSq+HxTo72m81TPHBO
 iO9Kg77ip6jUZfcralWhO9KBaAyM14oeuK+5Pr/ODulaGgzeQbnD/xck6cU/I3XHDZw//Zfal
 MWhlusGc+yMXx/ReS9PRvTQFrMIEfiafHnaCK01KJ1OuOxDdt14Kmigi8R0A/V04SDvCKuFNG
 99Hz5sJ4KLjoR5XUdnhAKDKB+v2sD4TwKnJLDMIKcgPANr6G+FEpMgHXaE1E7JW4yA6PbqGyW
 fV5G7cyiRpZGGCRAiJ9RDOreJ4EV065s4neF5JqlOhBCoikcUdYsX3vKccpsUH8mrR0s+GNhd
 DlTl4sfh+XLrRU71LaFjQps5ztCwXYKi5O7HFWREn2GQRou21E5EwdMM3FAtMtC/ALlER/49w
 LJrpazFvTp8F9IJF8Os7nZGZbN9pgFHwXlnUaFo556/7pRS7iOwpjS67jWWFsInysJxAmOkZu
 Gkh4uNkgNFi77z1aOEdBX7OFkfI0piLqcSypVXZWLsWieXRbwc1taf4D9QsrjPUpZl3SbYciv
 SgN1HXnMXAfXYxHp+cquBCNRWLpU42HNBM4ynG+d2QYRdmZBOGKPx60lVrglhu8KLnVplxJOK
 11krnXz4fBeY1x6F6QUI/ge9Y0P6+1law8PK7iekKENqUo5Nm9PcRuBhD0YW9Uj+2IHhJNUqL
 n7bomBj3Rv2g8pvMpzFYWGM9GEYm5x1YMzmzoREzJss6rRizh0w0ytisadWj4sgkqADuEG54r
 I2FhRiCYcT7nmlo1OOWtRlzToc8BTuebRS22B0LvPYUseUU7RvJhkQmODOGl2uhp+p7owd72E
 iGbYzKdgaWItICQgni2T1xjKZ85fUruWSkV48qcJI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rob,

> From: Rob Herring <robh@kernel.org>
> 
> On Sun, Dec 16, 2018 at 10:01:57PM -0800, Stefan Schaeckeler wrote:
> > From: Stefan M Schaeckeler <sschaeck@cisco.com>
> > 
> > Add support for the Aspeed AST2500 SoC EDAC driver.
> > 
> > Signed-off-by: Stefan M Schaeckeler <sschaeck@cisco.com>
> > ---
> >  .../bindings/edac/aspeed-sdram-edac.txt       | 34 +++++++++++++++++++
> >  1 file changed, 34 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt b/Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt
> > new file mode 100644
> > index 000000000000..57ba852883c7
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt
> > @@ -0,0 +1,34 @@
> > +Aspeed AST2500 SoC EDAC device driver
> 
> Bindings are for h/w, not drivers

Changed "device driver" to "node".

I will also change the commit message to perhaps "Add support for EDAC on the
Aspeed AST2500 SoC."


> > +The Aspeed AST2500 SoC supports DDR3 and DDR4 memory with and without ECC (error
> > +correction check).
> > +
> > +The memory controller supports SECDED (single bit error correction, double bit
> > +error detection) and single bit error auto scrubbing by reserving 8 bits for
> > +every 64 bit word (effectively reducing available memory to 8/9).
> > +
> > +First, ECC must be configured in u-boot. Then, this driver will expose error
> > +counters via the edac kernel framework.
> 
> Please reword this to not be u-boot or kernel specific.

The previous paragraph is now: Note, the bootloader must configure ECC mode in
the memory controller.

 
> Maybe this node is enabled in the bootloader or the OS can just read the 
> registers to see if ECC is enabled. The latter is more future proof if 
> you need to access the DDR ctrl registers for other reasons.

The driver's probe function has a sanity check. It consults the memory
controller for enabled ECC mode:
 
        /* bail out if ECC mode is not configured */
        regmap_read(aspeed_edac_regmap, ASPEED_MCR_CONF, &reg04);
        if (!(reg04 & ASPEED_MCR_CONF_ECC)) {
                dev_err(&pdev->dev, "ECC mode is not configured in u-boot\n");
                return -EPERM;
        }


> > +A note on memory organization in ECC mode: every 512 bytes are followed by 64
> > +bytes of ECC codes. 
> 
> That sounds strange. Normally, the memory would be 72-bits wide to hold 
> the ECC byte for each 64-bit chunk. It would be inefficient to access 
> the ECC byte in a discontiguous location.

When a word is loaded from memory, the corresponding ECC word needs to be
loaded as well (both words can and will be cached). Performance relies on
temporal and spatial locality. That can fire back, of course.


> In any case, none of this is really important for the binding.

I will move above and below paragraph into Kconfig.


> > The address remapping is done in hardware and is fully
> > +transparent to firmware and software. Because of this, ECC mode must be
> > +configured in u-boot as part of the memory initialization as one can not switch
> > +from one mode to another when executing in memory.
> > +
> > +
> > +
> > +Required properties:
> > +- compatible: should be "aspeed,ast2500-sdram-edac"
> > +- reg:        sdram controller register set should be <0x1e6e0000 0x174>
> > +- interrupts: should be AVIC interrupt #0
> > +
> > +
> > +Example:
> > +
> > +	edac: sdram@1e6e0000 {
> > +		compatible = "aspeed,ast2500-sdram-edac";
> > +		reg = <0x1e6e0000 0x174>;
> > +		interrupts = <0>;
> > +		status = "okay";
> 
> Don't show status in examples.

Removed.

> 
> > +	};
> > -- 
> > 2.19.1


To wrap it up, for the next patchset, I will generate a diff for below text

- - - snip - - -
Aspeed AST2500 SoC EDAC node

The Aspeed AST2500 SoC supports DDR3 and DDR4 memory with and without ECC (error
correction check).

The memory controller supports SECDED (single bit error correction, double bit
error detection) and single bit error auto scrubbing by reserving 8 bits for
every 64 bit word (effectively reducing available memory to 8/9).

Note, the bootloader must configure ECC mode in the memory controller.


Required properties:
- compatible: should be "aspeed,ast2500-sdram-edac"
- reg:        sdram controller register set should be <0x1e6e0000 0x174>
- interrupts: should be AVIC interrupt #0


Example:

        edac: sdram@1e6e0000 {
                compatible = "aspeed,ast2500-sdram-edac";
                reg = <0x1e6e0000 0x174>;
                interrupts = <0>;
        };
- - - snip - - -

 Stefan

