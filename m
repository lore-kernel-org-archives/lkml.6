Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EAB1C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 213B9204FD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:36:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 213B9204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbeJBTTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 15:19:36 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34962 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727555AbeJBTTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 15:19:35 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 125E8207F0; Tue,  2 Oct 2018 14:36:26 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id DCB07207A3;
        Tue,  2 Oct 2018 14:36:25 +0200 (CEST)
Date:   Tue, 2 Oct 2018 14:36:26 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     nicolas.ferre@microchip.com, ludovic.desroches@microchip.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ARM: dts: at91: sama5d4_xplained: fix addresable
 nand flash size
Message-ID: <20181002123626.GC4088@piout.net>
References: <20181002112949.22961-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002112949.22961-1-tudor.ambarus@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tudor,

There is a typo is your subject line.I don't have any other comment ;)

On 02/10/2018 14:29:48+0300, Tudor Ambarus wrote:
> sama5d4_xplained comes with a 4Gb NAND flash. Increase the rootfs
> size to match this limit.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  arch/arm/boot/dts/at91-sama5d4_xplained.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/at91-sama5d4_xplained.dts b/arch/arm/boot/dts/at91-sama5d4_xplained.dts
> index 4b7c762d5f22..7d554b9ab27f 100644
> --- a/arch/arm/boot/dts/at91-sama5d4_xplained.dts
> +++ b/arch/arm/boot/dts/at91-sama5d4_xplained.dts
> @@ -252,7 +252,7 @@
>  
>  						rootfs@800000 {
>  							label = "rootfs";
> -							reg = <0x800000 0x0f800000>;
> +							reg = <0x800000 0x1f800000>;
>  						};
>  					};
>  				};
> -- 
> 2.9.4
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
