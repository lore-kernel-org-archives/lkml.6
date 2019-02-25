Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08A2C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 10:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C01552147C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 10:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbfBYKq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 05:46:27 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:52679 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfBYKq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 05:46:27 -0500
X-Originating-IP: 109.212.201.85
Received: from localhost (alyon-652-1-170-85.w109-212.abo.wanadoo.fr [109.212.201.85])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 7D8421C000D;
        Mon, 25 Feb 2019 10:46:23 +0000 (UTC)
Date:   Mon, 25 Feb 2019 11:46:22 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Claudiu.Beznea@microchip.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        Nicolas.Ferre@microchip.com, Ludovic.Desroches@microchip.com,
        linux@armlinux.org.uk, mturquette@baylibre.com, sboyd@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 0/8] add power management support for SAM9X60
Message-ID: <20190225104622.GA11983@piout.net>
References: <1550159642-26878-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550159642-26878-1-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2019 15:54:26+0000, Claudiu.Beznea@microchip.com wrote:
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
> 
> Hi,
> 
> This series add power management support for SAM9X60. The following
> platform specific power management modes were enabled for it:
> Idle, ULP0 and ULP1.
> 
> Thank you,
> Claudiu Beznea
> 
> Claudiu Beznea (8):
>   ARM: at91: pm: introduce at91_soc_pm structure
>   dt-bindings: arm: atmel: add binding for SAM9X60 SoC
>   ARM: at91: pm: initial PM support for SAM9X60
>   ARM: at91: pm: keep at91_pm_backup_init() only for SAMA5D2 SoCs
>   ARM: at91: pm: add support for per SoC wakeup source configuration
>   ARM: at91: pm: add ULP1 support for SAM9X60
>   ARM: at91: pm: disable RC oscillator in ULP0
>   ARM: at91: pm: do not disable/enable PLLA for ULP modes
> 

All applied.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
