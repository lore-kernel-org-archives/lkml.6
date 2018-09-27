Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158E8C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 10:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A856D20833
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 10:13:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A856D20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbeI0QbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 12:31:23 -0400
Received: from gloria.sntech.de ([185.11.138.130]:45390 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726991AbeI0QbW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 12:31:22 -0400
Received: from ip5f5a866f.dynamic.kabel-deutschland.de ([95.90.134.111] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1g5TIq-0000C3-9E; Thu, 27 Sep 2018 12:13:48 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     "Marty E. Plummer" <hanetzer@startmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/rockchip: typo: selet->select
Date:   Thu, 27 Sep 2018 12:13:47 +0200
Message-ID: <7004894.1MZhX1FFyX@phil>
In-Reply-To: <20180923142005.23915-1-hanetzer@startmail.com>
References: <20180923142005.23915-1-hanetzer@startmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marty,

Am Sonntag, 23. September 2018, 16:20:05 CEST schrieb Marty E. Plummer:
> Signed-off-by: Marty E. Plummer <hanetzer@startmail.com>
> ---
>  drivers/gpu/drm/rockchip/Kconfig | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/Kconfig b/drivers/gpu/drm/rockchip/Kconfig
> index 0ccc76217ee4..7d1ccc9efc76 100644
> --- a/drivers/gpu/drm/rockchip/Kconfig
> +++ b/drivers/gpu/drm/rockchip/Kconfig
> @@ -23,7 +23,7 @@ config ROCKCHIP_ANALOGIX_DP
>  	help
>  	  This selects support for Rockchip SoC specific extensions
>  	  for the Analogix Core DP driver. If you want to enable DP
> -	  on RK3288 based SoC, you should selet this option.
> +	  on RK3288 based SoC, you should select this option.

The "selet" typos got fixed in another commit recently.
dc879f61c45d  ("drm/rockchip: fix coding style and incorrect description")
from Sandy on 2018-08-28.

It is sitting on drm-misc-next [0] waiting for the next merge-window.

Heiko

[0] https://cgit.freedesktop.org/drm/drm-misc/log/


