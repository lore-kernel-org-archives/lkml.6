Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CAC8C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E3CA20578
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545500848;
	bh=+y8DKVpaShJxLpAouXY8gjjoxuJIui3wt1YAbafvzHg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=IL+LT7Sp5/WjfGYXYfim6fOrjkOQQ7W8Y2Qefaj5fu6dFCYtsBkzgrJc6Gxork/sn
	 RsNYkAUSFDQI4P4hcAvZxxiinGCrxRadjeVo8jIG4PJq1K/Ul44zK9NvdaH1mRUGdJ
	 fagUZL+B6+mL2oTWhW4lNAYFCuiUzJocjEqPKm14=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404418AbeLVRr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:47:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:34398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389059AbeLVRr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:47:26 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 041992054F;
        Sat, 22 Dec 2018 17:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545500845;
        bh=+y8DKVpaShJxLpAouXY8gjjoxuJIui3wt1YAbafvzHg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=L8sd5BtYLy3+7IZyHIRGwSNrGHU0qYFX4e5k+a6UMfD3nIdpnyZclrC3FjrepeNA3
         uPRm1ODpCNUOABh5cvkDhCFNCEPCAma1ESoZ5ECTDR471NyAi6p6LhvMRuRuc7hHIl
         smygyol+AJOUT4v5eLZmqDy9qwQ1ajD4wW+IHmaU=
Date:   Sat, 22 Dec 2018 17:47:19 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>
Subject: Re: [PATCH v2 2/6] staging: iio: adc: ad7606: Use SPDX identifier
Message-ID: <20181222174719.424b8fc2@archlinux>
In-Reply-To: <1545049420-16484-3-git-send-email-stefan.popa@analog.com>
References: <1545049420-16484-1-git-send-email-stefan.popa@analog.com>
        <1545049420-16484-3-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.17.2 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2018 14:23:36 +0200
Stefan Popa <stefan.popa@analog.com> wrote:

> This patch replaces the license text at the top of ad7606 driver files
> and instead adds SPDX GPL-2.0 license identifier.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> ---
>  drivers/staging/iio/adc/ad7606.c     | 5 ++---
>  drivers/staging/iio/adc/ad7606.h     | 3 +--
>  drivers/staging/iio/adc/ad7606_par.c | 5 ++---
>  drivers/staging/iio/adc/ad7606_spi.c | 5 ++---
>  4 files changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7606.c b/drivers/staging/iio/adc/ad7606.c
> index e1d85b7..97b4a83 100644
> --- a/drivers/staging/iio/adc/ad7606.c
> +++ b/drivers/staging/iio/adc/ad7606.c
> @@ -1,9 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * AD7606 SPI ADC driver
>   *
>   * Copyright 2011 Analog Devices Inc.
> - *
> - * Licensed under the GPL-2.
>   */
>  
>  #include <linux/interrupt.h>
> @@ -531,4 +530,4 @@ EXPORT_SYMBOL_GPL(ad7606_pm_ops);
>  
>  MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
>  MODULE_DESCRIPTION("Analog Devices AD7606 ADC");
> -MODULE_LICENSE("GPL v2");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/staging/iio/adc/ad7606.h b/drivers/staging/iio/adc/ad7606.h
> index 510a93d..3e12fff 100644
> --- a/drivers/staging/iio/adc/ad7606.h
> +++ b/drivers/staging/iio/adc/ad7606.h
> @@ -1,9 +1,8 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
>  /*
>   * AD7606 ADC driver
>   *
>   * Copyright 2011 Analog Devices Inc.
> - *
> - * Licensed under the GPL-2.
>   */
>  
>  #ifndef IIO_ADC_AD7606_H_
> diff --git a/drivers/staging/iio/adc/ad7606_par.c b/drivers/staging/iio/adc/ad7606_par.c
> index da26742..2d137b1 100644
> --- a/drivers/staging/iio/adc/ad7606_par.c
> +++ b/drivers/staging/iio/adc/ad7606_par.c
> @@ -1,9 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * AD7606 Parallel Interface ADC driver
>   *
>   * Copyright 2011 Analog Devices Inc.
> - *
> - * Licensed under the GPL-2.
>   */
>  
>  #include <linux/module.h>
> @@ -114,4 +113,4 @@ module_platform_driver(ad7606_driver);
>  
>  MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
>  MODULE_DESCRIPTION("Analog Devices AD7606 ADC");
> -MODULE_LICENSE("GPL v2");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/staging/iio/adc/ad7606_spi.c b/drivers/staging/iio/adc/ad7606_spi.c
> index e533917..f38f0d6 100644
> --- a/drivers/staging/iio/adc/ad7606_spi.c
> +++ b/drivers/staging/iio/adc/ad7606_spi.c
> @@ -1,9 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * AD7606 SPI ADC driver
>   *
>   * Copyright 2011 Analog Devices Inc.
> - *
> - * Licensed under the GPL-2.
>   */
>  
>  #include <linux/module.h>
> @@ -80,4 +79,4 @@ module_spi_driver(ad7606_driver);
>  
>  MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
>  MODULE_DESCRIPTION("Analog Devices AD7606 ADC");
> -MODULE_LICENSE("GPL v2");
> +MODULE_LICENSE("GPL");
Err. Nope. That is "GPL v2 or later"  Guessing accidentally left behind.

I've cleaned up all 3 cases of this whilst applying.   Shout if that
doesn't actually make sense.  Now we have consistent SPDX and MODULE_LICENSE
with all being GPL v2 only.

Thanks,

Jonathan


