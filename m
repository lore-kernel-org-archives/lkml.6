Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8680EC43444
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E240205C9
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545501021;
	bh=9cknvmJt7F/GJRsXo3taOcR/vtA4tMM68M08Txop0q8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=SArULFV45lAop7k78tljhtQV5e7MGKpOBwFtOoGWCvtzH4rfffqUUSRUDekVq79Aq
	 lgcZxLvNtgYaLImbEb1DmhZ0KP9lQ2F8ObnG7HZL3vOTzDRX3P7ktUzx6105gxAPGg
	 RHyWkq3FBqrzY80yN5y0dBALWS8V/WSgqK0dXzHc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391852AbeLVRuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:50:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:36174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730497AbeLVRuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:50:19 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EF182054F;
        Sat, 22 Dec 2018 17:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545501018;
        bh=9cknvmJt7F/GJRsXo3taOcR/vtA4tMM68M08Txop0q8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AIWq3/4mFDsctuSrVTTwtBSz3mqxfQiskBSLldGymCYaS5zRBTCnPg1p4KSoMQbhi
         1Z/guYr9KeBvjGnm0V8aIzMZYo8ZoAirMyDPD3+JYYYV2BL0MoK2iOhX6ccylNKhCb
         z+OYArdYc8G/hiL5hC3XJJlzj/Q1MobZPkAAtA68=
Date:   Sat, 22 Dec 2018 17:50:10 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>
Subject: Re: [PATCH v2 4/6] staging: iio: adc: ad7606: Misc style fixes (no
 functional change)
Message-ID: <20181222175010.548516be@archlinux>
In-Reply-To: <1545049420-16484-5-git-send-email-stefan.popa@analog.com>
References: <1545049420-16484-1-git-send-email-stefan.popa@analog.com>
        <1545049420-16484-5-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.17.2 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2018 14:23:38 +0200
Stefan Popa <stefan.popa@analog.com> wrote:

> * Placed includes in alphabetical order
> * Added brackets around num and mask through out for AD760X_CHANNEL
> * Used single line comments where needed
> * Removed extra lines and spaces
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Applied.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/adc/ad7606.c     | 27 ++++++++++++---------------
>  drivers/staging/iio/adc/ad7606.h     |  1 -
>  drivers/staging/iio/adc/ad7606_par.c | 27 ++++++++-------------------
>  drivers/staging/iio/adc/ad7606_spi.c | 16 ++++++++--------
>  4 files changed, 28 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7606.c b/drivers/staging/iio/adc/ad7606.c
> index 5f0712c..32854f1 100644
> --- a/drivers/staging/iio/adc/ad7606.c
> +++ b/drivers/staging/iio/adc/ad7606.c
> @@ -5,25 +5,25 @@
>   * Copyright 2011 Analog Devices Inc.
>   */
>  
> -#include <linux/interrupt.h>
> +#include <linux/delay.h>
>  #include <linux/device.h>
> -#include <linux/kernel.h>
> -#include <linux/slab.h>
> -#include <linux/sysfs.h>
> -#include <linux/regulator/consumer.h>
>  #include <linux/err.h>
>  #include <linux/gpio/consumer.h>
> -#include <linux/delay.h>
> -#include <linux/sched.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/sched.h>
> +#include <linux/slab.h>
> +#include <linux/sysfs.h>
>  #include <linux/util_macros.h>
>  
>  #include <linux/iio/iio.h>
> -#include <linux/iio/sysfs.h>
>  #include <linux/iio/buffer.h>
> -#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/sysfs.h>
>  #include <linux/iio/trigger.h>
>  #include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>
>  
>  #include "ad7606.h"
>  
> @@ -249,8 +249,7 @@ static const struct attribute_group ad7606_attribute_group_range = {
>  	.attrs = ad7606_attributes_range,
>  };
>  
> -#define AD760X_CHANNEL(num, mask)				\
> -	{							\
> +#define AD760X_CHANNEL(num, mask) {				\
>  		.type = IIO_VOLTAGE,				\
>  		.indexed = 1,					\
>  		.channel = num,					\
> @@ -265,7 +264,7 @@ static const struct attribute_group ad7606_attribute_group_range = {
>  			.storagebits = 16,			\
>  			.endianness = IIO_CPU,			\
>  		},						\
> -	}
> +}
>  
>  #define AD7605_CHANNEL(num)	\
>  	AD760X_CHANNEL(num, 0)
> @@ -294,9 +293,7 @@ static const struct iio_chan_spec ad7606_channels[] = {
>  };
>  
>  static const struct ad7606_chip_info ad7606_chip_info_tbl[] = {
> -	/*
> -	 * More devices added in future
> -	 */
> +	/* More devices added in future */
>  	[ID_AD7605_4] = {
>  		.channels = ad7605_channels,
>  		.num_channels = 5,
> diff --git a/drivers/staging/iio/adc/ad7606.h b/drivers/staging/iio/adc/ad7606.h
> index 9a832d2..5d12410 100644
> --- a/drivers/staging/iio/adc/ad7606.h
> +++ b/drivers/staging/iio/adc/ad7606.h
> @@ -14,7 +14,6 @@
>   * @num_channels:	number of channels
>   * @has_oversampling:   whether the device has oversampling support
>   */
> -
>  struct ad7606_chip_info {
>  	const struct iio_chan_spec	*channels;
>  	unsigned int			num_channels;
> diff --git a/drivers/staging/iio/adc/ad7606_par.c b/drivers/staging/iio/adc/ad7606_par.c
> index 2d137b1..df607c7 100644
> --- a/drivers/staging/iio/adc/ad7606_par.c
> +++ b/drivers/staging/iio/adc/ad7606_par.c
> @@ -26,7 +26,7 @@ static int ad7606_par16_read_block(struct device *dev,
>  }
>  
>  static const struct ad7606_bus_ops ad7606_par16_bops = {
> -	.read_block	= ad7606_par16_read_block,
> +	.read_block = ad7606_par16_read_block,
>  };
>  
>  static int ad7606_par8_read_block(struct device *dev,
> @@ -41,7 +41,7 @@ static int ad7606_par8_read_block(struct device *dev,
>  }
>  
>  static const struct ad7606_bus_ops ad7606_par8_bops = {
> -	.read_block	= ad7606_par8_read_block,
> +	.read_block = ad7606_par8_read_block,
>  };
>  
>  static int ad7606_par_probe(struct platform_device *pdev)
> @@ -72,22 +72,12 @@ static int ad7606_par_probe(struct platform_device *pdev)
>  }
>  
>  static const struct platform_device_id ad7606_driver_ids[] = {
> -	{
> -		.name		= "ad7605-4",
> -		.driver_data	= ID_AD7605_4,
> -	}, {
> -		.name		= "ad7606-8",
> -		.driver_data	= ID_AD7606_8,
> -	}, {
> -		.name		= "ad7606-6",
> -		.driver_data	= ID_AD7606_6,
> -	}, {
> -		.name		= "ad7606-4",
> -		.driver_data	= ID_AD7606_4,
> -	},
> +	{ .name	= "ad7605-4", .driver_data = ID_AD7605_4, },
> +	{ .name	= "ad7606-4", .driver_data = ID_AD7606_4, },
> +	{ .name	= "ad7606-6", .driver_data = ID_AD7606_6, },
> +	{ .name	= "ad7606-8", .driver_data = ID_AD7606_8, },
>  	{ }
>  };
> -
>  MODULE_DEVICE_TABLE(platform, ad7606_driver_ids);
>  
>  static const struct of_device_id ad7606_of_match[] = {
> @@ -103,12 +93,11 @@ static struct platform_driver ad7606_driver = {
>  	.probe = ad7606_par_probe,
>  	.id_table = ad7606_driver_ids,
>  	.driver = {
> -		.name	 = "ad7606",
> -		.pm	 = AD7606_PM_OPS,
> +		.name = "ad7606",
> +		.pm = AD7606_PM_OPS,
>  		.of_match_table = ad7606_of_match,
>  	},
>  };
> -
>  module_platform_driver(ad7606_driver);
>  
>  MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
> diff --git a/drivers/staging/iio/adc/ad7606_spi.c b/drivers/staging/iio/adc/ad7606_spi.c
> index f38f0d6..f842eba 100644
> --- a/drivers/staging/iio/adc/ad7606_spi.c
> +++ b/drivers/staging/iio/adc/ad7606_spi.c
> @@ -36,7 +36,7 @@ static int ad7606_spi_read_block(struct device *dev,
>  }
>  
>  static const struct ad7606_bus_ops ad7606_spi_bops = {
> -	.read_block	= ad7606_spi_read_block,
> +	.read_block = ad7606_spi_read_block,
>  };
>  
>  static int ad7606_spi_probe(struct spi_device *spi)
> @@ -48,14 +48,14 @@ static int ad7606_spi_probe(struct spi_device *spi)
>  			    &ad7606_spi_bops);
>  }
>  
> -static const struct spi_device_id ad7606_id[] = {
> -	{"ad7605-4", ID_AD7605_4},
> -	{"ad7606-8", ID_AD7606_8},
> -	{"ad7606-6", ID_AD7606_6},
> -	{"ad7606-4", ID_AD7606_4},
> +static const struct spi_device_id ad7606_id_table[] = {
> +	{ "ad7605-4", ID_AD7605_4 },
> +	{ "ad7606-4", ID_AD7606_4 },
> +	{ "ad7606-6", ID_AD7606_6 },
> +	{ "ad7606-8", ID_AD7606_8 },
>  	{}
>  };
> -MODULE_DEVICE_TABLE(spi, ad7606_id);
> +MODULE_DEVICE_TABLE(spi, ad7606_id_table);
>  
>  static const struct of_device_id ad7606_of_match[] = {
>  	{ .compatible = "adi,ad7605-4" },
> @@ -73,7 +73,7 @@ static struct spi_driver ad7606_driver = {
>  		.pm = AD7606_PM_OPS,
>  	},
>  	.probe = ad7606_spi_probe,
> -	.id_table = ad7606_id,
> +	.id_table = ad7606_id_table,
>  };
>  module_spi_driver(ad7606_driver);
>  

