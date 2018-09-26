Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 345CBC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 10:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDB7C20843
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 10:36:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDB7C20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbeIZQsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 12:48:19 -0400
Received: from mail.bootlin.com ([62.4.15.54]:41489 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726593AbeIZQsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 12:48:19 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 10AEC20711; Wed, 26 Sep 2018 12:35:58 +0200 (CEST)
Received: from localhost (nat-240.udc.es [193.144.61.240])
        by mail.bootlin.com (Postfix) with ESMTPSA id 89CF02074F;
        Wed, 26 Sep 2018 12:35:47 +0200 (CEST)
From:   maxime.ripard@bootlin.com
Date:   Wed, 26 Sep 2018 12:35:47 +0200
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "\"David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jacob Chen <jacob-chen@iotwrt.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Thierry Reding <treding@nvidia.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Todor Tomov <todor.tomov@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v11 1/2] dt-bindings: media: Add Allwinner V3s Camera
 Sensor Interface (CSI)
Message-ID: <20180926103547.5ubb6xjkl7xngmfg@flea>
References: <1537951204-24672-1-git-send-email-yong.deng@magewell.com>
 <7197338.mhOH8fQaEM@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7197338.mhOH8fQaEM@avalon>
gFrom:  Maxime Ripard <maxime.ripard@bootlin.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 01:19:34PM +0300, Laurent Pinchart wrote:
> > +Endpoint node properties for CSI1
> > +---------------------------------
> 
> Should you list the CSI0 properties as well ? As the driver in patch 2/2 
> doesn't support the CSI-2 interface I assume you have left out CSI0 for now, 
> but it should still be listed in the bindings. I'm fine with fixing this as a 
> follow-up patch to avoid missing the v4.20 merge window, but if you end up 
> resubmitting the series, could you please address the problem ?

That driver is not available, and the documentation isn't either, so
there's no easy way to tell which properties are going to be needed
before doing the actual work of reverse engineering it and writing a
driver for it. Unfortunately...

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
