Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0340C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 04:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9491326C91
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 04:52:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9491326C91
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933054AbeF1Eww convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 00:52:52 -0400
Received: from mailoutvs54.siol.net ([185.57.226.245]:41171 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932131AbeF1Ewu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 00:52:50 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id 4D4A4520917;
        Thu, 28 Jun 2018 06:52:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id whKUOCw6PFiS; Thu, 28 Jun 2018 06:52:47 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id 8F336520986;
        Thu, 28 Jun 2018 06:52:47 +0200 (CEST)
Received: from jernej-laptop.localnet (unknown [194.152.15.144])
        (Authenticated sender: 031275009)
        by mail.siol.net (Zimbra) with ESMTPA id 9B709520917;
        Thu, 28 Jun 2018 06:52:46 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [PATCH v3 15/24] dt-bindings: display: sun4i-drm: Add description of A64 HDMI PHY
Date:   Thu, 28 Jun 2018 06:51:22 +0200
Message-ID: <1669385.k4L9lni8DF@jernej-laptop>
In-Reply-To: <CAGb2v66ytOrjMOK067URknens34jvYxJ1XoYmGMi4Ji0LYt9sQ@mail.gmail.com>
References: <20180625120304.7543-1-jernej.skrabec@siol.net> <20180625120304.7543-16-jernej.skrabec@siol.net> <CAGb2v66ytOrjMOK067URknens34jvYxJ1XoYmGMi4Ji0LYt9sQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne četrtek, 28. junij 2018 ob 04:19:55 CEST je Chen-Yu Tsai napisal(a):
> On Mon, Jun 25, 2018 at 8:02 PM, Jernej Skrabec <jernej.skrabec@siol.net> 
wrote:
> > A64 HDMI PHY is similar to H3 HDMI PHY except it has two possible PLL
> > clock parents. It is compatible to other HDMI PHYs, like that found in
> > R40.
> > 
> > Acked-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > ---
> > 
> >  Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> > b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt index
> > 84fe38dbb900..dc83f21ef188 100644
> > --- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> > +++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> > @@ -101,6 +101,7 @@ DWC HDMI PHY
> > 
> >  Required properties:
> >    - compatible: value must be one of:
> > +    * allwinner,sun50i-a64-hdmi-phy
> > 
> >      * allwinner,sun8i-a83t-hdmi-phy
> >      * allwinner,sun8i-h3-hdmi-phy
> 
> Nit: the list is sorted by family first, then SoC name, so it should
> be the last on the list.

I went alphabetically, since "5" is before "8"...

Best regards,
Jernej

> 
> Otherwise,
> 
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> 
> >    - reg: base address and size of memory-mapped region
> > 
> > @@ -111,8 +112,9 @@ Required properties:
> >    - resets: phandle to the reset controller driving the PHY
> >    - reset-names: must be "phy"
> > 
> > -H3 HDMI PHY requires additional clock:
> > 
> > +H3 and A64 HDMI PHY require additional clocks:
> >    - pll-0: parent of phy clock
> > 
> > +  - pll-1: second possible phy clock parent (A64 only)
> > 
> >  TV Encoder
> >  ----------
> > 
> > --
> > 2.18.0




