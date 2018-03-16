Return-Path: <leechu729@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-3555996-1521222424-2-7474018272366737969
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_ENVFROM_END_DIGIT 0.25, FREEMAIL_FROM 0.001,
  RCVD_IN_DNSWL_NONE -0.0001, RCVD_IN_MSPIKE_H3 -0.01,
  RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.85.216.196', Host='mail-qt0-f196.google.com', Country='US',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: from='UTF-8', cc='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: leechu729@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521222423; b=S0mifumfp9b78q/84pxkyshi5FPD/Ve7HqotBwH1FtGx4y4
    5MISJvdAHG4X1jd7NEsuDXPK7p/jtjLe5ypc9HdXVfBdW9KJFuvM9O8+XmeC5hmO
    cBj/2lk+Vf1lsjj/AE2uw52jHIakmJSny5D8HQC6QMyVWNiZfH0HeJQr6uxbtV1J
    d3TVdSQujTwlLDBfsjDG7xqIeJTpd74hD32yIU3BZSune5yK9/LOUCddmrjg9+yl
    fY8V9203qeo8gLw1sUdDedklv/EFaKRkY1st09jHVAhkmd5FTYy3wk3K0vww03zu
    4OXnfBaIZeG5Mn63DFFXE2xKRQjXYVdoShgtHJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding; s=arctest; t=1521222423; bh=SWmZVvPV
    8VlZGNfOdDqAZ7NT2MVqnf0BPmO+fFrcv9c=; b=c+oa0fU/aCQCMgSxK/ub+kHn
    mLOzaH7eMNMhj5fO3jXxXePHKw1bnQtKnlMI8/hbKkrUIRa4KU4fzAFoGBNF+s6h
    v8L8trLkQdVqU+cAhY+CA7pVnc4UnpmJcxlA6SVN7Z7o4Pmre1cCZmo7OrinXKaR
    fPViMfz/xCB3VNHgKnNTHAhDE8Xtt+x23HhiBdOMhryJtuiO44LYFeHXNB6FveIE
    odVQEprDSt0zgAysdiHwC/vxQ0finXKaR4k3JWJQfwHgX9VjbOIp4h6WFbmGuztA
    qLBBQHg4OtPlSC/3f9Hin69sQsUpSrek7U6RIcjuNXNmhpF5vyJsnt/iWWbXGw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=JXX4BhFC x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.216.196 (mail-qt0-f196.google.com);
    spf=pass smtp.mailfrom=leechu729@gmail.com smtp.helo=mail-qt0-f196.google.com;
    x-aligned-from=pass;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Fr4P/0GR;
    x-ptr=pass x-ptr-helo=mail-qt0-f196.google.com x-ptr-lookup=mail-qt0-f196.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=JXX4BhFC x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.216.196 (mail-qt0-f196.google.com);
    spf=pass smtp.mailfrom=leechu729@gmail.com smtp.helo=mail-qt0-f196.google.com;
    x-aligned-from=pass;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Fr4P/0GR;
    x-ptr=pass x-ptr-helo=mail-qt0-f196.google.com x-ptr-lookup=mail-qt0-f196.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AG47ELsdfhzKqd2CGYWM9bB8e6i3Q3u2gpU66f/AYAvqA9CTx2nqDyLNNiPNOlWtM7LrY4LbgmurOR40r0kxiWsNJB8=
MIME-Version: 1.0
In-Reply-To: <20180316150555.GE11689@kuha.fi.intel.com>
References: <1521191569-21221-1-git-send-email-leechu729@gmail.com> <20180316150555.GE11689@kuha.fi.intel.com>
From: =?UTF-8?B?5p2O5pu45biG?= <leechu729@gmail.com>
Date: Sat, 17 Mar 2018 01:47:01 +0800
Message-ID: <CAFaeLdS5zLz+E0M32J47QBfxR_0EkM7erEJCdHnQ__G4R7XYCA@mail.gmail.com>
Subject: Re: [PATCH] staging: typec: rt1711h typec chip driver
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Greg KH <greg@kroah.com>, Guenter Roeck <linux@roeck-us.net>,
	=?UTF-8?B?c2h1ZmFuX2xlZSjmnY7mm7jluIYp?= <shufan_lee@richtek.com>,
	=?UTF-8?B?Y3lfaHVhbmco6buD5ZWf5Y6fKQ==?= <cy_huang@richtek.com>,
	Jun Li <jun.li@nxp.com>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Heikki,

2018-03-16 23:05 GMT+08:00 Heikki Krogerus <heikki.krogerus@linux.intel.com=
>:
> Hi ShuFan,
>
> On Fri, Mar 16, 2018 at 05:12:49PM +0800, ShuFan Lee wrote:
>> +static int rt1711h_init_gpio(struct rt1711h_chip *chip)
>> +{
>> +     int ret;
>> +     struct device_node *np =3D chip->dev->of_node;
>> +
>> +     ret =3D of_get_named_gpio(np, "rt,intr_gpio", 0);
>> +     if (ret < 0) {
>> +             dev_err(chip->dev, "%s get int gpio fail(%d)\n", __func__,=
 ret);
>> +             return ret;
>> +     }
>> +     chip->irq_gpio =3D ret;
>> +
>> +     ret =3D devm_gpio_request_one(chip->dev, chip->irq_gpio, GPIOF_IN,
>> +                                 dev_name(chip->dev));
>> +     if (ret < 0) {
>> +             dev_err(chip->dev, "%s request gpio fail(%d)\n", __func__,=
 ret);
>> +             return ret;
>> +     }
>> +
>> +     chip->irq =3D gpio_to_irq(chip->irq_gpio);
>> +     if (chip->irq <=3D 0) {
>> +             dev_err(chip->dev, "%s gpio2irq fail(%d)\n", __func__,
>> +                     chip->irq);
>> +             return -EINVAL;
>> +     }
>> +     return 0;
>
> "rt,intr_gpio" should probable be "rt,intr-gpio". Then this function
> can be prepared for all types of platforms:
>
> static int rt1711h_init_gpio(struct rt1711h_chip *chip)
> {
>         struct gpio_desc *gpio;
>
>         gpio =3D devm_gpiod_get(chip->dev, "rt,intr", GFP_KERNEL);
>         if (IS_ERR(gpio))
>                 return PTR_ERR(gpio);
>
>         chip->irq =3D gpiod_to_irq(gpio);
>         if (chip->irq < 0)
>                 return chip->irq;
>
>         return 0;
> }
>
>
> Thanks,
>
> --
> heikki

  Thank you, I've changed it in PATCH v2.

  May I add you to Suggested-by list?

--=20
Best Regards,
=E6=9B=B8=E5=B8=86
