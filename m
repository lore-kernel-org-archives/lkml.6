Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B603C10F0B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 07:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39ADC2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 07:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pmeerw.net header.i=@pmeerw.net header.b="dbT3jUCE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfBZHWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 02:22:04 -0500
Received: from ns.pmeerw.net ([84.19.176.117]:42840 "EHLO ns.pmeerw.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbfBZHWE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 02:22:04 -0500
Received: by ns.pmeerw.net (Postfix, from userid 1000)
        id 70E00E03A6; Tue, 26 Feb 2019 08:22:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pmeerw.net; s=mail;
        t=1551165722; bh=UvSQdG1BgU+nfAkFDJfhBws6uIyd9bO8eERDo6twXCg=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=dbT3jUCEL5mP5kvc5HuIYv321Z23UV1rzIQXBvxRwKrULstDtR4LhlxgOcOMGEnrB
         oAADa4Fkn4kcu2TujuSaZbP6If2XABYOU0U4kWiVqhuqpMmpS23rj6ccHVEc/vHWU7
         BU14XYKUfBthNaww7JbRXpPp8MotuXOtnngsIAGs=
Received: from localhost (localhost [127.0.0.1])
        by ns.pmeerw.net (Postfix) with ESMTP id 6014BE00EE;
        Tue, 26 Feb 2019 08:22:02 +0100 (CET)
Date:   Tue, 26 Feb 2019 08:22:02 +0100 (CET)
From:   Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To:     Andreas Klinger <ak@it-klinger.de>
cc:     jic23@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] iio/proximity: add mb12x2 driver to Kconfig and
 Makefile
In-Reply-To: <20190224162235.7kidyum2dwg5bua5@arbad>
Message-ID: <alpine.DEB.2.21.1902260820570.17137@vps.pmeerw.net>
References: <20190224162235.7kidyum2dwg5bua5@arbad>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Feb 2019, Andreas Klinger wrote:

> Makefile and Kconfig: add configuration for mb12x2 ultrasonic proximity
> driver
> 

> diff --git a/drivers/iio/proximity/Makefile b/drivers/iio/proximity/Makefile
> index 6d031f903c4c..c56b72a8be87 100644
> --- a/drivers/iio/proximity/Makefile
> +++ b/drivers/iio/proximity/Makefile
> @@ -6,6 +6,7 @@
>  # When adding new entries keep the list in alphabetical order
>  obj-$(CONFIG_AS3935)		+= as3935.o
>  obj-$(CONFIG_ISL29501)		+= isl29501.o
> +obj-$(CONFIG_MB12X2)		+= mb12x2.o

alphabetic order please

>  obj-$(CONFIG_LIDAR_LITE_V2)	+= pulsedlight-lidar-lite-v2.o
>  obj-$(CONFIG_RFD77402)		+= rfd77402.o
>  obj-$(CONFIG_SRF04)		+= srf04.o
> 

-- 

Peter Meerwald-Stadler
Mobile: +43 664 24 44 418
