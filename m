Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-384599-1520092686-2-5596824446789029013
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520092685; b=bCdGeJOFVA2d7IJ4KZKX9IEceYmaRnppL4o2QXwNeOPK8ps
    MHbDojhbVdcxeFG7A/nKPFVJwbmRXjpN3OwWw0+N/qDaqsP653vpStbx+lRlvP1F
    B+QMcMtCdZLQtBAVri+O/Ge9frb74CU8H29xngnKwcbxOHAPHS8BOSZvToLzICBe
    //lnnFAUafEI2ve8WFfgWPw6gxeLaTDL8FB/2Z76MwPRtynJn95LVtK4SdeUwSB4
    aI8Wk7mQybYrOzFKi7i4+5T65GDujzl7EwEegjiQSSpVZdIpm6SuRkSJdquD2p5L
    88mHvC78xTlh3LY8lcYdEYn+YikiI+4LHxGdaNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520092685; bh=s
    hBbaViZu/JQ82/kNtGUJYEpR/gQorK992BcMEX6kfo=; b=jD05hYV94tLkx72ZO
    r1iUmE5geeKEbFjyTBXA29eiy+LxdWFk4HcdmY8tspRCXks8rRfM42Gje2brnnEB
    XtnmnQDhET83vUA4eQU9ONi8wWXa5Sb/bVqXnwRYYcW3eVYQzzGNYfshao/d0Njd
    UX/WnvWU8uMybHrvfLO1qpWR1CzqiAFEu0K87yCqPWuBdhxV0AfH9K6/QPTWrLsF
    TL5PFPmFsqx/Ji03MCWE9ziv2D6ywL+x00be5A4qC+0UkV3UG+VAmZ8itaUKSS0b
    dqhQ0s0E0U1Z9kBAyH8NKZcoNThOAg8+92sKlgOETAjOOwxwagYAD38vbQSBynfA
    QW2qw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ED4A21783
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 3 Mar 2018 15:57:54 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Shreeya Patel <shreeya.patel23498@gmail.com>
Subject: Re: [PATCH 4/6] Staging: iio: adis16209: Remove unnecessary
 comments and group the definitions
Message-ID: <20180303155754.59b60970@archlinux>
In-Reply-To: <9e9bfe51f4ff1bc8555fe5c80d3c23ab7d5c6157.1519995673.git.shreeya.patel23498@gmail.com>
References: <cover.1519995673.git.shreeya.patel23498@gmail.com>
 <9e9bfe51f4ff1bc8555fe5c80d3c23ab7d5c6157.1519995673.git.shreeya.patel23498@gmail.com>
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

On Fri,  2 Mar 2018 18:58:55 +0530
Shreeya Patel <shreeya.patel23498@gmail.com> wrote:

> Remove some unnecessay comments and group the control
> register and register field macros together.
> 
> Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>

Hi Shreeya,

Nice patch.

As you have probably already seen comment removal (and addition) is always
open to debate.  I think a few of the removed comments are useful and should
remain or in one or two cases be expanded to become useful.

In other cases a slight tweak to the name of the define makes it self
explanatory.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/accel/adis16209.c | 116 ++++++----------------------------
>  1 file changed, 19 insertions(+), 97 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16209.c b/drivers/staging/iio/accel/adis16209.c
> index 151120f..d2d1254 100644
> --- a/drivers/staging/iio/accel/adis16209.c
> +++ b/drivers/staging/iio/accel/adis16209.c
> @@ -21,135 +21,60 @@
>  #include <linux/iio/imu/adis.h>
>  
>  #define ADIS16209_STARTUP_DELAY_MS	220
> -
> -/* Flash memory write count */
>  #define ADIS16209_FLASH_CNT_REG		0x00
>  
> -/* Output, power supply */
> +/* Data Output Register Definitions */
>  #define ADIS16209_SUPPLY_OUT_REG	0x02
> -
> -/* Output, x-axis accelerometer */
>  #define ADIS16209_XACCL_OUT_REG		0x04
> -
> -/* Output, y-axis accelerometer */
>  #define ADIS16209_YACCL_OUT_REG		0x06
> -
> -/* Output, auxiliary ADC input */
>  #define ADIS16209_AUX_ADC_REG		0x08
> -
> -/* Output, temperature */
>  #define ADIS16209_TEMP_OUT_REG		0x0A
> -
> -/* Output, x-axis inclination */
>  #define ADIS16209_XINCL_OUT_REG		0x0C
> -
> -/* Output, y-axis inclination */
>  #define ADIS16209_YINCL_OUT_REG		0x0E
> -
> -/* Output, +/-180 vertical rotational position */
>  #define ADIS16209_ROT_OUT_REG		0x10

