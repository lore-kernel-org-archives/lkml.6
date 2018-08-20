Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C279CC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 18:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76B9E2173D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 18:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QfPi3q6m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76B9E2173D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbeHTVoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 17:44:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:48674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbeHTVoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 17:44:03 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26AA821473;
        Mon, 20 Aug 2018 18:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534789640;
        bh=RfzMqc0zYrAL34WiuM6G8Me5GKxjAkulfF77siuLBI4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QfPi3q6mj1QE2bwpN/BDy9x4ude76JdSZauszn/5516KLkxFRuavMiUfktwRZonmA
         9gQ020WvnyRUGYY4HPxeVQxWAp58GcmJjaNnBKq+V8hm6/dIiYgGMv8q9yVByxuFJx
         0pO13SgwOZME5+mOjfC4HkK/UxPDiEgehqV7zvfE=
Date:   Mon, 20 Aug 2018 19:27:17 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Peter Rosin <peda@axentia.se>
Cc:     linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/5] iio: envelope-detector: switch to SPDX license
 identifier
Message-ID: <20180820192717.6dcd1979@archlinux>
In-Reply-To: <20180820100114.22966-4-peda@axentia.se>
References: <20180820100114.22966-1-peda@axentia.se>
        <20180820100114.22966-4-peda@axentia.se>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Aug 2018 12:01:12 +0200
Peter Rosin <peda@axentia.se> wrote:

> Drop the boilerplate license text.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
Applied, thanks.
> ---
>  drivers/iio/adc/envelope-detector.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/envelope-detector.c b/drivers/iio/adc/envelope-detector.c
> index 4ebda8ab54fe..2f2b563c1162 100644
> --- a/drivers/iio/adc/envelope-detector.c
> +++ b/drivers/iio/adc/envelope-detector.c
> @@ -1,13 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Driver for an envelope detector using a DAC and a comparator
>   *
>   * Copyright (C) 2016 Axentia Technologies AB
>   *
>   * Author: Peter Rosin <peda@axentia.se>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
>   */
>  
>  /*

