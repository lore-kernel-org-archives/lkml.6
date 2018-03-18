Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3527515-1521361955-2-13809087929365826670
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521361954; b=J76YwtQkaW1dTjKTK/VFNn8Y5mqp4DIq5HhnjdUgKwFVxgI
    G6Lz5DpTjNklShWg2Dg4svnYfHM7kj9z434TfduMtTeTBktvLEyaIYEGNNTwZjHr
    yXhlVAJBkiAY99hoPDaHJqSC23uK8Jf5pFX+EpETeKFsQAXMNwe96UgtxEbgVnN7
    qb6hrBbHjHyM711NieIx5cDFRtqzi7ajHnG7kw/dufexdaTQVZhWEsCcp5kGzATE
    D2g6KItVQcdJEFGhxy3msSm5v4Rk0RzXbT40SwzQB7NtoRVr3Pr/NNNvnLUAuKRZ
    qu3KFGRtiUV9vsg9EDCCBoIKrKCWnr8khFxss0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521361954; bh=G
    klxrLnY4Px01pQkOBOJpNBTF74EH97Hpu9NmyLijOc=; b=a+kTlSgtNeaLdwzxu
    l5pGFnqb8JklXlznIC1/y49uiYPqx0KF0nvN6Uqh5Vw511WtYRxGkBVFckXpvkM9
    J02KI5vsen4MY8NqeHuy1xnXy7ogAkJO/Zn5/WYvzr0zTYTljL49Juhw4OaNezDd
    xeLNPM6bGg3LWh2KAa3yAqQkrzkFbYqOn7d3FJ3QqcR2wcGOLMYe50qOndwOjitZ
    OKqu/JTBimYHrceFdXr0d2zpuzbAZHWYgtOJtg1nO5HxQCVwNGFyqc87KMhKROtk
    x1ZRzcc5T7o3n4EJIPkDTumNXg+TmDR//PVLbTL4eh+TqS820a4+VpQ4RHsxpk1R
    YcLQQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1300521720
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sun, 18 Mar 2018 08:32:21 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Himanshu Jha <himanshujha199640@gmail.com>
Subject: Re: [PATCH v2 5/9] Staging: iio: accel: adis16201: Add comments
 about units in read_raw()
Message-ID: <20180318083221.513c18c0@archlinux>
In-Reply-To: <1521230786-18155-6-git-send-email-himanshujha199640@gmail.com>
References: <1521230786-18155-1-git-send-email-himanshujha199640@gmail.com>
 <1521230786-18155-6-git-send-email-himanshujha199640@gmail.com>
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
 gregkh@linuxfoundation.org, 21cnbao@gmail.com, linux-kernel@vger.kernel.org,
 pmeerw@pmeerw.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, 17 Mar 2018 01:36:22 +0530
Himanshu Jha <himanshujha199640@gmail.com> wrote:

> Clarify the conversion and formation of resultant data in the
> adis16201_read_raw() with sufficient comments and remove the unnecessary
> comments.
> 
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
It is a little illogical to have comments for all but one of the channels, but
given we don't normally comment them unless they are 'odd', this is fine.

Applied, thanks

Jonathan

> ---
> v2:
>    -clarify voltage base conversions.
> 
>  drivers/staging/iio/accel/adis16201.c | 27 ++++++++++++++++++---------
>  1 file changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
> index 8de3f27..97150ea 100644
> --- a/drivers/staging/iio/accel/adis16201.c
> +++ b/drivers/staging/iio/accel/adis16201.c
> @@ -120,31 +120,43 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
>  		switch (chan->type) {
>  		case IIO_VOLTAGE:
>  			if (chan->channel == 0) {
> +			/* Voltage base units are mV hence 1.22 mV */
>  				*val = 1;
> -				*val2 = 220000; /* 1.22 mV */
> +				*val2 = 220000;
>  			} else {
> +			/* Voltage base units are mV hence 0.61 mV */
>  				*val = 0;
> -				*val2 = 610000; /* 0.610 mV */
> +				*val2 = 610000;
>  			}
>  			return IIO_VAL_INT_PLUS_MICRO;
>  		case IIO_TEMP:
> -			*val = -470; /* 0.47 C */
> +			*val = -470;
>  			*val2 = 0;
>  			return IIO_VAL_INT_PLUS_MICRO;
>  		case IIO_ACCEL:
> +			/*
> +			 * IIO base unit for sensitivity of accelerometer
> +			 * is milli g.
> +			 * 1 LSB represents 0.244 mg.
> +			 */
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
> +		/*
> +		 * The raw ADC value is 1278 when the temperature
> +		 * is 25 degrees and the scale factor per milli
> +		 * degree celcius is -470.
> +		 */
> +		*val = 25000 / -470 - 1278;
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_CALIBBIAS:
>  		switch (chan->type) {
> @@ -252,13 +264,11 @@ static int adis16201_probe(struct spi_device *spi)
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
> @@ -277,7 +287,6 @@ static int adis16201_probe(struct spi_device *spi)
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
