Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE23C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 14:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3D8C208B6
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 14:40:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3D8C208B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbeH0S1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 14:27:44 -0400
Received: from mail.bootlin.com ([62.4.15.54]:44358 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726953AbeH0S1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 14:27:44 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 049E92079D; Mon, 27 Aug 2018 16:40:50 +0200 (CEST)
Received: from localhost (unknown [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id C9EED2072C;
        Mon, 27 Aug 2018 16:40:49 +0200 (CEST)
Date:   Mon, 27 Aug 2018 16:40:49 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc:     nicolas.ferre@microchip.com, Claudiu.Beznea@microchip.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Cristian.Birsan@microchip.com
Subject: Re: [PATCH v7 0/3] ARM: dts: at91: sama5d2: Add nodes for I2S
Message-ID: <20180827144049.GC23428@piout.net>
References: <20180806111948.4522-1-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180806111948.4522-1-codrin.ciubotariu@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08/2018 14:19:45+0300, Codrin Ciubotariu wrote:
> These are the remaining dts patches from the series:
> [PATCH v5 0/5] ASoC: add driver for Atmel I2S controller
> 
> v6 -> v7
>  - addressed some comments regarding pin conflicts;
> 
> v5 -> v6
>  - removed unnecessary phandles to audio PLL clock from the I2S nodes;
>  - using assigned clocks to set gclk as parent of i2smuxclk;
> 
> Codrin Ciubotariu (1):
>   ARM: dts: at91: sama5d2: add I2S clock muxing nodes
> 
> Cyrille Pitchen (2):
>   ARM: dts: at91: sama5d2: add nodes for I2S controllers
>   ARM: dts: at91: sama5d2 Xplained: add pin muxing for I2S
> 
>  arch/arm/boot/dts/at91-sama5d2_xplained.dts | 30 +++++++++++
>  arch/arm/boot/dts/sama5d2.dtsi              | 56 +++++++++++++++++++++
>  2 files changed, 86 insertions(+)
> 

All applied, thanks!

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