This one is 'odd' enough I think it is worth keeping
some sort of description...

>  
> -/* Calibration, x-axis acceleration offset null */
> +/* Calibration Register Definitions */
>  #define ADIS16209_XACCL_NULL_REG	0x12
> -
> -/* Calibration, y-axis acceleration offset null */
>  #define ADIS16209_YACCL_NULL_REG	0x14
> -
> -/* Calibration, x-axis inclination offset null */
>  #define ADIS16209_XINCL_NULL_REG	0x16
> -
> -/* Calibration, y-axis inclination offset null */
>  #define ADIS16209_YINCL_NULL_REG	0x18
> -
> -/* Calibration, vertical rotation offset null */
>  #define ADIS16209_ROT_NULL_REG		0x1A
>  
> -/* Alarm 1 amplitude threshold */
> +/* Alarm Register Definitions */
>  #define ADIS16209_ALM_MAG1_REG		0x20
> -
> -/* Alarm 2 amplitude threshold */
>  #define ADIS16209_ALM_MAG2_REG		0x22
> -
> -/* Alarm 1, sample period */
>  #define ADIS16209_ALM_SMPL1_REG		0x24
> -
> -/* Alarm 2, sample period */
>  #define ADIS16209_ALM_SMPL2_REG		0x26
> -
> -/* Alarm control */
>  #define ADIS16209_ALM_CTRL_REG		0x28
>  
> -/* Auxiliary DAC data */
>  #define ADIS16209_AUX_DAC_REG		0x30
> -
> -/* General-purpose digital input/output control */
>  #define ADIS16209_GPIO_CTRL_REG		0x32
> -
> -/* Miscellaneous control */
> -#define ADIS16209_MSC_CTRL_REG		0x34
> -
> -/* Internal sample period (rate) control */
>  #define ADIS16209_SMPL_PRD_REG		0x36
> -
> -/* Operation, filter configuration */
>  #define ADIS16209_AVG_CNT_REG		0x38
> -
> -/* Operation, sleep mode control */
>  #define ADIS16209_SLP_CNT_REG		0x3A
>  
> -/* Diagnostics, system status register */
> -#define ADIS16209_DIAG_STAT_REG		0x3C
> -
> -/* Operation, system command register */
> -#define ADIS16209_GLOB_CMD_REG		0x3E
> -
> -/* MSC_CTRL */
> -
> -/* Self-test at power-on: 1 = disabled, 0 = enabled */
> -#define ADIS16209_MSC_CTRL_PWRUP_SELF_TEST	BIT(10)
> -
> -/* Self-test enable */
> -#define ADIS16209_MSC_CTRL_SELF_TEST_EN	        BIT(8)
> -
> -/* Data-ready enable: 1 = enabled, 0 = disabled */
> -#define ADIS16209_MSC_CTRL_DATA_RDY_EN	        BIT(2)
> -
> -/* Data-ready polarity: 1 = active high, 0 = active low */
> -#define ADIS16209_MSC_CTRL_ACTIVE_HIGH	        BIT(1)
> +#define ADIS16209_MSC_CTRL_REG			0x34
> +#define  ADIS16209_MSC_CTRL_PWRUP_SELF_TEST	BIT(10)
> +#define  ADIS16209_MSC_CTRL_SELF_TEST_EN	BIT(8)
> +#define  ADIS16209_MSC_CTRL_DATA_RDY_EN		BIT(2)
> +#define  ADIS16209_MSC_CTRL_ACTIVE_HIGH	BIT(1)
This one isn't named well enough to make it obvious what it
is controlling.  Either leave the comment or tweak the anme
to something like:

ADIS16209_MSC_CTRL_DATA_RDY_ACTIVE_HIGH

