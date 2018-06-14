Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id CA68FC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87EE9208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:24:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87EE9208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754973AbeFNLY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 07:24:29 -0400
Received: from mail.bootlin.com ([62.4.15.54]:47284 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754857AbeFNLY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 07:24:28 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 8C4ED2073D; Thu, 14 Jun 2018 13:24:26 +0200 (CEST)
Received: from localhost (unknown [37.170.129.148])
        by mail.bootlin.com (Postfix) with ESMTPSA id 4DED320376;
        Thu, 14 Jun 2018 13:24:16 +0200 (CEST)
Date:   Thu, 14 Jun 2018 13:24:16 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Ben Whitten <ben.whitten@gmail.com>
Cc:     devicetree@vger.kernel.org,
        Ben Whitten <ben.whitten@lairdtech.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/4] arm: dts: add support for Laird WB45N cpu module and
 DVK
Message-ID: <20180614112416.GY10521@piout.net>
References: <1528966340-23216-1-git-send-email-ben.whitten@lairdtech.com>
 <20180614090733.GV10521@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180614090733.GV10521@piout.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/06/2018 11:07:33+0200, Alexandre Belloni wrote:
> Hi,
> 
> On 14/06/2018 09:51:54+0100, Ben Whitten wrote:
> 
> This need a proper commit message. Maybe you can also add a link to the
> technical brief for the platform?
> 
> > Signed-off-by: Ben Whitten <ben.whitten@lairdtech.com>
> > ---
> >  arch/arm/boot/dts/Makefile        |   3 +-
> >  arch/arm/boot/dts/at91-wb45n.dts  |  66 +++++++++++++++
> >  arch/arm/boot/dts/at91-wb45n.dtsi | 169 ++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 237 insertions(+), 1 deletion(-)
> >  create mode 100644 arch/arm/boot/dts/at91-wb45n.dts
> >  create mode 100644 arch/arm/boot/dts/at91-wb45n.dtsi
> > 
> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > index 7e24249..1ee94ee 100644
> > --- a/arch/arm/boot/dts/Makefile
> > +++ b/arch/arm/boot/dts/Makefile
> > @@ -42,7 +42,8 @@ dtb-$(CONFIG_SOC_AT91SAM9) += \
> >  	at91sam9g25ek.dtb \
> >  	at91sam9g35ek.dtb \
> >  	at91sam9x25ek.dtb \
> > -	at91sam9x35ek.dtb
> > +	at91sam9x35ek.dtb \
> > +	at91-wb45n.dtb
> 
> The proper name for the file is <soc>-board.dtb so this should be
> at91sam9g25-wb45n.dtb.
> 

Nicolas tells me that the name was right, please disregard my comment
(also on the other patches).

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
