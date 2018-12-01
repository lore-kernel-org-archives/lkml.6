Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DF9C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 187BE2146D
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCOGLGm1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 187BE2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbeLBCv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 21:51:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:52116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726717AbeLBCv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 21:51:28 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40B8B20673;
        Sat,  1 Dec 2018 15:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543678721;
        bh=qFyP+CHu9ZD2Rc9X/FeCqMF5ChIQada4nHR023hLUAQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GCOGLGm1OgKO5090fQ0fF+ly3pPbqvtapDo95FgjpJvEe35nw6p9pgbGi4FtPzWLr
         EU5HCO0jENuyDhn+X4iaY/3MFhkURnB+28SM77KktioovvRLxVq2xBGjNSNIHuswcn
         JKZX4p8Ttydww8jIr6GzjdQ3yt1Cx+LEIg+gkey0=
Date:   Sat, 1 Dec 2018 15:38:36 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        kernel-usp@googlegroups.com, victorcolombo@gmail.com
Subject: Re: [PATCH v3 5/7] staging:iio:ad2s90: Replace license text w/ SPDX
 identifier
Message-ID: <20181201153836.35cb6318@archlinux>
In-Reply-To: <20181124002312.6923-6-matheus.bernardino@usp.br>
References: <20181124002312.6923-1-matheus.bernardino@usp.br>
        <20181124002312.6923-6-matheus.bernardino@usp.br>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Nov 2018 22:23:10 -0200
Matheus Tavares <matheus.bernardino@usp.br> wrote:

> This patch removes the license boilerplate text at the top of ad2s90.c
> and, instead, adds the SPDX GPL-2.0 license identifier, which solves the
> checkpatch.pl warning:
> "WARNING: Missing or malformed SPDX-License-Identifier tag in line 1".
> 
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
Applied,

Thanks,

Jonathan

> ---
> Changes in v3:
>  - none
> 
> Changes in v2:
>  - Changed GPL-2.0-only identifier to GPL-2.0
>  - Removed license boilerplate text
>  - Rewritten patch message to reflect these modifications
> 
>  drivers/staging/iio/resolver/ad2s90.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
> index 4721e9bbb8b0..678351dabe6b 100644
> --- a/drivers/staging/iio/resolver/ad2s90.c
> +++ b/drivers/staging/iio/resolver/ad2s90.c
> @@ -1,12 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * ad2s90.c simple support for the ADI Resolver to Digital Converters: AD2S90
>   *
>   * Copyright (c) 2010-2010 Analog Devices Inc.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
>   */
>  #include <linux/types.h>
>  #include <linux/mutex.h>

