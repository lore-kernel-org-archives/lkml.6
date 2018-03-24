Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3936627-1521898890-2-5319767264838300484
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521898889; b=I50f1m/mv66HUXu/5Nr/d/V9q6JulMpvjyid3ZE7undglv7
    j/kJwyhyHslkm7O0SIzdQuiTRL0L9+2HG964p17fx9WijBrbKLjSoYE3PxSI8NdE
    RzAT05TiS0qOdSuWuJgYJjqGQyZenXb5D3tlH+U7HI98IfdC0Cp/gLbdAKbweu44
    fc+ZQkPNSZCIuH/NjqIlLCnmQWLjajhFlSkSI+qGY6HXZ9vNpG62F2X/+qNUYW8N
    S2J8OvqaDSX9Tjuwo72auZc83V/CzSp9d/aUhoFiN//xNRMVOv8XUL+jBGYZeyWp
    hgLHKxENteLsGV8ZMipDkrzEsGHrGcCKi+AUymw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521898889; bh=v
    R59ium4p83wek2aOvhqCvOAdTz6p4Uj6DTL2RxcuvY=; b=fp0OCLTs7rOo005r4
    cyDNK4MNltQCC+ZHArUtIuuamkenYr8TVCuPS5VyYrrMKL7/Bqrwua5LQr+NFV//
    LgvR8X+6JSWUPKeHxikXqH10sklYuJt+CSBbaO65hojvnlZBatOtNHjMRsAU1xNU
    TPvDn7+jCVAAiItzjNfMUDYWVuFVeZDbewzNrm7h4vTxJVoVXKoND/rt6RDFcEdO
    Pg6kPHM/3czv8V7OS9zYSwQLsik9NfXKf3Ds/I2UWwlWzfxz6HZrJh44LZs9g0y8
    Y8Ui1MeEsRwB0+AiAfjD023zzab2QLt07ySoir2JUGXmQrxLL1d6D4L96cbUiGVb
    FI4Ng==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FBA021772
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 24 Mar 2018 13:41:19 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Subject: Re: [PATCH 08/11] staging: iio: tsl2x7x: remove unused variables
 from tsl2x7x_get_lux()
Message-ID: <20180324134119.43c47d0f@archlinux>
In-Reply-To: <20180321102912.5130-9-masneyb@onstation.org>
References: <20180321102912.5130-1-masneyb@onstation.org>
 <20180321102912.5130-9-masneyb@onstation.org>
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
Cc: devel@driverdev.osuosl.org, lars@metafoo.de, linux-iio@vger.kernel.org,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, Jon.Brenner@ams.com,
 pmeerw@pmeerw.net, knaack.h@gmx.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 21 Mar 2018 06:29:09 -0400
Brian Masney <masneyb@onstation.org> wrote:

> tsl2x7x_get_lux() has a ch0lux and ch1lux variables that are not used
> so this patch removes them.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Had to argue with this one ;)

Applied,

Thanks,

Jonathan

> ---
>  drivers/staging/iio/light/tsl2x7x.c | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index c1e441857226..1e38e8449f9e 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -344,8 +344,6 @@ static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
>  	struct tsl2x7x_lux *p;
>  	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
>  	int i, ret;
> -	u32 ch0lux = 0;
> -	u32 ch1lux = 0;
>  
>  	mutex_lock(&chip->als_mutex);
>  
> @@ -416,15 +414,6 @@ static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
>  				   tsl2x7x_als_gain[chip->settings.als_gain]);
>  	}
>  
> -	/* note: lux is 31 bit max at this point */
> -	if (ch1lux > ch0lux) {
> -		dev_dbg(&chip->client->dev,
> -			"%s: ch1lux > ch0lux; returning last value\n",
> -			__func__);
> -		ret = chip->als_cur_info.lux;
> -		goto out_unlock;
> -	}
> -
>  	/* adjust for active time scale */
>  	if (chip->als_time_scale == 0)
>  		lux = 0;

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
