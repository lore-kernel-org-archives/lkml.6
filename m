Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D218C31680
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C93F720663
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:13:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfAURNZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 12:13:25 -0500
Received: from muru.com ([72.249.23.125]:34462 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbfAURNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 12:13:24 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id A89A5812F;
        Mon, 21 Jan 2019 17:13:30 +0000 (UTC)
Date:   Mon, 21 Jan 2019 09:13:20 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Felix Brack <fb@ltec.ch>
Cc:     linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        bcousson@baylibre.com, mpfj@newflow.co.uk, mark.rutland@arm.com,
        robh+dt@kernel.org, linux@armlinux.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH: linux-next] ARM: dts: am33xx: Remove unnecessary
 properties
Message-ID: <20190121171320.GE5544@atomide.com>
References: <20181218143931.4151-1-fb@ltec.ch>
 <31a68b35-8b78-8fee-3dd9-5beb3c386247@ltec.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31a68b35-8b78-8fee-3dd9-5beb3c386247@ltec.ch>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Felix Brack <fb@ltec.ch> [190119 17:38]:
> Hi Tony,
> On 18.12.18 15:39, Felix Brack wrote:
> > Remove the unnecessary properties #address-cells and #size-cells
> > of node pinmux as there are no child-nodes with property reg.
> > 
> > Signed-off-by: Felix Brack <fb@ltec.ch>
> > ---
> >   arch/arm/boot/dts/am33xx-l4.dtsi | 2 --
> >   1 file changed, 2 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/am33xx-l4.dtsi b/arch/arm/boot/dts/am33xx-l4.dtsi
> > index 7b818d9d2eab..e957370f8aec 100644
> > --- a/arch/arm/boot/dts/am33xx-l4.dtsi
> > +++ b/arch/arm/boot/dts/am33xx-l4.dtsi
> > @@ -288,8 +288,6 @@
> >   				am33xx_pinmux: pinmux@800 {
> >   					compatible = "pinctrl-single";
> >   					reg = <0x800 0x238>;
> > -					#address-cells = <1>;
> > -					#size-cells = <0>;
> >   					#pinctrl-cells = <1>;
> >   					pinctrl-single,register-width = <32>;
> >   					pinctrl-single,function-mask = <0x7f>;
> > 
> 
> Just a gentle ping. BTW: the patch applies not just to linux-next correctly
> but now also to linux.

Sorry I'm still struggling with pending regressions for
the -rc cycle.. I should get to applying patches for next
merge window this week though.

Regards,

Tony
