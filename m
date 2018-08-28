Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A16C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 10:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0F1D20869
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 10:18:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0F1D20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbeH1OJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 10:09:53 -0400
Received: from mail.bootlin.com ([62.4.15.54]:39258 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726982AbeH1OJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 10:09:53 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 2ADAE20789; Tue, 28 Aug 2018 12:18:56 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id F1BE620719;
        Tue, 28 Aug 2018 12:18:55 +0200 (CEST)
Date:   Tue, 28 Aug 2018 12:18:55 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Peter Rosin <peda@axentia.se>
Cc:     linux-kernel@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/5] ARM: dts: at91: nattis: some cleanup
Message-ID: <20180828101855.GA16561@piout.net>
References: <20180828094844.10018-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828094844.10018-1-peda@axentia.se>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/08/2018 11:48:39+0200, Peter Rosin wrote:
> Hi!
> 
> Now that some other patches [1][2] have finally landed in -next, I
> feel that it is time for this cleanup series that I have been hoarding
> for a while waiting on those (weak) dependencies.
> 
> Cheers,
> Peter
> 
> [1] https://lkml.org/lkml/2018/8/24/187
> [2] https://lkml.org/lkml/2018/8/25/64
> 
> Peter Rosin (5):
>   ARM: dts: at91: nattis: set the PRLUD and HIPOW signals low
>   ARM: dts: at91: nattis: make the SD-card slot work
>   ARM: dts: at91: nattis: state the actual lvds-encoder chip
>   ARM: dts: at91: nattis: move pinctrls for the lvds chip to the lvds
>     node
>   ARM: dts: at91: nattis: describe the lvds panel
> 
>  arch/arm/boot/dts/at91-nattis-2-natte-2.dts | 43 ++++++++++++++++++++++-------
>  1 file changed, 33 insertions(+), 10 deletions(-)
> 

All applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
