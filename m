Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4047559-1521900972-2-11770028614866868161
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
    t=1521900972; b=dsHezZYzz8cAwdOWzGyIeB/PLVyzRJigmxq9Rg9I5znpW6d
    RPsIvD0+zz0Jj+2OEG/D8zrO2Qs6EmC5w1NRW2tttlnUgxmAGWeyAQc4bGOqR6U/
    GFTX1c6LG+A/xA2q5Tc0f0OKk1P4yOZrnSkaf826PbdQgzQjC7qGAx8Gw7yVFNK3
    /7ihbGabG91eREPCarleS6G5OIw2iJ9Y+YfmKSOf3eYYC5LrGeqrmb+Y3o1mZjtK
    fL2QO29WJEq9SiBAsu5heENp56fHT++ZcgAhORY2DQnKn3YLWaIW5RgQSlm98AaY
    No26w6Gb/cuJ+A5DEjiWhOEmXDxoNE+XcXBPNRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521900972; bh=6
    j74FBnO0ZON5VWDz1qR1Mz2b3ZLARE4J/1aT+9qx+w=; b=qoi8LJX1N0/QplUJJ
    gtr6CzzrghqS88Fp/ctKOX15bSr6pSlf8/JXCwOa9Pnb6kWHfZ0zhYi1fknWPxII
    6t3gXG/BxH7zbB8YyhK6VtNolDjqy8et0uXAIDtDs9RUCVDmOn2IuyyjOmS1iPPF
    DDJaob1KqeEYUj2oeVziZ2rpgnnB7Q+pbDmnbgaEyPgH61QdKebeLeXxWVZmOeQc
    oaeGJRafA3ZnAPHjEBniu10dZrkAUnbuTTX/jsuPIrxozlEIN1tNQTudREjAUEgW
    M35AycgPS+P5NiW0fp/zfrLmTwYrkgphJSdG9zGzoc/xpyFPv4Gdqqn5LU9Kr+7R
    CHhhw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80C1721770
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 24 Mar 2018 14:16:01 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Himanshu Jha <himanshujha199640@gmail.com>
Subject: Re: [PATCH 2/4] Staging: iio: accel: adis16201: Use GENMASK
Message-ID: <20180324141601.7faf0c8e@archlinux>
In-Reply-To: <1521745965-26972-2-git-send-email-himanshujha199640@gmail.com>
References: <1521230786-18155-10-git-send-email-himanshujha199640@gmail.com>
 <1521745965-26972-1-git-send-email-himanshujha199640@gmail.com>
 <1521745965-26972-2-git-send-email-himanshujha199640@gmail.com>
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
Cc: devel@driverdev.osuosl.org, lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, gregkh@linuxfoundation.org, 21cnbao@gmail.com,
 linux-kernel@vger.kernel.org, pmeerw@pmeerw.net, knaack.h@gmx.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 23 Mar 2018 00:42:43 +0530
Himanshu Jha <himanshujha199640@gmail.com> wrote:

> Use GENMASK to improve readability and remove the local variables used to
> store intermediate data.
> 
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
Applied to the togreg branch of iio.git.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/accel/adis16201.c | 34 +++++++++++++++-------------------
>  1 file changed, 15 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
> index b04dbb3..e7593fa 100644
> --- a/drivers/staging/iio/accel/adis16201.c
> +++ b/drivers/staging/iio/accel/adis16201.c
> @@ -185,28 +185,24 @@ static int adis16201_write_raw(struct iio_dev *indio_dev,
>  			       long mask)
>  {
>  	struct adis *st = iio_priv(indio_dev);
> -	int bits;
> -	s16 val16;
> -	u8 addr;
> +	int m;
>  
> -	switch (mask) {
> -	case IIO_CHAN_INFO_CALIBBIAS:
> -		switch (chan->type) {
> -		case IIO_ACCEL:
> -			bits = 12;
> -			break;
> -		case IIO_INCLI:
> -			bits = 9;
> -			break;
> -		default:
> -			return -EINVAL;
> +	if (mask != IIO_CHAN_INFO_CALIBBIAS)
> +		return -EINVAL;
> +
> +	switch (chan->type) {
> +	case IIO_ACCEL:
> +		m = GENMASK(11, 0);
> +		break;
> +	case IIO_INCLI:
> +		m = GENMASK(8, 0);
> +		break;
> +	default:
> +		return -EINVAL;
>  		}
> -		val16 = val & ((1 << bits) - 1);
> -		addr = adis16201_addresses[chan->scan_index];
> -		return adis_write_reg_16(st, addr, val16);
> -	}
>  
> -	return -EINVAL;
> +	return adis_write_reg_16(st, adis16201_addresses[chan->scan_index],
> +				 val & m);
>  }
>  
>  static const struct iio_chan_spec adis16201_channels[] = {

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
