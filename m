Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D64C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3A4925CA5
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:05:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3A4925CA5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965293AbeGBLFh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 07:05:37 -0400
Received: from muru.com ([72.249.23.125]:49502 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964823AbeGBLFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 07:05:32 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 893F38047;
        Mon,  2 Jul 2018 11:08:27 +0000 (UTC)
Date:   Mon, 2 Jul 2018 04:05:29 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Roger Quadros <rogerq@ti.com>
Cc:     linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, "[4.16+]" <stable@vger.kernel.org>
Subject: Re: [PATCH 1/5] ARM: dts: dra7: Disable metastability workaround for
 USB2
Message-ID: <20180702110529.GR112168@atomide.com>
References: <1527584458-6257-1-git-send-email-rogerq@ti.com>
 <1527584458-6257-2-git-send-email-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527584458-6257-2-git-send-email-rogerq@ti.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [180529 02:03]:
> Disable the metastability workaround for USB2. The original
> patch disabled the workaround on the wrong USB port.
> 
> Fixes: b8c9c6fa2002 ("ARM: dts: dra7: Disable USB metastability workaround for USB2")
> Cc: <stable@vger.kernel.org>        [4.16+]
> Signed-off-by: Roger Quadros <rogerq@ti.com>


Sorry for the delay, applying this one into omap-for-v4.18/fixes.

Regards,

Tony

> ---
>  arch/arm/boot/dts/dra7.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> index f4ddd86..9cace9f 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -1582,7 +1582,6 @@
>  				dr_mode = "otg";
>  				snps,dis_u3_susphy_quirk;
>  				snps,dis_u2_susphy_quirk;
> -				snps,dis_metastability_quirk;
>  			};
>  		};
>  
> @@ -1610,6 +1609,7 @@
>  				dr_mode = "otg";
>  				snps,dis_u3_susphy_quirk;
>  				snps,dis_u2_susphy_quirk;
> +				snps,dis_metastability_quirk;
>  			};
>  		};
>  
> -- 
> cheers,
> -roger
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 
