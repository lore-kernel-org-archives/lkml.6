Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3330179-1520693000-2-2206582887999171160
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES ro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520692999; b=Vb8TOo/XSdNCV7NRD+x6ytwxdop8b8f+uHcNcguuggkRci4
    c9GQvT/70/9T8i/C8n+WDNs5kRN92BTlKghZGmsXkGDLSbEVMmvRSM3WcIMFfQpA
    at87A2OxuL9KnV7v7MDUtLm2Ps61xe9lHH/9JzZAqNiRT7K6bABInV3Ex+RgZB72
    ieTMvo2w3QQX6ZUByEOgbvNwFxK2kNcaETOnW7oWwLMB7busggBWpTOU4kIi5Irq
    1Tu0OOp7bbZmBut86NTt4tN2OdlJ9wVQjJRrvoGUhGUBzrSpPegPDPxJtnf/KUlG
    i2zCVebrlnFgwNqManwo2wcHUbxXnnguElAylBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520692999; bh=V
    2PwptIodVYQAnFAcYet+D4Xz1yvVZvzlMrjd6dW2mo=; b=bat33dTLxVt/zikvl
    8RKdfuSG0hpNqdLn0y9hSwaGXhZ1xqbgznUg0P5XJihUP6UyogPV+xwahzrUOSC2
    9/dxbUN+yvJqKiZOKPkwVBX0yQZ4y+Eq3+dNRgsA9R4JKSI9SpkfAWMOuxxHU/0q
    7D9LBZPMJE3Gu8zyF7364jlTVAkOQQr/A3uHZ3yeCzgKA3ERbdVmxX6VGlKxKlE1
    cJnKEZNyKKm7/FSAOUrO5dfU+EThfdO1V+s62XTnOUeNAXgCxt9TQkASxOZQHrDE
    mLgEz27HoY1lhgq26GZPZycESnbMYMmuaE+DS1CbalS2N98aHpFihYM4s6OVOTGa
    6nMwg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
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
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C96452178C
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 10 Mar 2018 14:43:08 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Subject: Re: [PATCH 07/12] staging: iio: tsl2x7x: correct 'Avoid CamelCase'
 warning from checkpatch
Message-ID: <20180310144308.0f9ecadd@archlinux>
In-Reply-To: <20180304014942.18727-8-masneyb@onstation.org>
References: <20180304014942.18727-1-masneyb@onstation.org>
 <20180304014942.18727-8-masneyb@onstation.org>
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

On Sat,  3 Mar 2018 20:49:37 -0500
Brian Masney <masneyb@onstation.org> wrote:

> The statP and calP variables triggered an 'Avoid CamelCase' warning
> from checkpatch.pl. This patch renames these variables to stat and cal
> to fix this warning.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied.
> ---
>  drivers/staging/iio/light/tsl2x7x.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index cc209b64ed5a..380a6c96a69a 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -773,7 +773,7 @@ static int tsl2x7x_invoke_change(struct iio_dev *indio_dev)
>  }
>  
>  static void tsl2x7x_prox_calculate(int *data, int length,
> -				   struct tsl2x7x_prox_stat *statP)
> +				   struct tsl2x7x_prox_stat *stat)
>  {
>  	int i;
>  	int sample_sum;
> @@ -783,21 +783,21 @@ static void tsl2x7x_prox_calculate(int *data, int length,
>  		length = 1;
>  
>  	sample_sum = 0;
> -	statP->min = INT_MAX;
> -	statP->max = INT_MIN;
> +	stat->min = INT_MAX;
> +	stat->max = INT_MIN;
>  	for (i = 0; i < length; i++) {
>  		sample_sum += data[i];
> -		statP->min = min(statP->min, data[i]);
> -		statP->max = max(statP->max, data[i]);
> +		stat->min = min(stat->min, data[i]);
> +		stat->max = max(stat->max, data[i]);
>  	}
>  
> -	statP->mean = sample_sum / length;
> +	stat->mean = sample_sum / length;
>  	sample_sum = 0;
>  	for (i = 0; i < length; i++) {
> -		tmp = data[i] - statP->mean;
> +		tmp = data[i] - stat->mean;
>  		sample_sum += tmp * tmp;
>  	}
> -	statP->stddev = int_sqrt((long)sample_sum / length);
> +	stat->stddev = int_sqrt((long)sample_sum / length);
>  }
>  
>  /**
> @@ -812,7 +812,7 @@ static void tsl2x7x_prox_cal(struct iio_dev *indio_dev)
>  	int prox_history[MAX_SAMPLES_CAL + 1];
>  	int i;
>  	struct tsl2x7x_prox_stat prox_stat_data[2];
> -	struct tsl2x7x_prox_stat *calP;
> +	struct tsl2x7x_prox_stat *cal;
>  	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
>  	u8 tmp_irq_settings;
>  	u8 current_state = chip->tsl2x7x_chip_status;
> @@ -844,13 +844,13 @@ static void tsl2x7x_prox_cal(struct iio_dev *indio_dev)
>  	}
>  
>  	tsl2x7x_chip_off(indio_dev);
> -	calP = &prox_stat_data[PROX_STAT_CAL];
> +	cal = &prox_stat_data[PROX_STAT_CAL];
>  	tsl2x7x_prox_calculate(prox_history,
> -			       chip->settings.prox_max_samples_cal, calP);
> -	chip->settings.prox_thres_high = (calP->max << 1) - calP->mean;
> +			       chip->settings.prox_max_samples_cal, cal);
> +	chip->settings.prox_thres_high = (cal->max << 1) - cal->mean;
>  
>  	dev_info(&chip->client->dev, " cal min=%d mean=%d max=%d\n",
> -		 calP->min, calP->mean, calP->max);
> +		 cal->min, cal->mean, cal->max);
>  	dev_info(&chip->client->dev,
>  		 "%s proximity threshold set to %d\n",
>  		 chip->client->name, chip->settings.prox_thres_high);

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
