Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-384599-1520092928-2-10339797760731117083
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520092927; b=mtbMe5FfwCjLGkgyC1HcJ+KJbSuKG4iCddJ1KClvEB/5w4I
    uM/VDMpEjQwStxZVpr9SQBMDC5U+SNJrjN9cd/i8BnULx7OKdJ3SZfxeV+6mWrSZ
    g5mrypP948lwcM1oJKtaNVZDYJ2zlJK9j3eLDRkIM2m6yvm2Pgf4SgUiR3hkT++5
    lNcxvDNTJWzznO6Rg6N61TkjuW8pEyqstyrIkGgtvq6nlwhfMq1uxSDC7KIYb7bJ
    KgHLOvTCbCqhoBj6NUAzAgJokVXsnqPDbwL2TJrgZy/R4vZEL9SUSr4JT+UNGGH+
    eWWKfO3FpIXThimAAdaRIKiT4Zg3ZELNHddjQCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520092927; bh=J
    KfYqd28nKu+bazUk04+Cb3x1F0JM0HZd/naOYVWAjk=; b=S5yWJx0Nu4FOdmt1v
    Cj4RuYzWXWQlZCGfRfTr24N/HYDXLP56r6H1D7WZXo//ZhdCuOGszvmHKggSJouf
    9LHIOWmVIxz2lxEkCofMROxlQRnXL2zuecMBuAyVoAeyZzp9iFsaGomm6avcso2Q
    sXaFLAlnPTMhJgAVSc2bSP+TKhUnvpGOGAfOqdGvz/XwhtjznqV1MlSPe64oBiRO
    /uxA7FABt76q+gqdb9J/haaNvHB7iX5JThkcGJE2/HAggglUXxDLbC3dZ0TLGcmX
    M33qwDtLZRQ/jE2bHfLUOKtHb+DZMCnWoQwP8KDmX+kGTSBlSPONdfIulsQOVBL3
    GPg/A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8362C2133D
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 3 Mar 2018 16:01:55 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Shreeya Patel <shreeya.patel23498@gmail.com>
Subject: Re: [PATCH 5/6] Staging: iio: adis16209: Add some informatic comments
Message-ID: <20180303160155.67113206@archlinux>
In-Reply-To: <11a9db0dda77749c865e864c81924c0ec578dd86.1519995673.git.shreeya.patel23498@gmail.com>
References: <cover.1519995673.git.shreeya.patel23498@gmail.com>
 <11a9db0dda77749c865e864c81924c0ec578dd86.1519995673.git.shreeya.patel23498@gmail.com>
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

On Fri,  2 Mar 2018 19:02:48 +0530
Shreeya Patel <shreeya.patel23498@gmail.com> wrote:

> Some of the register names does not make it's puporse
> very clear and hence, add some comments for more
> information.
> Also there are certain unit based comments which are not
> providing sufficient information, so expand those comments.
Ah - serves me right for not reading on before commenting on the previous
patch.  It would have been preferable to have merged at least some of this
in there as they needed to be read together.

One comment in here doesn't quite cover everything I think should
be explained.

Please fix that and merge this down with the previous patch
(interactive rebase and marking it as a fixup makes this easy).

Thanks,

Jonathan

> 
> Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
> ---
>  drivers/staging/iio/accel/adis16209.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16209.c b/drivers/staging/iio/accel/adis16209.c
> index d2d1254..7363fd0 100644
> --- a/drivers/staging/iio/accel/adis16209.c
> +++ b/drivers/staging/iio/accel/adis16209.c
> @@ -27,13 +27,18 @@
>  #define ADIS16209_SUPPLY_OUT_REG	0x02
>  #define ADIS16209_XACCL_OUT_REG		0x04
>  #define ADIS16209_YACCL_OUT_REG		0x06
> +/* Output, auxiliary ADC */
>  #define ADIS16209_AUX_ADC_REG		0x08
> +/* Output, temperature */
>  #define ADIS16209_TEMP_OUT_REG		0x0A
> +/* Output, +/- 90 degrees X-axis inclination */
>  #define ADIS16209_XINCL_OUT_REG		0x0C
>  #define ADIS16209_YINCL_OUT_REG		0x0E
>  #define ADIS16209_ROT_OUT_REG		0x10
>  
> -/* Calibration Register Definitions */
> +/* Calibration Register Definitions.
> + * Acceleration, inclination or rotation offset null.
> + */
>  #define ADIS16209_XACCL_NULL_REG	0x12
>  #define ADIS16209_YACCL_NULL_REG	0x14
>  #define ADIS16209_XINCL_NULL_REG	0x16
> @@ -155,19 +160,29 @@ static int adis16209_read_raw(struct iio_dev *indio_dev,
>  			*val2 = 0;
>  			return IIO_VAL_INT_PLUS_MICRO;
>  		case IIO_ACCEL:
> +			/*
> +			 * IIO base unit for sensitivity of accelerometer
> +			 * is milligram.
> +			 * 1 LSB represents 0.244 milligrams.
Not miligrams. Milli g where 1 g is the 'standard' acceleration due to gravity.

> +			 */
>  			*val = 0;
> -			*val2 = IIO_G_TO_M_S_2(244140); /* 0.244140 mg */
> +			*val2 = IIO_G_TO_M_S_2(244140);
>  			return IIO_VAL_INT_PLUS_NANO;
>  		case IIO_INCLI:
>  		case IIO_ROT:
> +			/*
> +			 * IIO base units for rotation are degrees.
> +			 * 1 LSB represents 0.025 milli degrees.
> +			 */
>  			*val = 0;
> -			*val2 = 25000; /* 0.025 degree */
> +			*val2 = 25000;
>  			return IIO_VAL_INT_PLUS_MICRO;
>  		default:
>  			return -EINVAL;
>  		}
>  		break;
>  	case IIO_CHAN_INFO_OFFSET:
> +		/* TEMP_OUT_REG has a scale factor of -0.47 degrees celcius. */

This doesn't explain the magic 0x4FE so that needs doing as well.

>  		*val = 25000 / -470 - 0x4FE;
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_CALIBBIAS:

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
