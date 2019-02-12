Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01774C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 23:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C34B2222BB
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 23:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731605AbfBLXVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 18:21:35 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:59707 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729552AbfBLXVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 18:21:34 -0500
X-Originating-IP: 86.202.231.219
Received: from localhost (lfbn-lyo-1-149-219.w86-202.abo.wanadoo.fr [86.202.231.219])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id D4B7860003;
        Tue, 12 Feb 2019 23:21:32 +0000 (UTC)
Date:   Wed, 13 Feb 2019 00:21:32 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Marek Vasut <marex@denx.de>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: rv3028: new driver
Message-ID: <20190212232132.GG10129@piout.net>
References: <20190130150014.29853-1-alexandre.belloni@bootlin.com>
 <a40fd8e7-bf76-5a1f-3015-b15b72ac78ee@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a40fd8e7-bf76-5a1f-3015-b15b72ac78ee@denx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/01/2019 17:13:27+0100, Marek Vasut wrote:
> On 1/30/19 4:00 PM, Alexandre Belloni wrote:
> > Add a driver for the MicroCrystal RV-3028.
> 
> Some additional information in the commit message won't hurt.
> 
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > ---
> >  Documentation/devicetree/bindings/rtc/rtc.txt |   1 +
> >  drivers/rtc/Kconfig                           |   9 +
> >  drivers/rtc/Makefile                          |   1 +
> >  drivers/rtc/rtc-rv3028.c                      | 732 ++++++++++++++++++
> >  4 files changed, 743 insertions(+)
> >  create mode 100644 drivers/rtc/rtc-rv3028.c
> > 
> > diff --git a/Documentation/devicetree/bindings/rtc/rtc.txt b/Documentation/devicetree/bindings/rtc/rtc.txt
> > index d86e2850fe1c..3e6a215e7304 100644
> > --- a/Documentation/devicetree/bindings/rtc/rtc.txt
> > +++ b/Documentation/devicetree/bindings/rtc/rtc.txt
> > @@ -52,6 +52,7 @@ emmicro,em3027		EM Microelectronic EM3027 Real-time Clock
> >  isil,isl1208		Intersil ISL1208 Low Power RTC with Battery Backed SRAM
> >  isil,isl1218		Intersil ISL1218 Low Power RTC with Battery Backed SRAM
> >  isil,isl12022		Intersil ISL12022 Real-time Clock
> > +microcrystal,rv3028	Real Time Clock Module with I2C-Bus
> 
> Shouldn't this be a separate patch ?
> 

Not really as this doesn't introduce any new binding and simply
documents a compatible string. Rob is loaded enough to not review that
kind of changes.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
