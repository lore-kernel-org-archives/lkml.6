Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4155223-1520454740-2-4505914583652195281
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
    t=1520454739; b=tCZPZaQ1WRCPS8XtNAQtxYyMuPW2hNwKI5+y5O8agVXgE89
    60sgsv+qndir9k4K46bs+MqGlwTgXVY1zBwx3/gJbkZvn0zVUgcZlUdpiwbUvffM
    u1KpR64/m6L73wEFK1nGJIjQaY2FDFT+SG8P7fpJItmq7PzoeX2Mf9aDnjWcLPw+
    /dXPar2wslMe8hnEOc1ydwPAlBDeG7OqLXhuwOjGfmf86IrDyAsP935wa1xiUybI
    PYPhqP2EklIV3qk3tdMKCvfRpEIngJr04PJ35mZYROlteqoNwimrH/KU1M0ppH9i
    /Kxne4iyz9Uq5Og1n2TmKkVW1adQTO/P9EcnUhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520454739; bh=B
    5n3dGDFxIGJKh0o8lscQ4EkpIiQJD9pIhZArDD4mXw=; b=GAbPzcWkH8D5JZaAb
    BxHE4hgfTkHQMQhysKX3P3fpAe1MkHaQGi/OzjsmZfey0mgqPlPOf+5JmXKDj8GV
    kp3M1zZjeXEg2wADDmPcPvUud75p2jcAiOEARghqFafCtw6fczKJwHHsCqNnzqLC
    IaflJamCcCKt0mh1ChiqvFLQ6UAFupIMvtqE00hi5KJvTbL+Vul7ALQ/uI6kTQ6+
    TRRYJn7fbYtNwWLe++hbf1LN+2zsgHbofdnKxwHpg/pwmV5JeRq/X7ng/7qdsTQF
    TO2H0ZoFBVDI7brYKqbGDr5VxEbv2Caa2hN48flriI3LpJU/bR+v5Os4VvNJbokx
    +5nhw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
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
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D429921770
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Wed, 7 Mar 2018 20:32:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Himanshu Jha <himanshujha199640@gmail.com>
Subject: Re: [PATCH 02/11] Staging: iio: accel: Add a blank space before
 returns
Message-ID: <20180307203206.1ba1ecf8@archlinux>
In-Reply-To: <1520236170-14668-3-git-send-email-himanshujha199640@gmail.com>
References: <1520236170-14668-1-git-send-email-himanshujha199640@gmail.com>
 <1520236170-14668-3-git-send-email-himanshujha199640@gmail.com>
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

On Mon,  5 Mar 2018 13:19:21 +0530
Himanshu Jha <himanshujha199640@gmail.com> wrote:

> Adding a blank space before/after some returns improves readability.
> 
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
Applied - patch title adjusted.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/accel/adis16201.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
> index 0f6a204..0fae8aa 100644
> --- a/drivers/staging/iio/accel/adis16201.c
> +++ b/drivers/staging/iio/accel/adis16201.c
> @@ -232,6 +232,7 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
>  		*val = val16;
>  		return IIO_VAL_INT;
>  	}
> +
>  	return -EINVAL;
>  }
>  
> @@ -262,6 +263,7 @@ static int adis16201_write_raw(struct iio_dev *indio_dev,
>  		addr = adis16201_addresses[chan->scan_index];
>  		return adis_write_reg_16(st, addr, val16);
>  	}
> +
>  	return -EINVAL;
>  }
>  
> @@ -336,6 +338,7 @@ static int adis16201_probe(struct spi_device *spi)
>  	ret = adis_init(st, indio_dev, spi, &adis16201_data);
>  	if (ret)
>  		return ret;
> +
>  	ret = adis_setup_buffer_and_trigger(st, indio_dev, NULL);
>  	if (ret)
>  		return ret;
> @@ -348,6 +351,7 @@ static int adis16201_probe(struct spi_device *spi)
>  	ret = iio_device_register(indio_dev);
>  	if (ret < 0)
>  		goto error_cleanup_buffer_trigger;
> +
>  	return 0;
>  
>  error_cleanup_buffer_trigger:

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
