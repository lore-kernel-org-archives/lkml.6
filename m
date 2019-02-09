Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B0DC282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 15:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45C7C21919
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 15:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549726993;
	bh=54hQJezVpERzSpXE1RHScfzqKbUGqhClJ8H0c8ubSl4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Vo6rv1HXDMHBTr8CxHVwojnS8UvmGaw7w38hKaPSeJ8FCjZgvofPZN7ejNaiz6P5c
	 8y0Jtg3nMBVKN1JHURAqbeoOIgqKpf0maMRujPekwQcLEZTBwo6T//KGbkeSDQGf1d
	 8m24xcaA1Znd8aYWfN6Y9ADKqLoBiqW1fU3GmcmM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfBIPnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 10:43:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:36150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726741AbfBIPnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 10:43:10 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8390E217D8;
        Sat,  9 Feb 2019 15:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549726989;
        bh=54hQJezVpERzSpXE1RHScfzqKbUGqhClJ8H0c8ubSl4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lBH4nYAW5NvJ5NIK3awTbzAmVHZX1pfz+JJWXnMsP/uh5cCs38mKaYY3Zcj7xXLUa
         6mU9N+mbKo9uh2LRpfRnBnhp95GbzPotaZvjapLzSt4ixmWI5r/NRI/elByVpsQgZQ
         tRHw/deE8C9S6bQugLNakoBr3v6exM29bKCQ2P5U=
Date:   Sat, 9 Feb 2019 15:43:02 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2] drivers: iio: dac: Fix wrong license for ADI drivers
Message-ID: <20190209154302.35a2cb7e@archlinux>
In-Reply-To: <1549271975-15634-1-git-send-email-stefan.popa@analog.com>
References: <1549271975-15634-1-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Feb 2019 11:19:35 +0200
Stefan Popa <stefan.popa@analog.com> wrote:

> Analog Devices drivers are typically GPL v2 only. This patch fixes the
> inconsistencies between the module license and SPDX.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Applied, thanks.

Jonathan

> ---
> Changes in v2:
> 	- Modified only the drivers with inconsistencies.
> 
>  drivers/iio/dac/ad5686-spi.c | 2 +-
>  drivers/iio/dac/ad5686.c     | 2 +-
>  drivers/iio/dac/ad5686.h     | 2 +-
>  drivers/iio/dac/ad5696-i2c.c | 2 +-
>  drivers/iio/dac/ad5758.c     | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5686-spi.c b/drivers/iio/dac/ad5686-spi.c
> index 4d857c8..0188ded 100644
> --- a/drivers/iio/dac/ad5686-spi.c
> +++ b/drivers/iio/dac/ad5686-spi.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * AD5672R, AD5674R, AD5676, AD5676R, AD5679R,
>   * AD5681R, AD5682R, AD5683, AD5683R, AD5684,
> diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
> index 6dd2759..e06b29c 100644
> --- a/drivers/iio/dac/ad5686.c
> +++ b/drivers/iio/dac/ad5686.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * AD5686R, AD5685R, AD5684R Digital to analog converters  driver
>   *
> diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
> index 4c3e171..70a7799 100644
> --- a/drivers/iio/dac/ad5686.h
> +++ b/drivers/iio/dac/ad5686.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0+ */
> +/* SPDX-License-Identifier: GPL-2.0 */
>  /*
>   * This file is part of AD5686 DAC driver
>   *
> diff --git a/drivers/iio/dac/ad5696-i2c.c b/drivers/iio/dac/ad5696-i2c.c
> index 7350d98..ccf794c 100644
> --- a/drivers/iio/dac/ad5696-i2c.c
> +++ b/drivers/iio/dac/ad5696-i2c.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * AD5671R, AD5675R, AD5691R, AD5692R, AD5693, AD5693R,
>   * AD5694, AD5694R, AD5695R, AD5696, AD5696R
> diff --git a/drivers/iio/dac/ad5758.c b/drivers/iio/dac/ad5758.c
> index ef41f12..2bdf1b0 100644
> --- a/drivers/iio/dac/ad5758.c
> +++ b/drivers/iio/dac/ad5758.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * AD5758 Digital to analog converters driver
>   *

