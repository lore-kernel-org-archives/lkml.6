Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3952077-1521899183-2-16726844262015253365
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
    t=1521899183; b=hiAOr4zIVH6F6YX73O5HvBp4w1M5HN2V0R+i1mRa+iECPvh
    GkMm0OLm7uko+ZBl9pnGhRdvTvLvnn/lqbnN1xKpw7CfIBONxj2WOyi2q2Tw4y6Z
    trv4iQDQ+I919bE83H7EPMv+krkwfiP4CnN/soB35GXJSv/aUebn91FRbrK0I5gY
    8tjmNMTC7zUzA3fs3Yhh6F2JXnc3uBnYH09XwfBDTldT7NfMiH9cuu4FLmlVtIQe
    pC5WH/31AnzwWUwVDoZ1RHZ42i9NqyUnONfR0338zM2fNrmFS6IrnVUE7EoGBMVv
    NNJT1t6CYKhHKtL9LgY3sUrzGES9v0oyjhv2P4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521899183; bh=6
    VgoqDNIWYC9emyvhKqvXZYtWHz85Wb7aSBm6mdG2WA=; b=O7gCPkqShuS//K4fp
    LKUyZMEKRGVl4ln6Zjd73bglQaSNVJJJvqQIF5DQm2UTVviSuM2Ybr3cERf/1x4R
    amsMMbWf5J+MZg+shmVc0utrv2coMotHHGqaGO0tNIy0btuBCpgC0sBNpGfUF7Iz
    8ZL1rstCsX7VI96kuMJHqJuHzAVMX5om9HOD1iPQFG0DvJ9lgZWBi7YnZIB+eEv3
    Xxqnp+9pQMsTTIXso/Em6McDwTLLL+rPrIcCKJe9ePEwwDmm+zEiLi5VcJ2nSd8w
    sfInMKiPyIiOLRuRkkvkaglnnkIZg/ms8Dl1HTNP0rxafpV1wJiIwtqPI2SQ22cX
    e2gxA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACA0C21772
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 24 Mar 2018 13:46:11 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Subject: Re: [PATCH 11/11] staging: iio: tsl2x7x: add copyright
Message-ID: <20180324134611.271b173f@archlinux>
In-Reply-To: <20180321102912.5130-12-masneyb@onstation.org>
References: <20180321102912.5130-1-masneyb@onstation.org>
 <20180321102912.5130-12-masneyb@onstation.org>
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

On Wed, 21 Mar 2018 06:29:12 -0400
Brian Masney <masneyb@onstation.org> wrote:

> Add Brian Masney's copyright and to the list of module authors for all
> of the staging cleanups. This patch also update's Jon Brenner's current
> work email address since AMS now owns TAOS.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied to the togreg branch of iio.git and pushed out as testing.
Likely these will be going upstream after the coming merge window.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/light/tsl2x7x.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index 5f78664d2b0e..77a81d75af4f 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -3,6 +3,7 @@
>   * and proximity detection (prox) within the TAOS TSL2X7X family of devices.
>   *
>   * Copyright (c) 2012, TAOS Corporation.
> + * Copyright (c) 2017-2018 Brian Masney <masneyb@onstation.org>
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License as published by
> @@ -1744,6 +1745,7 @@ static struct i2c_driver tsl2x7x_driver = {
>  
>  module_i2c_driver(tsl2x7x_driver);
>  
> -MODULE_AUTHOR("J. August Brenner<jbrenner@taosinc.com>");
> +MODULE_AUTHOR("J. August Brenner <Jon.Brenner@ams.com>");
> +MODULE_AUTHOR("Brian Masney <masneyb@onstation.org>");
>  MODULE_DESCRIPTION("TAOS tsl2x7x ambient and proximity light sensor driver");
>  MODULE_LICENSE("GPL");

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
