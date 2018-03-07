Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-32406-1520456335-2-4707910412952047480
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520456333; b=D4shSnKWsK6FPGpHPi7whKi6tQK88pt9kJHubNZsmSeT5pu
    jEHCC8/Qool+9ndKVIp0Hr0rDrDtbGkAnFO3H6FUrFy4XCwVJqs0kGev+KJrGWx0
    DmTGFp82+9iyG95E25cvj5CPWRpZLMXejyMEW2LXDpO+/gSuFmxqksc94c1wi8jE
    sYnKK6x+VSzHZ9abIv+6T1P0hH+Gc8NIjTOFpwVugezqjNiLaJt1ZvqxXQhbvACm
    fdEBmpboZrYwL3FEfuJqBhSzZLWxS6UUXvw+zrmGpHNwRuvdt1qzMyod0b93tabo
    XUGUDQ/m5e1Pix/RVPbBHqSiqn/m2u8VUS2xgrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520456333; bh=N
    hp2iZ+8Jm+qJ8ybmrD9DhHOnyflm2mAmu17Du/lv18=; b=nK0fTXMhJUWx8FaD/
    VqWzjM0N4Y5ZRTxZfMRHLgfXV5/9En41D/QXQxweRYLIiie6fIznt4Jf+mBzOyLP
    kiyW0zIKMdcLQIGGI7m5Yn1QleelvUByhPVMKK9rzqddrBTKQw9hCpEIO2/7Fgy3
    QY8dLWF3wZ8LKUUcxUXU2Tn4UmMzdUfWstFbJ7vByYa1qaMe3epCtc7mqW4BXab+
    LvcqGgPqizhxc7oXWYUu23xh+0Db6d3HmsYqleK3u7J4xIDuQch9QBxHUv8KGiIp
    cSvyQq8sCxaZpeW0RF+Qv2lBkEPRmUby+CP27YMAnOhCqu7qaM8fcF6PoxUTx5zR
    lTSZA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D9BC20685
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Wed, 7 Mar 2018 20:58:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Himanshu Jha <himanshujha199640@gmail.com>
Subject: Re: [PATCH 11/11] Staging: iio: accel: Move adis16201 driver out of
 staging subsystem
Message-ID: <20180307205838.18603e5e@archlinux>
In-Reply-To: <1520236170-14668-12-git-send-email-himanshujha199640@gmail.com>
References: <1520236170-14668-1-git-send-email-himanshujha199640@gmail.com>
 <1520236170-14668-12-git-send-email-himanshujha199640@gmail.com>
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

On Mon,  5 Mar 2018 13:19:30 +0530
Himanshu Jha <himanshujha199640@gmail.com> wrote:

> Move the adis16201 driver out of staging directory and merge to the
> mainline IIO subsystem.
> 
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
One comment inline (that I should have noticed in one of your earlier patches but
missed).

Michael, do you have the time to look through these at the moment?