> +#define  ADIS16209_MSC_CTRL_DATA_RDY_DIO2	BIT(0)
>  
> -/* Data-ready line selection: 1 = DIO2, 0 = DIO1 */
> -#define ADIS16209_MSC_CTRL_DATA_RDY_DIO2	BIT(0)
> -
> -/* DIAG_STAT */
> -
> -/* Alarm 2 status: 1 = alarm active, 0 = alarm inactive */
> -#define ADIS16209_DIAG_STAT_ALARM2        BIT(9)
> -
> -/* Alarm 1 status: 1 = alarm active, 0 = alarm inactive */
> -#define ADIS16209_DIAG_STAT_ALARM1        BIT(8)
> -
> -/* Self-test diagnostic error flag: 1 = error condition, 0 = normal operation */
> +#define ADIS16209_DIAG_STAT_REG			0x3C
> +#define  ADIS16209_DIAG_STAT_ALARM2		BIT(9)
> +#define  ADIS16209_DIAG_STAT_ALARM1		BIT(8)
>  #define ADIS16209_DIAG_STAT_SELFTEST_FAIL_BIT	5
> -
> -/* SPI communications failure */
>  #define ADIS16209_DIAG_STAT_SPI_FAIL_BIT	3
> -
> -/* Flash update failure */
>  #define ADIS16209_DIAG_STAT_FLASH_UPT_BIT	2
Another question I had earlier was about this bit so I'll give
the same comment here.  It's really not well named (as was pointed
out to me!) as it reflects a failure and the name doesn't
imply this. 

There is also the curious point that the register is
called simply STATUS on the data sheet (not DIAG stat).

All this family have subtly different naming for somethings
(presumably it evolved over time) but that name is nicer
than the DIAG_STAT naming to my mind so perhaps worth a
change?

> -
> -/* Power supply above 3.625 V */
>  #define ADIS16209_DIAG_STAT_POWER_HIGH_BIT	1
This comment conveys meaning not expressed in the
name so I would keep it (same with the next one).

> -
> -/* Power supply below 3.15 V */
>  #define ADIS16209_DIAG_STAT_POWER_LOW_BIT	0
>  
> -/* GLOB_CMD */
> -
> -#define ADIS16209_GLOB_CMD_SW_RESET	BIT(7)
> -#define ADIS16209_GLOB_CMD_CLEAR_STAT	BIT(4)
> -#define ADIS16209_GLOB_CMD_FACTORY_CAL	BIT(1)
> +#define ADIS16209_GLOB_CMD_REG			0x3E
This one is interesting.  I have no idea where the naming
GLOB_CMD came from given it's COMMAND on the current data sheet.

Current naming is pretty clear though I guess so up to you
on whether you want to change it.

> +#define  ADIS16209_GLOB_CMD_SW_RESET		BIT(7)
> +#define  ADIS16209_GLOB_CMD_CLEAR_STAT		BIT(4)
> +#define  ADIS16209_GLOB_CMD_FACTORY_CAL		BIT(1)
>  
> -#define ADIS16209_ERROR_ACTIVE          BIT(14)
> +#define ADIS16209_ERROR_ACTIVE			BIT(14)
>  
>  enum adis16209_scan {
>  	ADIS16209_SCAN_SUPPLY,
> @@ -226,7 +151,7 @@ static int adis16209_read_raw(struct iio_dev *indio_dev,
>  				*val2 = 610500; /* 0.6105 mV */
>  			return IIO_VAL_INT_PLUS_MICRO;
>  		case IIO_TEMP:
> -			*val = -470; /* -0.47 C */
> +			*val = -470;
>  			*val2 = 0;
>  			return IIO_VAL_INT_PLUS_MICRO;
>  		case IIO_ACCEL:
> @@ -243,7 +168,7 @@ static int adis16209_read_raw(struct iio_dev *indio_dev,
>  		}
>  		break;
>  	case IIO_CHAN_INFO_OFFSET:
> -		*val = 25000 / -470 - 0x4FE; /* 25 C = 0x4FE */
> +		*val = 25000 / -470 - 0x4FE;
Whilst I don't like the existing comment, I do feel that some explanation
of the logic here would be useful.

Perhaps something like:

/*
 * The raw  ADC value is 0x4FE when the temperature is 45 degrees and
 * the scale factor per milli degree C is -470.
 */
 
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_CALIBBIAS:
>  		switch (chan->type) {
> @@ -320,12 +245,10 @@ static int adis16209_probe(struct spi_device *spi)
>  	struct adis *st;
>  	struct iio_dev *indio_dev;
>  
> -	/* setup the industrialio driver allocated elements */
>  	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
>  	if (!indio_dev)
>  		return -ENOMEM;
>  	st = iio_priv(indio_dev);
> -	/* this is only used for removal purposes */
>  	spi_set_drvdata(spi, indio_dev);
>  
>  	indio_dev->name = spi->dev.driver->name;
> @@ -342,7 +265,6 @@ static int adis16209_probe(struct spi_device *spi)
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
