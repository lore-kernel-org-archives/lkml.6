Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4156463-1520455242-2-13851287701195689088
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520455241; b=X20X14u76dD7E1gftCpVHVC7VcKA/Lv09Q23dohLNeyFJ3n
    +17IyLK6sRlUT80l8AVlEPm3rklIgQTMZZO+szGZtGuow+7MK0GP7af+s0tsg/p1
    Fp/RexipcaH0W2XtHuaUTBJSTU7riB00HSFz9n3h9gvEK9rVB1LJfjqDTnc4Trzs
    LKDoT+ll2coImkYaf6v9zxR0ZYQDgPqKdJAPY2d6zSYD4aJRI7QMtPwDbFGwio8j
    cfhnOnov+bwZskmGKUazhdJm8CIydGltBNHnPdgk9vz06S8I7rLzgTFO17FsI5ZQ
    C4ATv9fZLhhCHkO8L6ViTLTEb7hYNR7UrBE58kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520455241; bh=m
    oMf3Hm6YUMEy8BEehZqUinF/l8tTbeunMaAoPfZaFA=; b=HbyjPhctBKg0zNLB2
    tFMokrqV92BPN8PiC7Z/1Fw+cGZQLDj0MzyyoKuSfvZWFAEoy1QsWA7ojPOMGeQn
    te6IhSqpr/q4O0xQgRefzV/lf6t9H2Z/uAhuOMTEHoKwPprxg6DPIjLFsOUJeu1F
    EWqG3mP+WhoNu5LRE9D28b4Shi+M17okFio/G0lE2t3C23NM8h6SqnWb52MRPLww
    mqr4U4mnc4RTUf0sl/KUkke+rQc90P7dRkYqIE+ChgfR+7DpQpQNv1acxe0mxSpe
    kZ66og1DW3ry5noyMRgGEJx7KqaVMgJjo8hdnl6AmS7sPq8VzNbsPP8fEiF8ciCb
    cydQA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9BC12133D
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Wed, 7 Mar 2018 20:40:27 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Himanshu Jha <himanshujha199640@gmail.com>
Subject: Re: [PATCH 03/11] Staging: iio: accel: Remove unnecessary comments
Message-ID: <20180307204027.2c1a825e@archlinux>
In-Reply-To: <1520236170-14668-4-git-send-email-himanshujha199640@gmail.com>
References: <1520236170-14668-1-git-send-email-himanshujha199640@gmail.com>
 <1520236170-14668-4-git-send-email-himanshujha199640@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, daniel.baluta@gmail.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, pmeerw@pmeerw.net,
 knaack.h@gmx.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon,  5 Mar 2018 13:19:22 +0530
Himanshu Jha <himanshujha199640@gmail.com> wrote:

> Remove unnecessary comments since the definitions are pretty clear
> with their macro names.
> 
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>

Hi,

The art of commenting (and indeed removing comments) is never a clear one.
I agree with the vast majority of what you have here, but as with other
drivers in this set, I think there are a couple of places comments are useful
and even in one case where the comment should be expanded to become useful.

I'd also like to see the patches reordered so the renames occur before this
one.  That will make some of the changes you have made in here a lot more
obviously good!

Thanks,

Jonathan.
> ---
>  drivers/staging/iio/accel/adis16201.c | 82 +++++------------------------------
>  1 file changed, 10 insertions(+), 72 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
> index 0fae8aa..59c1166 100644
> --- a/drivers/staging/iio/accel/adis16201.c
> +++ b/drivers/staging/iio/accel/adis16201.c
> @@ -20,87 +20,42 @@
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/imu/adis.h>
>  
> -#define ADIS16201_STARTUP_DELAY	220 /* ms */
> +#define ADIS16201_STARTUP_DELAY		220
As below, this would have made a lot more sense if you had
the rename of the macro patch (I assume the unit will be added
to the name) before this one.

