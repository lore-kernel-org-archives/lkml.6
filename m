Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD439C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3C9F2086C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730565AbfBAPtE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 10:49:04 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:51933 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727356AbfBAPtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 10:49:03 -0500
X-Originating-IP: 90.88.147.226
Received: from localhost (aaubervilliers-681-1-27-226.w90-88.abo.wanadoo.fr [90.88.147.226])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 2B9C52000E;
        Fri,  1 Feb 2019 15:48:58 +0000 (UTC)
Date:   Fri, 1 Feb 2019 16:48:58 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v7 00/23] drm/sun4i: Allwinner A64 MIPI-DSI support
Message-ID: <20190201154858.z6xqdaxccxya2wqr@flea>
References: <20190201154232.10505-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190201154232.10505-1-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 09:12:09PM +0530, Jagan Teki wrote:
> Here is next version changes for Allwinner A64 MIPI-DSI support
> 
> This series grouped the changes like previous version[1] with different
> sets to support three different panels types that can fit into the DSI
> controller.
> 
> set:1, for 4-lane, burst mode support
> - patch 0001: 0009, DSI controller changes that support burst mode.
> 
> set:2, for A64 DSI support
> - patch 0010: tcon dclk divider computation based on A64 BSP. 
> - patch 0011: 0017, Allwinner A64 DSI controller changes.
> 
> set:3, enable 4-lane burst mode panel:
> - patch 0018: Overlay patch that enable Feiyang FY07024DI26A30-D
>   burst mode panel on Pine64-LTS
> 
> set:4, enable 4-lane video mode panel:
> - patch 0019: msg type MIPI_DSI_GENERIC_SHORT_WRITE_2_PARAM support
> - patch 0020: Overlay patch that enable Bananapi S070WV20-CT16 ICN6211 
>   panel on Bananapi M64
> 
> set:5, enable 2-lane video mode panel:
> - patch 0021, 0022: DSI hfp and hbp timings fixes
> - patch 0023: Enable Techstar TS8550B panel on Amarula A64-Relic

You do realise that pushing through a series while the previous
version's discussion hasn't settled yet will not get you anywhere,
right?

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
