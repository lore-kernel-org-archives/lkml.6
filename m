Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 602CAC43612
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 13:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 287B321836
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 13:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544968568;
	bh=WLEGPaEa81shoZcav7OD4xxyMLWm+rT4FRH+Kv/6moY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=2kWLlTyGEUF1yc9j0ar7OlxCtfiSyF/uaopiSE5U2tLT2BINWBk2Vy8orD7TQN6l1
	 JmWioK8y28g89B+6h/JRvdHuOfjymDYbv5FK9eWdLHzNIt4IaaSBdc6z+TxKt3XmgM
	 3vu4RVtYWlGH9RRI0wY3ZsrFVzoekR/TdYGckNio=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730623AbeLPN4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 08:56:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:34246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729859AbeLPN4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 08:56:06 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 774AD2086C;
        Sun, 16 Dec 2018 13:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544968565;
        bh=WLEGPaEa81shoZcav7OD4xxyMLWm+rT4FRH+Kv/6moY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LsuCY3gnC47263BEzi7mDVU66hlwAShH738jETAMy4lNsu74bTG8HBHvUX0WeNed7
         Siit2ftIsRPP3e/E4B13LgoAnobb3IsL5lErQf63zXaG0ClnYHEnP223zrefGrzVsp
         KBT1rv/AOPLPGVfS+itW1CFvePUbe6y1CSjfXTzg=
Date:   Sun, 16 Dec 2018 13:56:00 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <stefan.popa@analog.co>
Subject: Re: [PATCH 09/11] staging: iio: adc: ad7606: Misc style fixes (no
 functional change)
Message-ID: <20181216135600.68ecf711@archlinux>
In-Reply-To: <1544705183-13288-10-git-send-email-stefan.popa@analog.com>
References: <1544705183-13288-1-git-send-email-stefan.popa@analog.com>
        <1544705183-13288-10-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.17.2 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Dec 2018 14:46:21 +0200
Stefan Popa <stefan.popa@analog.com> wrote:

> * Placed includes in alphabetical order
> * Added brackets around num and mask through out for AD760X_CHANNEL
> * Used single line comments where needed
> * Removed extra lines and spaces
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Looks fine, but unsurprisingly doesn't apply given I haven't taken all
the precursors.  Will pick up in v2.

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
> index 3355301..5733760 100644
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
> index b238e9b..40433af 100644
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
> index ac0c7b0..32c7069 100644
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
> index 2608d34..b628389 100644
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

