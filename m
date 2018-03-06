Return-Path: <shreeya.patel23498@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520371627; cv=none;
        d=google.com; s=arc-20160816;
        b=En5OlvZhJ5AKJNdYFZitJp36r0T1JUPOMGY1mueL4/CT/yMbRKpN+v/gQUTOIxSDEn
         zvP+3yUB+2MvXWRGhFz4/G8aoDnkKFc7nTj2vW6DO2yCXsEZLb+oASm+OQ8c3//MVlyn
         pgiLAjGQIwfoOur2lw4Jwj6Xt9qTGRl576aPqh++BPhq5bdrEkv9raSPYNpifWZCmKpt
         C/VBhGNE6RQ9QtGEWk4mcx/WhoLi6pfZDFzATa3hIwxFf/f2Nv0HxoEMB4duLoxLzzEL
         XDarVLFuR/MZNT6ghV2yQZy26i6R2MS5uI0Vm5tW49Wvtb3Icht+l09tfs/1fXlGvuap
         cmVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:dkim-signature
         :arc-authentication-results;
        bh=BBFuBnX8jcGl/pJU0+Ds1A1VVaUVhVeEuKJamt0vuY0=;
        b=dG/k5n/7Jy/L/Qo+T3aLgw8cd72JD8XSODx54nCSBQfcxaySjKecJPKArypTy+8iFA
         szkxQ1UXj3Bvl//91tAgkXr5+R8AuijeYYspdQo6tWuA6yrreMtZsamL172W5KfPyWCv
         mFLM6PUvNRr4TTUsVbJ+FvTYorFOI1WrlBa6KqYG6mYBXtfgi2Z0JlzXCYXNKlDlzUVT
         4X2L/0CO+krlfZSyg4giOj7Q8ZQT6j4ozr6ZYUYqjgg7jtiAuAlxTbvtOuJmWq742iud
         WQdSmkCfL1qdj4rqE1tPsBHtxhQGTz4ybmCdY4Gy3C64Px0WWeqn3Lmp/aHSxOnlgrKB
         j7jQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=UMuN8z7M;
       spf=pass (google.com: domain of shreeya.patel23498@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=shreeya.patel23498@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=UMuN8z7M;
       spf=pass (google.com: domain of shreeya.patel23498@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=shreeya.patel23498@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELu+EstnAC3LvV4KPvFB54FqBEONZxEY1YCuEkAiQS/y8V9AmdDYddRUHjYB808JMNqY2KOq/Q==
Message-ID: <1520371619.4202.11.camel@gmail.com>
Subject: Re: [PATCH 03/11] Staging: iio: accel: Remove unnecessary comments
From: Shreeya Patel <shreeya.patel23498@gmail.com>
To: Himanshu Jha <himanshujha199640@gmail.com>, jic23@kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
	pmeerw@pmeerw.net, gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
	daniel.baluta@gmail.com
Date: Wed, 07 Mar 2018 02:56:59 +0530
In-Reply-To: <1520236170-14668-4-git-send-email-himanshujha199640@gmail.com>
References: <1520236170-14668-1-git-send-email-himanshujha199640@gmail.com>
	 <1520236170-14668-4-git-send-email-himanshujha199640@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594083197569075239?=
X-GMAIL-MSGID: =?utf-8?q?1594225199784725556?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 2018-03-05 at 13:19 +0530, Himanshu Jha wrote:
> Remove unnecessary comments since the definitions are pretty clear
> with their macro names.
> 
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
> ---
>  drivers/staging/iio/accel/adis16201.c | 82 +++++------------------
> ------------
>  1 file changed, 10 insertions(+), 72 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16201.c
> b/drivers/staging/iio/accel/adis16201.c
> index 0fae8aa..59c1166 100644
> --- a/drivers/staging/iio/accel/adis16201.c
> +++ b/drivers/staging/iio/accel/adis16201.c
> @@ -20,87 +20,42 @@
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/imu/adis.h>
>  
> -#define ADIS16201_STARTUP_DELAY	220 /* ms */
> +#define ADIS16201_STARTUP_DELAY		220
>  
> -/* Flash memory write count */
>  #define ADIS16201_FLASH_CNT      0x00
>  
> -/* Output, power supply */
> +/* Data Output Register Information */
>  #define ADIS16201_SUPPLY_OUT     0x02
> -
> -/* Output, x-axis accelerometer */
>  #define ADIS16201_XACCL_OUT      0x04
> -
> -/* Output, y-axis accelerometer */
>  #define ADIS16201_YACCL_OUT      0x06
> -
> -/* Output, auxiliary ADC input */
>  #define ADIS16201_AUX_ADC        0x08
> -
> -/* Output, temperature */
>  #define ADIS16201_TEMP_OUT       0x0A
> -
> -/* Output, x-axis inclination */
>  #define ADIS16201_XINCL_OUT      0x0C
> -
> -/* Output, y-axis inclination */
>  #define ADIS16201_YINCL_OUT      0x0E
>  
> -/* Calibration, x-axis acceleration offset */
> +/* Calibration Register Definition */
>  #define ADIS16201_XACCL_OFFS     0x10
> -
> -/* Calibration, y-axis acceleration offset */
>  #define ADIS16201_YACCL_OFFS     0x12
> -
> -/* x-axis acceleration scale factor */
>  #define ADIS16201_XACCL_SCALE    0x14
> -
> -/* y-axis acceleration scale factor */
>  #define ADIS16201_YACCL_SCALE    0x16
> -
> -/* Calibration, x-axis inclination offset */
>  #define ADIS16201_XINCL_OFFS     0x18
> -
> -/* Calibration, y-axis inclination offset */
>  #define ADIS16201_YINCL_OFFS     0x1A
> -
> -/* x-axis inclination scale factor */
>  #define ADIS16201_XINCL_SCALE    0x1C
> -
> -/* y-axis inclination scale factor */
>  #define ADIS16201_YINCL_SCALE    0x1E
>  
> -/* Alarm 1 amplitude threshold */
> +/* Alarm Register Definition */
>  #define ADIS16201_ALM_MAG1       0x20
> -
> -/* Alarm 2 amplitude threshold */
>  #define ADIS16201_ALM_MAG2       0x22
> -
> -/* Alarm 1, sample period */
>  #define ADIS16201_ALM_SMPL1      0x24
> -
> -/* Alarm 2, sample period */
>  #define ADIS16201_ALM_SMPL2      0x26
> -
> -/* Alarm control */
>  #define ADIS16201_ALM_CTRL       0x28
>  
> -/* Auxiliary DAC data */
>  #define ADIS16201_AUX_DAC        0x30
> -
> -/* General-purpose digital input/output control */
>  #define ADIS16201_GPIO_CTRL      0x32
> -
> -/* Miscellaneous control */
>  #define ADIS16201_MSC_CTRL       0x34
>  
> -/* Internal sample period (rate) control */
>  #define ADIS16201_SMPL_PRD       0x36
> -
> -/* Operation, filter configuration */
>  #define ADIS16201_AVG_CNT        0x38
> -
> -/* Operation, sleep mode control */
>  #define ADIS16201_SLP_CNT        0x3A
>  
>  /* Diagnostics, system status register */
> @@ -109,42 +64,28 @@
>  /* Operation, system command register */
>  #define ADIS16201_GLOB_CMD       0x3E
>  
> -/* MSC_CTRL */
>  
> -/* Self-test enable */
>  #define ADIS16201_MSC_CTRL_SELF_TEST_EN	        BIT(8)
>  
> -/* Data-ready enable: 1 = enabled, 0 = disabled */
>  #define ADIS16201_MSC_CTRL_DATA_RDY_EN	        BIT(2)
>  
> -/* Data-ready polarity: 1 = active high, 0 = active low */
>  #define ADIS16201_MSC_CTRL_ACTIVE_HIGH	        BIT(1)
>  
> -/* Data-ready line selection: 1 = DIO1, 0 = DIO0 */
>  #define ADIS16201_MSC_CTRL_DATA_RDY_DIO1	BIT(0)
>  
> -/* DIAG_STAT */
>  
> -/* Alarm 2 status: 1 = alarm active, 0 = alarm inactive */
>  #define ADIS16201_DIAG_STAT_ALARM2        BIT(9)
>  
> -/* Alarm 1 status: 1 = alarm active, 0 = alarm inactive */
>  #define ADIS16201_DIAG_STAT_ALARM1        BIT(8)
>  
> -/* SPI communications failure */
>  #define ADIS16201_DIAG_STAT_SPI_FAIL_BIT   3
>  
> -/* Flash update failure */
>  #define ADIS16201_DIAG_STAT_FLASH_UPT_BIT  2
>  
> -/* Power supply above 3.625 V */
>  #define ADIS16201_DIAG_STAT_POWER_HIGH_BIT 1
>  
> -/* Power supply below 3.15 V */
>  #define ADIS16201_DIAG_STAT_POWER_LOW_BIT  0
>  
> -/* GLOB_CMD */
> -
>  #define ADIS16201_GLOB_CMD_SW_RESET	BIT(7)
>  #define ADIS16201_GLOB_CMD_FACTORY_CAL	BIT(1)

I was just going through your patch for giving myself 
a habit of reading patches.

I see here that there are many comments which are necessary
have also been removed.
Jonathan told that some of the names do not explain
much about the how registers are related to the orientation.
So it is necessary for some comments to be there here.

I saw your next patch too, in which you are changing some of the
names for betterment, but again, that doesn't cover everything which
was told by Jonathan.

Here is the link to the patch where Jonathan had given detailed 
description

Just sharing this information so in case if Jonathan agrees with
this then he will not have to explain it all again :)

https://lkml.org/lkml/2018/3/3/104


Thanks,

Shreeya


>  
> @@ -187,30 +128,30 @@ static int adis16201_read_raw(struct iio_dev
> *indio_dev,
>  		case IIO_VOLTAGE:
>  			if (chan->channel == 0) {
>  				*val = 1;
> -				*val2 = 220000; /* 1.22 mV */
> +				*val2 = 220000;
>  			} else {
>  				*val = 0;
> -				*val2 = 610000; /* 0.610 mV */
> +				*val2 = 610000;
>  			}
>  			return IIO_VAL_INT_PLUS_MICRO;
>  		case IIO_TEMP:
> -			*val = -470; /* 0.47 C */
> +			*val = -470;
>  			*val2 = 0;
>  			return IIO_VAL_INT_PLUS_MICRO;
>  		case IIO_ACCEL:
>  			*val = 0;
> -			*val2 = IIO_G_TO_M_S_2(462400); /* 0.4624 mg
> */
> +			*val2 = IIO_G_TO_M_S_2(462400);
>  			return IIO_VAL_INT_PLUS_NANO;
>  		case IIO_INCLI:
>  			*val = 0;
> -			*val2 = 100000; /* 0.1 degree */
> +			*val2 = 100000;
>  			return IIO_VAL_INT_PLUS_MICRO;
>  		default:
>  			return -EINVAL;
>  		}
>  		break;
>  	case IIO_CHAN_INFO_OFFSET:
> -		*val = 25000 / -470 - 1278; /* 25 C = 1278 */
> +		*val = 25000 / -470 - 1278;
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_CALIBBIAS:
>  		switch (chan->type) {
> @@ -318,13 +259,11 @@ static int adis16201_probe(struct spi_device
> *spi)
>  	struct adis *st;
>  	struct iio_dev *indio_dev;
>  
> -	/* setup the industrialio driver allocated elements */
>  	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
>  	st = iio_priv(indio_dev);
> -	/* this is only used for removal purposes */
>  	spi_set_drvdata(spi, indio_dev);
>  
>  	indio_dev->name = spi->dev.driver->name;
> @@ -343,7 +282,6 @@ static int adis16201_probe(struct spi_device
> *spi)
>  	if (ret)
>  		return ret;
>  
> -	/* Get the device into a sane initial state */
>  	ret = adis_initial_startup(st);
>  	if (ret)
>  		goto error_cleanup_buffer_trigger;
