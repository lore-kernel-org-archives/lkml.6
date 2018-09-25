Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC999C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F25220867
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T603A+Vs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F25220867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729632AbeIYWJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 18:09:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50380 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728598AbeIYWJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 18:09:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HqKP+zoeY3hRSYPDBvNsm93LlJdtksYuicBO3AJZP1k=; b=T603A+Vsfp9cd8tDM0ALStBUI
        DdbqYxMdadcp+nUuGvlgHH14jDLa+SIIzhhluonsi78pAo/vBMzcZKfE4w9+RqHTyZlNXXaHVaNoP
        /7lpcQxe0hwPWDYJthVeEwtEyoWqo7mJSbu6n/CPZJ0AlMJcaizNZmI/TrlGZ4xgl2OR/F8QLWcCv
        yYewq2XabmZUpXYSY/zQfkeq/WfUA1Rjt/iIOXKNTBqpvAM8jrEA9mLCwqICw6frugYjYfyKUR3oS
        mCcYwCM4uqw2J3fdiDRF2Jl6xiyvz9v5eT6TzKDiK3/pC59O0ErLY8VBjWJY70AKYaMXt4EXxMjGT
        aFIaFVTXA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g4plJ-00066F-MN; Tue, 25 Sep 2018 16:00:49 +0000
Subject: Re: [PATCH] staging: dgnc: Fix Kconfig help header and text
To:     sehro rautenkranz <sehro@sehro.org>
Cc:     devel@driverdev.osuosl.org, Mark Hounschell <markh@compro.net>,
        Lidza Louina <lidza.louina@gmail.com>,
        driverdev-devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <d5bb4ab0-42f6-3fd1-006d-670a355e8702@infradead.org>
 <20180925155309.15861-1-sehro@sehro.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a62c2d41-5ae6-26a1-3c0e-01893a8ca8a0@infradead.org>
Date:   Tue, 25 Sep 2018 09:00:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180925155309.15861-1-sehro@sehro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/25/18 8:53 AM, sehro rautenkranz wrote:
> Replace Kconfig help header and text to match other modules. Issue found
> my checkpatch.

  by checkpatch.

> 
> Spacing adjusted to match Documentation/process/coding-style.rst. Issue
> reported by rdunlap@infradead.org.

Reported-by: Randy Dunlap <rdunlap@infradead.org>


> 
> Signed-off-by: sehro rautenkranz <sehro@sehro.org>
> ---
>  drivers/staging/dgnc/Kconfig | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/dgnc/Kconfig b/drivers/staging/dgnc/Kconfig
> index c845b357b53d..7361d6cd73d4 100644
> --- a/drivers/staging/dgnc/Kconfig
> +++ b/drivers/staging/dgnc/Kconfig
> @@ -3,8 +3,8 @@ config DGNC
>         default n
>         depends on TTY && PCI
>         help
> -            Say Y here to enable support for the Digi International Neo and
> -            Classic PCI based product line.
> +                 Say Y here to enable support for the Digi International Neo and
> +                 Classic PCI based product line.
>  
> -            To compile this driver as a module, say M here: the module will be
> -            called dgnc
> +                 To compile this driver as a module, say M here: the module will be
> +                 called dgnc


That indentation is still not correct.  :(

-- 
~Randy