>  
> -/* Flash memory write count */
>  #define ADIS16201_FLASH_CNT      0x00
>  
> -/* Output, power supply */
> +/* Data Output Register Information */
>  #define ADIS16201_SUPPLY_OUT     0x02
> -
> -/* Output, x-axis accelerometer */
>  #define ADIS16201_XACCL_OUT      0x04
> -
> -/* Output, y-axis accelerometer */
>  #define ADIS16201_YACCL_OUT      0x06
> -
> -/* Output, auxiliary ADC input */
>  #define ADIS16201_AUX_ADC        0x08
> -
> -/* Output, temperature */
>  #define ADIS16201_TEMP_OUT       0x0A
> -
> -/* Output, x-axis inclination */
>  #define ADIS16201_XINCL_OUT      0x0C
> -
> -/* Output, y-axis inclination */
>  #define ADIS16201_YINCL_OUT      0x0E
>  
> -/* Calibration, x-axis acceleration offset */
> +/* Calibration Register Definition */
>  #define ADIS16201_XACCL_OFFS     0x10
> -
> -/* Calibration, y-axis acceleration offset */
>  #define ADIS16201_YACCL_OFFS     0x12
> -
> -/* x-axis acceleration scale factor */
>  #define ADIS16201_XACCL_SCALE    0x14
> -
> -/* y-axis acceleration scale factor */
>  #define ADIS16201_YACCL_SCALE    0x16
> -
> -/* Calibration, x-axis inclination offset */
>  #define ADIS16201_XINCL_OFFS     0x18
> -
> -/* Calibration, y-axis inclination offset */
>  #define ADIS16201_YINCL_OFFS     0x1A
> -
> -/* x-axis inclination scale factor */
>  #define ADIS16201_XINCL_SCALE    0x1C
> -
> -/* y-axis inclination scale factor */
>  #define ADIS16201_YINCL_SCALE    0x1E
>  
> -/* Alarm 1 amplitude threshold */
> +/* Alarm Register Definition */
>  #define ADIS16201_ALM_MAG1       0x20
> -
> -/* Alarm 2 amplitude threshold */
>  #define ADIS16201_ALM_MAG2       0x22
> -
> -/* Alarm 1, sample period */
>  #define ADIS16201_ALM_SMPL1      0x24
> -
> -/* Alarm 2, sample period */
>  #define ADIS16201_ALM_SMPL2      0x26
> -
> -/* Alarm control */
>  #define ADIS16201_ALM_CTRL       0x28
>  
> -/* Auxiliary DAC data */
>  #define ADIS16201_AUX_DAC        0x30
> -
> -/* General-purpose digital input/output control */
>  #define ADIS16201_GPIO_CTRL      0x32
> -
> -/* Miscellaneous control */
>  #define ADIS16201_MSC_CTRL       0x34
>  
> -/* Internal sample period (rate) control */
>  #define ADIS16201_SMPL_PRD       0x36
> -
> -/* Operation, filter configuration */
>  #define ADIS16201_AVG_CNT        0x38
> -
> -/* Operation, sleep mode control */
>  #define ADIS16201_SLP_CNT        0x3A
>  
>  /* Diagnostics, system status register */
> @@ -109,42 +64,28 @@
>  /* Operation, system command register */
>  #define ADIS16201_GLOB_CMD       0x3E
>  
> -/* MSC_CTRL */
>  
> -/* Self-test enable */
>  #define ADIS16201_MSC_CTRL_SELF_TEST_EN	        BIT(8)
>  
> -/* Data-ready enable: 1 = enabled, 0 = disabled */
>  #define ADIS16201_MSC_CTRL_DATA_RDY_EN	        BIT(2)
>  
> -/* Data-ready polarity: 1 = active high, 0 = active low */
>  #define ADIS16201_MSC_CTRL_ACTIVE_HIGH	        BIT(1)
>  
> -/* Data-ready line selection: 1 = DIO1, 0 = DIO0 */
>  #define ADIS16201_MSC_CTRL_DATA_RDY_DIO1	BIT(0)
>  
> -/* DIAG_STAT */
>  
> -/* Alarm 2 status: 1 = alarm active, 0 = alarm inactive */
>  #define ADIS16201_DIAG_STAT_ALARM2        BIT(9)
>  
> -/* Alarm 1 status: 1 = alarm active, 0 = alarm inactive */
>  #define ADIS16201_DIAG_STAT_ALARM1        BIT(8)
>  
> -/* SPI communications failure */
>  #define ADIS16201_DIAG_STAT_SPI_FAIL_BIT   3
>  
> -/* Flash update failure */
>  #define ADIS16201_DIAG_STAT_FLASH_UPT_BIT  2
I would have preferred this and the next patch to be
in the opposite order as then it would have been obvious when
reading this patch on why the comment here is no longer needed.