The changes are not likely to break anything so if you are too busy I'm happy to
move them out of staging if you are fine with that.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/Kconfig             |  12 ++
>  drivers/iio/accel/Makefile            |   1 +
>  drivers/iio/accel/adis16201.c         | 323 ++++++++++++++++++++++++++++++++++
>  drivers/staging/iio/accel/Kconfig     |  12 --
>  drivers/staging/iio/accel/Makefile    |   1 -
>  drivers/staging/iio/accel/adis16201.c | 323 ----------------------------------
>  6 files changed, 336 insertions(+), 336 deletions(-)
>  create mode 100644 drivers/iio/accel/adis16201.c
>  delete mode 100644 drivers/staging/iio/accel/adis16201.c
> 
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index c6d9517..9416c6f 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -5,6 +5,18 @@
>  
>  menu "Accelerometers"
>  
> +config ADIS16201
> +        tristate "Analog Devices ADIS16201 Dual-Axis Digital Inclinometer and Accelerometer"
> +        depends on SPI
> +        select IIO_ADIS_LIB
> +        select IIO_ADIS_LIB_BUFFER if IIO_BUFFER
> +        help
> +          Say Y here to build support for Analog Devices adis16201 dual-axis
> +          digital inclinometer and accelerometer.
> +
> +          To compile this driver as a module, say M here: the module will
> +          be called adis16201.
> +
>  config ADXL345
>  	tristate
>  
> diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
> index 368aedb..7832ec9 100644
> --- a/drivers/iio/accel/Makefile
> +++ b/drivers/iio/accel/Makefile
> @@ -4,6 +4,7 @@
>  #
>  
>  # When adding new entries keep the list in alphabetical order
> +obj-$(CONFIG_ADIS16201) += adis16201.o
>  obj-$(CONFIG_ADXL345) += adxl345_core.o
>  obj-$(CONFIG_ADXL345_I2C) += adxl345_i2c.o
>  obj-$(CONFIG_ADXL345_SPI) += adxl345_spi.o
> diff --git a/drivers/iio/accel/adis16201.c b/drivers/iio/accel/adis16201.c
> new file mode 100644
> index 0000000..946c7b1
> --- /dev/null
> +++ b/drivers/iio/accel/adis16201.c
> @@ -0,0 +1,323 @@
> +/*
> + * ADIS16201 Dual-Axis Digital Inclinometer and Accelerometer
> + *
> + * Copyright 2010 Analog Devices Inc.
> + *
> + * Licensed under the GPL-2 or later.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/slab.h>
> +#include <linux/spi/spi.h>
> +#include <linux/sysfs.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/imu/adis.h>
> +
> +#define ADIS16201_STARTUP_DELAY_MS				220
> +#define ADIS16201_FLASH_CNT					0x00
> +
> +/* Data Output Register Information */
> +#define ADIS16201_SUPPLY_OUT_REG				0x02
> +#define ADIS16201_XACCL_OUT_REG					0x04
> +#define ADIS16201_YACCL_OUT_REG					0x06
> +#define ADIS16201_AUX_ADC_REG					0x08
> +#define ADIS16201_TEMP_OUT_REG					0x0A
> +#define ADIS16201_XINCL_OUT_REG					0x0C
> +#define ADIS16201_YINCL_OUT_REG					0x0E
> +
> +/* Calibration Register Definition */
> +#define ADIS16201_XACCL_OFFS_REG				0x10
> +#define ADIS16201_YACCL_OFFS_REG				0x12
> +#define ADIS16201_XACCL_SCALE_REG				0x14
> +#define ADIS16201_YACCL_SCALE_REG				0x16
> +#define ADIS16201_XINCL_OFFS_REG				0x18
> +#define ADIS16201_YINCL_OFFS_REG				0x1A
> +#define ADIS16201_XINCL_SCALE_REG				0x1C
> +#define ADIS16201_YINCL_SCALE_REG				0x1E
> +
> +/* Alarm Register Definition */
> +#define ADIS16201_ALM_MAG1_REG					0x20
> +#define ADIS16201_ALM_MAG2_REG					0x22
> +#define ADIS16201_ALM_SMPL1_REG					0x24
> +#define ADIS16201_ALM_SMPL2_REG					0x26
> +#define ADIS16201_ALM_CTRL_REG					0x28
> +
> +#define ADIS16201_AUX_DAC_REG					0x30
> +#define ADIS16201_GPIO_CTRL_REG					0x32
> +#define ADIS16201_MSC_CTRL_REG					0x34
> +#define ADIS16201_SMPL_PRD_REG					0x36
> +#define ADIS16201_AVG_CNT_REG					0x38
> +#define ADIS16201_SLP_CNT_REG					0x3A
> +
> +/* Miscellaneous Control Register Definition */
> +#define ADIS16201_MSC_CTRL_REG					0x34
> +#define  ADIS16201_MSC_CTRL_SELF_TEST_EN			BIT(8)
> +#define  ADIS16201_MSC_CTRL_DATA_RDY_EN				BIT(2)
> +#define  ADIS16201_MSC_CTRL_ACTIVE_DATA_RDY_HIGH		BIT(1)
> +#define  ADIS16201_MSC_CTRL_DATA_RDY_DIO1			BIT(0)
> +
> +/* Diagnostics, system status register */
> +#define ADIS16201_DIAG_STAT_REG					0x3C
> +#define  ADIS16201_DIAG_STAT_ALARM2				BIT(9)
> +#define  ADIS16201_DIAG_STAT_ALARM1				BIT(8)
> +#define  ADIS16201_DIAG_STAT_SPI_FAIL_BIT			3
> +#define  ADIS16201_DIAG_STAT_FLASH_UPT_FAIL_BIT			2
> +#define  ADIS16201_DIAG_STAT_POWER_HIGH_BIT			1
> +#define  ADIS16201_DIAG_STAT_POWER_LOW_BIT			0
> +
> +/* Operation, system command register */
> +#define ADIS16201_GLOB_CMD_REG					0x3E
> +#define  ADIS16201_GLOB_CMD_SW_RESET				BIT(7)
> +#define  ADIS16201_GLOB_CMD_FACTORY				BIT(1)
> +
> +#define ADIS16201_ERROR_ACTIVE					BIT(14)
> +
> +enum adis16201_scan {
> +	ADIS16201_SCAN_ACC_X,
> +	ADIS16201_SCAN_ACC_Y,
> +	ADIS16201_SCAN_INCLI_X,
> +	ADIS16201_SCAN_INCLI_Y,
> +	ADIS16201_SCAN_SUPPLY,
> +	ADIS16201_SCAN_AUX_ADC,
> +	ADIS16201_SCAN_TEMP,
> +};
> +
> +static const u8 adis16201_addresses[] = {
> +	[ADIS16201_SCAN_ACC_X] = ADIS16201_XACCL_OFFS_REG,
> +	[ADIS16201_SCAN_ACC_Y] = ADIS16201_YACCL_OFFS_REG,
> +	[ADIS16201_SCAN_INCLI_X] = ADIS16201_XINCL_OFFS_REG,
> +	[ADIS16201_SCAN_INCLI_Y] = ADIS16201_YINCL_OFFS_REG,
> +};
> +
> +static int adis16201_read_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      int *val, int *val2,
> +			      long mask)
> +{
> +	struct adis *st = iio_priv(indio_dev);
> +	int ret;
> +	int bits;
> +	u8 addr;
> +	s16 val16;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		return adis_single_conversion(indio_dev, chan,
> +						ADIS16201_ERROR_ACTIVE, val);
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			switch (chan->channel) {
> +			case 0:
> +				*val = 1;
> +				*val2 = 220000;
> +				break;
> +			case 1:
> +				*val = 0;
> +				*val2 = 610000;
> +				break;
> +			}
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		case IIO_TEMP:
> +			*val = -470;
> +			*val2 = 0;
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		case IIO_ACCEL:
> +		       /*
> +			* IIO base unit for sensitivity of accelerometer
> +			* is milli g.
> +			* 1 LSB represents 0.244 mg.
> +			*/
> +			*val = 0;
> +			*val2 = IIO_G_TO_M_S_2(462400);
> +			return IIO_VAL_INT_PLUS_NANO;
> +		case IIO_INCLI:
> +			*val = 0;
> +			*val2 = 100000;
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		default:
> +			return -EINVAL;
> +		}
> +		break;
> +	case IIO_CHAN_INFO_OFFSET:
> +	       /*
> +		* The raw ADC value is 0x4FE when the temperature
Ah, I missed this earlier.  Why have it in hex here in the comment
and decimal in the maths.  Make them the same (either way round
is fine)

> +		* is 25 degrees and the scale factor per milli
> +		* degree celcius is -470.
> +		*/
> +		*val = 25000 / -470 - 1278;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		switch (chan->type) {
> +		case IIO_ACCEL:
> +			bits = 12;
> +			break;
> +		case IIO_INCLI:
> +			bits = 9;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		addr = adis16201_addresses[chan->scan_index];
> +		ret = adis_read_reg_16(st, addr, &val16);
> +		if (ret)
> +			return ret;
> +
> +		*val = sign_extend32(val16, bits - 1);
> +		return IIO_VAL_INT;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int adis16201_write_raw(struct iio_dev *indio_dev,
> +			       struct iio_chan_spec const *chan,
> +			       int val,
> +			       int val2,
> +			       long mask)
> +{
> +	struct adis *st = iio_priv(indio_dev);
> +	int bits;
> +	s16 val16;
> +	u8 addr;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		switch (chan->type) {
> +		case IIO_ACCEL:
> +			bits = 12;
> +			break;
> +		case IIO_INCLI:
> +			bits = 9;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		val16 = val & ((1 << bits) - 1);
> +		addr = adis16201_addresses[chan->scan_index];
> +		return adis_write_reg_16(st, addr, val16);
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static const struct iio_chan_spec adis16201_channels[] = {
> +	ADIS_SUPPLY_CHAN(ADIS16201_SUPPLY_OUT_REG, ADIS16201_SCAN_SUPPLY, 0, 12),
> +	ADIS_TEMP_CHAN(ADIS16201_TEMP_OUT_REG, ADIS16201_SCAN_TEMP, 0, 12),
> +	ADIS_ACCEL_CHAN(X, ADIS16201_XACCL_OUT_REG, ADIS16201_SCAN_ACC_X,
> +			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
> +	ADIS_ACCEL_CHAN(Y, ADIS16201_YACCL_OUT_REG, ADIS16201_SCAN_ACC_Y,
> +			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
> +	ADIS_AUX_ADC_CHAN(ADIS16201_AUX_ADC_REG, ADIS16201_SCAN_AUX_ADC, 0, 12),
> +	ADIS_INCLI_CHAN(X, ADIS16201_XINCL_OUT_REG, ADIS16201_SCAN_INCLI_X,
> +			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
> +	ADIS_INCLI_CHAN(X, ADIS16201_YINCL_OUT_REG, ADIS16201_SCAN_INCLI_Y,
> +			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
> +	IIO_CHAN_SOFT_TIMESTAMP(7)
> +};
> +
> +static const struct iio_info adis16201_info = {
> +	.read_raw = adis16201_read_raw,
> +	.write_raw = adis16201_write_raw,
> +	.update_scan_mode = adis_update_scan_mode,
> +};
> +
> +static const char * const adis16201_status_error_msgs[] = {
> +	[ADIS16201_DIAG_STAT_SPI_FAIL_BIT] = "SPI failure",
> +	[ADIS16201_DIAG_STAT_FLASH_UPT_FAIL_BIT] = "Flash update failed",
> +	[ADIS16201_DIAG_STAT_POWER_HIGH_BIT] = "Power supply above 3.625V",
> +	[ADIS16201_DIAG_STAT_POWER_LOW_BIT] = "Power supply below 3.15V",
> +};
> +
> +static const struct adis_data adis16201_data = {
> +	.read_delay = 20,
> +	.msc_ctrl_reg = ADIS16201_MSC_CTRL_REG,
> +	.glob_cmd_reg = ADIS16201_GLOB_CMD_REG,
> +	.diag_stat_reg = ADIS16201_DIAG_STAT_REG,
> +
> +	.self_test_mask = ADIS16201_MSC_CTRL_SELF_TEST_EN,
> +	.self_test_no_autoclear = true,
> +	.startup_delay = ADIS16201_STARTUP_DELAY_MS,
> +
> +	.status_error_msgs = adis16201_status_error_msgs,
> +	.status_error_mask = BIT(ADIS16201_DIAG_STAT_SPI_FAIL_BIT) |
> +		BIT(ADIS16201_DIAG_STAT_FLASH_UPT_FAIL_BIT) |
> +		BIT(ADIS16201_DIAG_STAT_POWER_HIGH_BIT) |
> +		BIT(ADIS16201_DIAG_STAT_POWER_LOW_BIT),
> +};
> +
> +static int adis16201_probe(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev;
> +	struct adis *st;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	spi_set_drvdata(spi, indio_dev);
> +
> +	indio_dev->name = spi->dev.driver->name;
> +	indio_dev->dev.parent = &spi->dev;
> +	indio_dev->info = &adis16201_info;
> +
> +	indio_dev->channels = adis16201_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(adis16201_channels);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = adis_init(st, indio_dev, spi, &adis16201_data);
> +	if (ret)
> +		return ret;
> +
> +	ret = adis_setup_buffer_and_trigger(st, indio_dev, NULL);
> +	if (ret)
> +		return ret;
> +
> +	ret = adis_initial_startup(st);
> +	if (ret)
> +		goto error_cleanup_buffer_trigger;
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret < 0)
> +		goto error_cleanup_buffer_trigger;
> +
> +	return 0;
> +
> +error_cleanup_buffer_trigger:
> +	adis_cleanup_buffer_and_trigger(st, indio_dev);
> +	return ret;
> +}
> +
> +static int adis16201_remove(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> +	struct adis *st = iio_priv(indio_dev);
> +
> +	iio_device_unregister(indio_dev);
> +	adis_cleanup_buffer_and_trigger(st, indio_dev);
> +
> +	return 0;
> +}
> +
> +static struct spi_driver adis16201_driver = {
> +	.driver = {
> +		.name = "adis16201",
> +	},
> +	.probe = adis16201_probe,
> +	.remove = adis16201_remove,
> +};
> +module_spi_driver(adis16201_driver);
> +
> +MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
> +MODULE_DESCRIPTION("Analog Devices ADIS16201 Dual-Axis Digital Inclinometer and Accelerometer");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("spi:adis16201");
<snip>
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
