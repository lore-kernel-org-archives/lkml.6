Return-Path: <jic23@kernel.org>
X-Google-Smtp-Source: AG47ELtE7/ICqx3BYuz63JBiySShYQXM+dgre58+YE1oKYs4yuPYgedk3wy84wIra+j/6kKepykN
ARC-Seal: i=1; a=rsa-sha256; t=1520453540; cv=none;
        d=google.com; s=arc-20160816;
        b=qjGdAeR4HDjCFWyDHQn6s7qChfkAI1F2rjSGj42/fDa0GldSY23PyO2gH9FS9jr9uw
         QpnzKnEcu87bppDyEngbdVp/5Xb4gybBKy3m4DPh8tuhPGfJ7e/MSTfD7mO4aZcBCMqS
         uboXCG8OXusP9Aa69tcJwSMkke/P6zZgyzyKeClXGuAgaMZjcv8cDgTefeFYaCA6FZdQ
         kryPQ6UUS6FQmxzPJYx5SwzRFO9n7tpzrFzbViUcyc6Oce76JTwp/gV91u+MT/g71m0u
         Ui252nCH9S/mrYJaOAXg2Zpsm/dT1zK8bbqOXOk9/yfEvX204eZaKS3NYRiFvxAf4vXJ
         u7Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=4kmmmBqI5uCAibJWB/M6LAoZ4p32VPwFbbUFr/8JrNE=;
        b=Y6m1uTdHmck7yeAevhsVr4Vz2kYRsNBcIF3rfhxJZkFAhwTjAO00i0dIEoc529hrb4
         8NAoBb0dlIGYEKEQzNyH5mydwy4A2TgbyRBhA7trHLfAMjRU659582Ftz+qcblG+obnc
         jpuRvNcfdBMp64fnYAWlRrRZcL2Ccjw6/BhZHiQqcrgybXRc30hl7U/WKHMsEra5kMSH
         0qsNERkbazB4IRlBWUgqOUwT4Zg1bTesUa6YzX9PwbuWqpEBqV/vHfa07VGgAkwQv52O
         cuE1vpLJi2o+EIEZpbL4ZdRarrL+z3wC4AJTsO7iN6Jarcs0Oz7ctXc8+MMvefvhaVVf
         vHyA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4622F20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Wed, 7 Mar 2018 20:12:15 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, daniel.baluta@nxp.com,
 linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] staging:iio:meter: Aligns open parenthesis
Message-ID: <20180307201215.1fe587d3@archlinux>
In-Reply-To: <e276c37521ce2520df734dff1a70663d2f4c0d9b.1520382753.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1520382753.git.rodrigosiqueiramelo@gmail.com>
	<e276c37521ce2520df734dff1a70663d2f4c0d9b.1520382753.git.rodrigosiqueiramelo@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594191167025917729?=
X-GMAIL-MSGID: =?utf-8?q?1594311091218929546?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 6 Mar 2018 21:44:26 -0300
Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:

> This patch fixes the checkpatch.pl checks:
> 
> staging/iio/meter/ade7854-spi.c:19: CHECK: Alignment should match open
> parenthesis
> staging/iio/meter/ade7854-spi.c:44: CHECK: Alignment should match open
> parenthesis
> staging/iio/meter/ade7854-spi.c:70: CHECK: Alignment should match open
> parenthesis
> staging/iio/meter/ade7854-spi.c:97: CHECK: Alignment should match open
> parenthesis
> staging/iio/meter/ade7854-spi.c:125: CHECK: Alignment should match open
> parenthesis
> 
> ...
> 
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/meter/ade7758_trigger.c |  6 ++---
>  drivers/staging/iio/meter/ade7854-spi.c     | 40 ++++++++++++++---------------
>  2 files changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7758_trigger.c b/drivers/staging/iio/meter/ade7758_trigger.c
> index 1f0d1a0cf889..3314aa298d99 100644
> --- a/drivers/staging/iio/meter/ade7758_trigger.c
> +++ b/drivers/staging/iio/meter/ade7758_trigger.c
> @@ -30,7 +30,7 @@ static irqreturn_t ade7758_data_rdy_trig_poll(int irq, void *private)
>   * ade7758_data_rdy_trigger_set_state() set datardy interrupt state
>   **/
>  static int ade7758_data_rdy_trigger_set_state(struct iio_trigger *trig,
> -						bool state)
> +					      bool state)
>  {
>  	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
>  
> @@ -63,8 +63,8 @@ int ade7758_probe_trigger(struct iio_dev *indio_dev)
>  	int ret;
>  
>  	st->trig = iio_trigger_alloc("%s-dev%d",
> -					spi_get_device_id(st->us)->name,
> -					indio_dev->id);
> +				     spi_get_device_id(st->us)->name,
> +				     indio_dev->id);
>  	if (!st->trig) {
>  		ret = -ENOMEM;
>  		goto error_ret;
> diff --git a/drivers/staging/iio/meter/ade7854-spi.c b/drivers/staging/iio/meter/ade7854-spi.c
> index 72eddfec21f7..4419b8f06197 100644
> --- a/drivers/staging/iio/meter/ade7854-spi.c
> +++ b/drivers/staging/iio/meter/ade7854-spi.c
> @@ -16,8 +16,8 @@
>  #include "ade7854.h"
>  
>  static int ade7854_spi_write_reg_8(struct device *dev,
> -		u16 reg_address,
> -		u8 val)
> +				   u16 reg_address,
> +				   u8 val)
>  {
>  	int ret;
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> @@ -41,8 +41,8 @@ static int ade7854_spi_write_reg_8(struct device *dev,
>  }
>  
>  static int ade7854_spi_write_reg_16(struct device *dev,
> -		u16 reg_address,
> -		u16 val)
> +				    u16 reg_address,
> +				    u16 val)
>  {
>  	int ret;
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> @@ -67,8 +67,8 @@ static int ade7854_spi_write_reg_16(struct device *dev,
>  }
>  
>  static int ade7854_spi_write_reg_24(struct device *dev,
> -		u16 reg_address,
> -		u32 val)
> +				    u16 reg_address,
> +				    u32 val)
>  {
>  	int ret;
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> @@ -94,8 +94,8 @@ static int ade7854_spi_write_reg_24(struct device *dev,
>  }
>  
>  static int ade7854_spi_write_reg_32(struct device *dev,
> -		u16 reg_address,
> -		u32 val)
> +				    u16 reg_address,
> +				    u32 val)
>  {
>  	int ret;
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> @@ -122,8 +122,8 @@ static int ade7854_spi_write_reg_32(struct device *dev,
>  }
>  
>  static int ade7854_spi_read_reg_8(struct device *dev,
> -		u16 reg_address,
> -		u8 *val)
> +				  u16 reg_address,
> +				  u8 *val)
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ade7854_state *st = iio_priv(indio_dev);
> @@ -149,7 +149,7 @@ static int ade7854_spi_read_reg_8(struct device *dev,
>  	ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
>  	if (ret) {
>  		dev_err(&st->spi->dev, "problem when reading 8 bit register 0x%02X",
> -				reg_address);
> +			reg_address);
>  		goto error_ret;
>  	}
>  	*val = st->rx[0];
> @@ -160,8 +160,8 @@ static int ade7854_spi_read_reg_8(struct device *dev,
>  }
>  
>  static int ade7854_spi_read_reg_16(struct device *dev,
> -		u16 reg_address,
> -		u16 *val)
> +				   u16 reg_address,
> +				   u16 *val)
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ade7854_state *st = iio_priv(indio_dev);
> @@ -186,7 +186,7 @@ static int ade7854_spi_read_reg_16(struct device *dev,
>  	ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
>  	if (ret) {
>  		dev_err(&st->spi->dev, "problem when reading 16 bit register 0x%02X",
> -				reg_address);
> +			reg_address);
>  		goto error_ret;
>  	}
>  	*val = be16_to_cpup((const __be16 *)st->rx);
> @@ -197,8 +197,8 @@ static int ade7854_spi_read_reg_16(struct device *dev,
>  }
>  
>  static int ade7854_spi_read_reg_24(struct device *dev,
> -		u16 reg_address,
> -		u32 *val)
> +				   u16 reg_address,
> +				   u32 *val)
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ade7854_state *st = iio_priv(indio_dev);
> @@ -224,7 +224,7 @@ static int ade7854_spi_read_reg_24(struct device *dev,
>  	ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
>  	if (ret) {
>  		dev_err(&st->spi->dev, "problem when reading 24 bit register 0x%02X",
> -				reg_address);
> +			reg_address);
>  		goto error_ret;
>  	}
>  	*val = (st->rx[0] << 16) | (st->rx[1] << 8) | st->rx[2];
> @@ -235,8 +235,8 @@ static int ade7854_spi_read_reg_24(struct device *dev,
>  }
>  
>  static int ade7854_spi_read_reg_32(struct device *dev,
> -		u16 reg_address,
> -		u32 *val)
> +				   u16 reg_address,
> +				   u32 *val)
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ade7854_state *st = iio_priv(indio_dev);
> @@ -262,7 +262,7 @@ static int ade7854_spi_read_reg_32(struct device *dev,
>  	ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
>  	if (ret) {
>  		dev_err(&st->spi->dev, "problem when reading 32 bit register 0x%02X",
> -				reg_address);
> +			reg_address);
>  		goto error_ret;
>  	}
>  	*val = be32_to_cpup((const __be32 *)st->rx);