>  
> -/* Power supply above 3.625 V */
>  #define ADIS16201_DIAG_STAT_POWER_HIGH_BIT 1
>  
> -/* Power supply below 3.15 V */
>  #define ADIS16201_DIAG_STAT_POWER_LOW_BIT  0
These two comments are providing information that isn't
available from the naming so are useful and should stay.

>  
> -/* GLOB_CMD */
> -
>  #define ADIS16201_GLOB_CMD_SW_RESET	BIT(7)
>  #define ADIS16201_GLOB_CMD_FACTORY_CAL	BIT(1)
>  
> @@ -187,30 +128,30 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
>  		case IIO_VOLTAGE:
>  			if (chan->channel == 0) {
>  				*val = 1;
> -				*val2 = 220000; /* 1.22 mV */
> +				*val2 = 220000;
>  			} else {
>  				*val = 0;
> -				*val2 = 610000; /* 0.610 mV */
> +				*val2 = 610000;
>  			}
>  			return IIO_VAL_INT_PLUS_MICRO;
>  		case IIO_TEMP:
> -			*val = -470; /* 0.47 C */
> +			*val = -470;
The interesting point here is that the original comment
was actually wrong. It is clearly -0.47!

>  			*val2 = 0;
>  			return IIO_VAL_INT_PLUS_MICRO;
>  		case IIO_ACCEL:
>  			*val = 0;
> -			*val2 = IIO_G_TO_M_S_2(462400); /* 0.4624 mg */
> +			*val2 = IIO_G_TO_M_S_2(462400);
>  			return IIO_VAL_INT_PLUS_NANO;
>  		case IIO_INCLI:
>  			*val = 0;
> -			*val2 = 100000; /* 0.1 degree */
> +			*val2 = 100000;
>  			return IIO_VAL_INT_PLUS_MICRO;
>  		default:
>  			return -EINVAL;
>  		}
>  		break;
>  	case IIO_CHAN_INFO_OFFSET:
> -		*val = 25000 / -470 - 1278; /* 25 C = 1278 */
> +		*val = 25000 / -470 - 1278;
The original comment wasn't great but we probably would benefit from some
information here.  Something like:

/*
 * When temperature is 25 C sensor raw reading is 1278.
 * The scale is -470 milli degree C per LSB.
 */

Hopefully that would let people know where the maths comes
from (please check I got it right!)

>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_CALIBBIAS:
>  		switch (chan->type) {
> @@ -318,13 +259,11 @@ static int adis16201_probe(struct spi_device *spi)
>  	struct adis *st;
>  	struct iio_dev *indio_dev;
>  
> -	/* setup the industrialio driver allocated elements */
>  	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
>  	st = iio_priv(indio_dev);
> -	/* this is only used for removal purposes */
>  	spi_set_drvdata(spi, indio_dev);
>  
>  	indio_dev->name = spi->dev.driver->name;
> @@ -343,7 +282,6 @@ static int adis16201_probe(struct spi_device *spi)
>  	if (ret)
>  		return ret;
>  
> -	/* Get the device into a sane initial state */
>  	ret = adis_initial_startup(st);
>  	if (ret)
>  		goto error_cleanup_buffer_trigger;

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
