Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB068C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 644FB2729B
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:45:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 644FB2729B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753791AbeF1Mp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 08:45:57 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:42228 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752056AbeF1Mpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 08:45:54 -0400
Received: by mail-vk0-f68.google.com with SMTP id s187-v6so3192844vke.9;
        Thu, 28 Jun 2018 05:45:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6MyuWicRcy+qwjOSy+0dEcBZbw03av5e98n1XfNcTiw=;
        b=W4m8Flo9uMtXGfvTmMn7bjiIwXFMXSbirVzMHwJKkNGryDQaDgmNGPQGoSHFAJGXI/
         +lXC/yFQIgt1xgZN5ms1u4s8ZrAOQc82QjwmoCMch9/DWP5Nb4COBc8ddKLnURwRQkOf
         SOKPeLzbvyq3XYCxWJe4Hd62gLk3ROcF7/IFKNSCLz4f3L64gUJ1osh8nUAZZAQPgyGN
         f174x4zS9i9WeVc3RY0BbHRDYQcbwr0QGsqSSd68iy+XPENOnLzgDmrm6sZd+sJcN72Y
         OLD+JRU/qiH3KRsuqENi3mr74h5U1FQwJahKbXpGDxldH4VIpB6+dR261ntakPdqKZnr
         U+/w==
X-Gm-Message-State: APt69E1mu3dsoWM8ie1eSoqnLFnllYE6ROWI5Y5ogHDfOL6SDlj2kF5k
        PWJ619Ch7IkTtw3T1hjFb5X6zi1+l30SQPrnipM=
X-Google-Smtp-Source: AAOMgpfldzECYdsOCIbFewzzLu+v1Y42SBJ6Sq1B7laOZESXXznDhuWx3HK4oiWB1G+3bJKykbvFAOkZRIz5vdLd/rY=
X-Received: by 2002:a1f:2c0d:: with SMTP id s13-v6mr5992236vks.106.1530189953211;
 Thu, 28 Jun 2018 05:45:53 -0700 (PDT)
MIME-Version: 1.0
References: <1528973829-25493-1-git-send-email-michel.pollet@bp.renesas.com>
 <1528973829-25493-4-git-send-email-michel.pollet@bp.renesas.com>
 <20180628120031.eq2yuysz4re2olwn@verge.net.au> <20180628121609.jf4dp4azeowte7pb@verge.net.au>
In-Reply-To: <20180628121609.jf4dp4azeowte7pb@verge.net.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 28 Jun 2018 14:45:41 +0200
Message-ID: <CAMuHMdWqowQjZ8Wsdj6ne-+UG8-OY_j6pi3R9JPP6L7ZgRhvBQ@mail.gmail.com>
Subject: Re: [PATCH v9 3/5] ARM: dts: Renesas R9A06G032 base device tree file
To:     Simon Horman <horms@verge.net.au>
Cc:     Michel Pollet <michel.pollet@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Michel Pollet <buserror+upstream@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon,

On Thu, Jun 28, 2018 at 2:16 PM Simon Horman <horms@verge.net.au> wrote:
> On Thu, Jun 28, 2018 at 02:00:32PM +0200, Simon Horman wrote:
> > On Thu, Jun 14, 2018 at 11:56:32AM +0100, Michel Pollet wrote:
> > > This adds the Renesas R9A06G032 bare bone support.
> > >
> > > This currently only handles the SYSCTRL block note,
> > > generic parts (gic, architected timer) and a UART.
> > >
> > > Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
> > > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
> >
> > Thanks, applied with the following appended:
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 9d5eeff51b5f..4c85ac04872d 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1969,6 +1969,7 @@ S:      Supported
> >  F:   arch/arm/boot/dts/emev2*
> >  F:   arch/arm/boot/dts/r7s*
> >  F:   arch/arm/boot/dts/r8a*
> > +F:   arch/arm/boot/dts/r9a*
> >  F:   arch/arm/boot/dts/sh*
> >  F:   arch/arm/configs/shmobile_defconfig
> >  F:   arch/arm/include/debug/renesas-scif.S
>
> One more update.
>
> dt-bindings/clock/r9a06g032-sysctrl.h is not present in v4.18-rc1,
> current base of the renesas tree and likely base for the rest of the v4.19
> development cycle.
>
> Accordingly I have removed the include of that header and replaced
> the use of symbols it defines with numeric constants. The result is below.

Oh right. Thanks!

> Please:
> 1) Check that this is correct and

Looks good to me, except for the bogus "fixes" and "SoB" below
(bad squash?)

> From: Michel Pollet <michel.pollet@bp.renesas.com>
> Subject: [PATCH] ARM: dts: Renesas R9A06G032 base device tree file
>
> This adds the Renesas R9A06G032 bare bone support.
>
> This currently only handles the SYSCTRL block note,
> generic parts (gic, architected timer) and a UART.
>
> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> [simon: updated MAINTAINERS file
> [simon: do not use r9a06g032-sysctrl.h as it is not in the renesas tree yet]
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>
> fixes
  ^^^^^
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
  ^^^^

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
