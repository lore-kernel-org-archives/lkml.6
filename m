Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 219B3C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 09:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC34520837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 09:13:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC34520837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbeHaNT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 09:19:58 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34031 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727292AbeHaNT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 09:19:58 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 8D5FE207AD; Fri, 31 Aug 2018 11:13:25 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 62CD1203EC;
        Fri, 31 Aug 2018 11:13:25 +0200 (CEST)
Date:   Fri, 31 Aug 2018 11:13:23 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Nicolas Ferre <nicolas.ferre@microchip.com>
Cc:     miquel.raynal@bootlin.com,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Cristian Birsan <cristian.birsan@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Boris BREZILLON <boris.brezillon@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11] MAINTAINERS: update of of some Microchip entries
Message-ID: <20180831091323.GM16561@piout.net>
References: <cover.1535552609.git.nicolas.ferre@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1535552609.git.nicolas.ferre@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/2018 16:31:36+0200, Nicolas Ferre wrote:
> Hi,
> 
> This is an update of most of Microchip MAINTAINERS' entries. I took advantage
> of the addition of Ludovic as co-maintainer to go through some of the entries
> that were outdated.
> 
> There are moves of entries in the 3 last patches of this series. You can drop
> them if they introduce too much headaches while updating this MAINTAINERS
> file.
> 
> Series based on v4.19-rc1.
> 
> Nicolas Ferre (11):
>   MAINTAINERS: ARM: at91: add co-maintainer for ARM/Microchip
>   MAINTAINERS: update entry for Microchip NAND driver support
>   MAINTAINERS: media: change Microchip ISI, ISC maintainers
>   MAINTAINERS: ASoC: change maintainer for Microchip ALSA drivers
>   MAINTAINERS: USB: change maintainer for Microchip USBA gadget driver
>   MAINTAINERS: dmaengine: add files to Microchip dma entry
>   MAINTAINERS: pwm: add entry for Microchip pwm driver
>   MAINTAINERS: iio: add co-maintainer to SAMA5D2-compatible ADC driver
>   MAINTAINERS: remove the / ATMEL string from MICROCHIP entries
>   MAINTAINERS: move former ATMEL entries to proper MICROCHIP location
>   MAINTAINERS: sdhci: move the Microchip entry to proper location
> 
>  MAINTAINERS | 196 ++++++++++++++++++++++++++++------------------------
>  1 file changed, 105 insertions(+), 91 deletions(-)
> 

All applied now.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
