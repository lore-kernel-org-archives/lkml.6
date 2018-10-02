Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C45C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 11:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 568D9204FD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 11:55:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 568D9204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbeJBSid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 14:38:33 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:15615 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbeJBSid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 14:38:33 -0400
X-IronPort-AV: E=Sophos;i="5.54,331,1534834800"; 
   d="scan'208";a="18811316"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 02 Oct 2018 04:55:38 -0700
Received: from localhost (10.10.76.4) by chn-sv-exch03.mchp-main.com
 (10.10.76.49) with Microsoft SMTP Server id 14.3.352.0; Tue, 2 Oct 2018
 04:55:36 -0700
Date:   Tue, 2 Oct 2018 13:55:35 +0200
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
CC:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] ARM: dts: at91: at91sam9x5cm: fix addressable nand
 flash size
Message-ID: <20181002115535.nxemqzfmkfdzbffp@M43218.corp.atmel.com>
Mail-Followup-To: Tudor Ambarus <tudor.ambarus@microchip.com>,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181002112949.22961-1-tudor.ambarus@microchip.com>
 <20181002112949.22961-2-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181002112949.22961-2-tudor.ambarus@microchip.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 02:29:49PM +0300, Tudor Ambarus wrote:
> at91sam9x5cm comes with a 2Gb NAND flash. Fix the rootfs size to
> match this limit.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>

Thanks
> ---
>  arch/arm/boot/dts/at91sam9x5cm.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/at91sam9x5cm.dtsi b/arch/arm/boot/dts/at91sam9x5cm.dtsi
> index 4908ee07e628..993eabe1cf7a 100644
> --- a/arch/arm/boot/dts/at91sam9x5cm.dtsi
> +++ b/arch/arm/boot/dts/at91sam9x5cm.dtsi
> @@ -100,7 +100,7 @@
>  
>  						rootfs@800000 {
>  							label = "rootfs";
> -							reg = <0x800000 0x1f800000>;
> +							reg = <0x800000 0x0f800000>;
>  						};
>  					};
>  				};
> -- 
> 2.9.4
> 
