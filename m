Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD126C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 20:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B25720843
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 20:34:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B25720843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jic23.retrosnub.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbeICAvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 20:51:45 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:56278 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbeICAvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 20:51:45 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 761689E78DA;
        Sun,  2 Sep 2018 21:34:44 +0100 (BST)
Date:   Sun, 2 Sep 2018 21:34:43 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Tomasz Duszynski <tduszyns@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: pressure: ms5611: switch to SPDX identifier
Message-ID: <20180902213443.60d89a61@archlinux>
In-Reply-To: <20180901195214.11485-1-tduszyns@gmail.com>
References: <20180901195214.11485-1-tduszyns@gmail.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  1 Sep 2018 21:52:14 +0200
Tomasz Duszynski <tduszyns@gmail.com> wrote:

> Drop boilerplate license text and use SPDX identifier instead.
> 
> Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>

Applied.

Thanks,

Jonathan
> ---
>  drivers/iio/pressure/ms5611.h      | 5 +----
>  drivers/iio/pressure/ms5611_core.c | 5 +----
>  drivers/iio/pressure/ms5611_i2c.c  | 5 +----
>  drivers/iio/pressure/ms5611_spi.c  | 5 +----
>  4 files changed, 4 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iio/pressure/ms5611.h b/drivers/iio/pressure/ms5611.h
> index ead9e9f85894..c9dd86de3ade 100644
> --- a/drivers/iio/pressure/ms5611.h
> +++ b/drivers/iio/pressure/ms5611.h
> @@ -1,12 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
>  /*
>   * MS5611 pressure and temperature sensor driver
>   *
>   * Copyright (c) Tomasz Duszynski <tduszyns@gmail.com>
>   *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
>   */
> 
>  #ifndef _MS5611_H
> diff --git a/drivers/iio/pressure/ms5611_core.c b/drivers/iio/pressure/ms5611_core.c
> index f950cfde5db9..2f598ad91621 100644
> --- a/drivers/iio/pressure/ms5611_core.c
> +++ b/drivers/iio/pressure/ms5611_core.c
> @@ -1,12 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * MS5611 pressure and temperature sensor driver
>   *
>   * Copyright (c) Tomasz Duszynski <tduszyns@gmail.com>
>   *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
>   * Data sheet:
>   *  http://www.meas-spec.com/downloads/MS5611-01BA03.pdf
>   *  http://www.meas-spec.com/downloads/MS5607-02BA03.pdf
> diff --git a/drivers/iio/pressure/ms5611_i2c.c b/drivers/iio/pressure/ms5611_i2c.c
> index 0469c8ae1134..8089c59adce5 100644
> --- a/drivers/iio/pressure/ms5611_i2c.c
> +++ b/drivers/iio/pressure/ms5611_i2c.c
> @@ -1,12 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * MS5611 pressure and temperature sensor driver (I2C bus)
>   *
>   * Copyright (c) Tomasz Duszynski <tduszyns@gmail.com>
>   *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
>   * 7-bit I2C slave addresses:
>   *
>   * 0x77 (CSB pin low)
> diff --git a/drivers/iio/pressure/ms5611_spi.c b/drivers/iio/pressure/ms5611_spi.c
> index cd11d022208e..b463eaa799ab 100644
> --- a/drivers/iio/pressure/ms5611_spi.c
> +++ b/drivers/iio/pressure/ms5611_spi.c
> @@ -1,12 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * MS5611 pressure and temperature sensor driver (SPI bus)
>   *
>   * Copyright (c) Tomasz Duszynski <tduszyns@gmail.com>
>   *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
>   */
> 
>  #include <linux/delay.h>
> --
> 2.18.0
> 

