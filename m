Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D115C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFDCA2151D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:16:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFDCA2151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732409AbeHNRDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 13:03:55 -0400
Received: from smtprelay0160.hostedemail.com ([216.40.44.160]:43115 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728458AbeHNRDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 13:03:55 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 7AB3E100E86C9;
        Tue, 14 Aug 2018 14:16:32 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: balls88_1bbcb73b4ee44
X-Filterd-Recvd-Size: 2010
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Tue, 14 Aug 2018 14:16:30 +0000 (UTC)
Message-ID: <9461e62248cc7c1b5585004ff8cf7268b823e29c.camel@perches.com>
Subject: Re: [RESEND PATCH 1/6] ARM: config: multi_v5: enable dynamic debug
From:   Joe Perches <golf@perches.com>
To:     Marcel Ziswiler <marcel@ziswiler.com>,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Andrew Jeffery <andrew@aj.id.au>, linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Joel Stanley <joel@jms.id.au>,
        Russell King <linux@armlinux.org.uk>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Date:   Tue, 14 Aug 2018 07:16:29 -0700
In-Reply-To: <20180814140612.12554-1-marcel@ziswiler.com>
References: <20180814140612.12554-1-marcel@ziswiler.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-08-14 at 16:06 +0200, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Dynamic debug is really helpful.

It's useful, but perhaps not appropriate.

Most arm configs are for small resource constrained systems.
dynamic_debug adds a lot of additional text and a fair amount of data.


> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> ---
> 
>  arch/arm/configs/multi_v5_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/multi_v5_defconfig b/arch/arm/configs/multi_v5_defconfig
> index 318b76fa26d1..b302ac68d587 100644
> --- a/arch/arm/configs/multi_v5_defconfig
> +++ b/arch/arm/configs/multi_v5_defconfig
> @@ -275,6 +275,7 @@ CONFIG_NLS_CODEPAGE_850=y
>  CONFIG_NLS_ISO8859_1=y
>  CONFIG_NLS_ISO8859_2=y
>  CONFIG_NLS_UTF8=y
> +CONFIG_DYNAMIC_DEBUG=y
>  CONFIG_DEBUG_INFO=y
>  CONFIG_DEBUG_FS=y
>  CONFIG_MAGIC_SYSRQ=y
