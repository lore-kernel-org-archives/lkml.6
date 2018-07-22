Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06216C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 07:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DDD220875
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 07:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZSb/dW9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DDD220875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbeGVIgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 04:36:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:42658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727879AbeGVIgG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 04:36:06 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C3BD20874;
        Sun, 22 Jul 2018 07:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532245221;
        bh=POYOwD39xBtYMRaD8l4iGQGr+ol9GKF24IqtzZZkbck=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gZSb/dW9x04H4gzXR4qzy3nshmSIAfrkBuoFuuvC9ADg1BBvpEIb+ox6cPAHM/oRM
         lnXm8/cyGeLha8kxB6M2ox9LdygWl3h/M8AXfM7qD+fTDermXoHhWOngYNfunEWKgD
         uJyflV+KCteAQ00FKtnfzc4QZsxrqPuUXuBmDKuY=
Date:   Sun, 22 Jul 2018 08:40:16 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Lechner <david@lechnology.com>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iio: adc: ti-ads7950: use
 SPDX-License-Identifier
Message-ID: <20180722084016.12e208a0@archlinux>
In-Reply-To: <20180721193734.6427-2-david@lechnology.com>
References: <20180721193734.6427-1-david@lechnology.com>
        <20180721193734.6427-2-david@lechnology.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Jul 2018 14:37:33 -0500
David Lechner <david@lechnology.com> wrote:

> This updates the ti-ads7950.c file to use SPDX-License-Identifier
> instead of more verbose license text.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
Applied, thanks,

Jonathan

> ---
>  drivers/iio/adc/ti-ads7950.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
> index 0225c1b333ab..f08c4de2bd10 100644
> --- a/drivers/iio/adc/ti-ads7950.c
> +++ b/drivers/iio/adc/ti-ads7950.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Texas Instruments ADS7950 SPI ADC driver
>   *
> @@ -10,15 +11,6 @@
>   * And also on hwmon/ads79xx.c
>   * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com/
>   *	Nishanth Menon
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License as
> - * published by the Free Software Foundation version 2.
> - *
> - * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> - * kind, whether express or implied; without even the implied warranty
> - * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
>   */
>  
>  #include <linux/acpi.h>

