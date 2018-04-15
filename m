Return-Path: <jic23@kernel.org>
X-Google-Smtp-Source: AIpwx48C4Qe04PEBdiE27LSXn/duU/kH9tP5e3LLwdoIedSChDW4wcmlUw4bilFce5537XFj2CDK
ARC-Seal: i=1; a=rsa-sha256; t=1523805183; cv=none;
        d=google.com; s=arc-20160816;
        b=amcm0ygzkyIdqBVtWjhJfotWq1s7yLqO88yXWVM9Mljxti+anaIKxlRQT6dJ49sT1o
         QraqEW9GGU5Oxk1CHU+I2ugVslidmvhb1dnz07lsScy24yq5p751BHRlSc0j/p9G0NCV
         UnrmM8ZdvsOy9Ux3jYVQ6MIGKUigz5QFegjneJKN8yJR6nfUlyfWTBavs0ZtKM5X/AxS
         JVLFBGUH0YZJl+dr8e9KX6i80oSV49QtLSGYbMAvOl2FSN3IOy3QQ3vt2Cj45FFWTDG0
         Tb3Jay0aHc34E6wlbdaV/kh7c9Q1475xZQHj06VceT6V4RvAGCTlYXmx8z5ECI7xlHRV
         HDkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=JV0gu+4qRVyPWR1gY0DHPIwOzZpids4sY6GgMhTI6Ck=;
        b=Eplw988on3k8/v9uwI1remKWLddR18b8zbJPqB/hMdlOVAgKZvxYKoFhx7yYtIaQ6+
         isk208eXlVP3AmCTTfpXrSleFR6QvSD8g4HJOetlt8UAn+DVSA35T9dEOdK/73GE1Gw0
         mwvYvsTjm/EaCpuj6dT7zPxAhowjtNFUhK8RGpjMGeElc0CLBZumd1/jmEizThCg2Fxm
         JDYJZBc6Ow+yagLvSvf7VJdSklU49h4QYcCozCKaTGtv1ENn2yq+qGnh7sQ7t3icueAP
         KviyNpLuYB6zGCBBkCsi0sjgQ0+ShP08jPuhMEBmnjKhWTsh95uGq1A6vHlw8p5TyqUa
         YCCA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13E55206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sun, 15 Apr 2018 16:12:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?SGVybsOhbg==?= Gonzalez <hernan@vanguardiasur.com.ar>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
 gregkh@linuxfoundation.org, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/14] staging: iio: ad7746: Remove unused defines
Message-ID: <20180415161257.77769dc8@archlinux>
In-Reply-To: <1523637411-8531-8-git-send-email-hernan@vanguardiasur.com.ar>
References: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
	<1523637411-8531-8-git-send-email-hernan@vanguardiasur.com.ar>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597649719888371800?=
X-GMAIL-MSGID: =?utf-8?q?1597825543545929110?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 13 Apr 2018 13:36:44 -0300
Hern=C3=A1n Gonzalez <hernan@vanguardiasur.com.ar> wrote:

> Signed-off-by: Hern=C3=A1n Gonzalez <hernan@vanguardiasur.com.ar>
> ---
>  drivers/staging/iio/cdc/ad7746.c | 7 -------
>  drivers/staging/iio/cdc/ad7746.h | 5 -----
>  2 files changed, 12 deletions(-)
>=20
> diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/a=
d7746.c
> index f53612a..d39ab34 100644
> --- a/drivers/staging/iio/cdc/ad7746.c
> +++ b/drivers/staging/iio/cdc/ad7746.c
> @@ -25,7 +25,6 @@
>   * AD7746 Register Definition
>   */
> =20
> -#define AD7746_REG_STATUS		0
>  #define AD7746_REG_CAP_DATA_HIGH	1
>  #define AD7746_REG_VT_DATA_HIGH		4
>  #define AD7746_REG_CAP_SETUP		7
> @@ -38,12 +37,6 @@
>  #define AD7746_REG_CAP_GAINH		15
>  #define AD7746_REG_VOLT_GAINH		17
> =20
> -/* Status Register Bit Designations (AD7746_REG_STATUS) */
> -#define AD7746_STATUS_EXCERR		BIT(3)
> -#define AD7746_STATUS_RDY		BIT(2)
> -#define AD7746_STATUS_RDYVT		BIT(1)
> -#define AD7746_STATUS_RDYCAP		BIT(0)
> -
There is a pretty strong argument that the driver 'should' be
checking the status register...

I would leave it the defines here.  When they are acting
as 'documentation' of the register layout of a device, they
do little harm and can be very useful.

>  /* Capacitive Channel Setup Register Bit Designations (AD7746_REG_CAP_SE=
TUP) */
>  #define AD7746_CAPSETUP_CAPEN		BIT(7)
>  #define AD7746_CAPSETUP_CIN2		BIT(6) /* AD7746 only */
> diff --git a/drivers/staging/iio/cdc/ad7746.h b/drivers/staging/iio/cdc/a=
d7746.h
> index ea8572d..2fbcee8 100644
> --- a/drivers/staging/iio/cdc/ad7746.h
> +++ b/drivers/staging/iio/cdc/ad7746.h
> @@ -13,11 +13,6 @@
>   * TODO: struct ad7746_platform_data needs to go into include/linux/iio
>   */
> =20
> -#define AD7466_EXCLVL_0		0 /* +-VDD/8 */
> -#define AD7466_EXCLVL_1		1 /* +-VDD/4 */
> -#define AD7466_EXCLVL_2		2 /* +-VDD * 3/8 */
> -#define AD7466_EXCLVL_3		3 /* +-VDD/2 */
> -

Think about what these are for.... They aren't unused
if you are actually using platform data on a given oard.

>  struct ad7746_platform_data {
>  	unsigned char exclvl;	/*Excitation Voltage Level */
>  	bool exca_en;		/* enables EXCA pin as the excitation output */
