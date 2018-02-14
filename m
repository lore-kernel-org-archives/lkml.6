Return-Path: <green.hu@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-1904769-1518587736-2-15115465364848617015
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FROM 0.001, RCVD_IN_DNSWL_NONE -0.0001,
  RCVD_IN_MSPIKE_H3 -0.01, RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.85.213.50', Host='mail-vk0-f50.google.com', Country='US',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: green.hu@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518587736; b=Tn4esW/kvDxqOdUGd+h/X7e46eZuiFqOqUZQB9V1f88QzSm
    G6vo67NHAT4Cr59735fb2rS9f2qidaqSUBJ697Dcz+X8RLlkiteNH9VUOa66ACQy
    3/JUDc9jnUYoXIv9Cleyetl2v/0dKgVmPyDwNTEt7PAQ99PQzKsnHkXHtbjIKjXx
    vtgCmzC5p4/KRfKi8/g79REhVRqCrhD/kst5MSI5ZxQK35QfDgvIenfCqNq9KaN6
    7nhDPq1xnfrPCcFRKExX/RmdDuOD/YUVYi9+HbB1vlt8mRdJ+el1E2uXo19K0oam
    kMd8zC90SX6qL61bb/lwrfEyvaJvUi1QCCAA30Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type; s=arctest; t=
    1518587736; bh=y3MFew7uE0xjDnRxrMGAszV1eh6CXDBXXBg84oye90A=; b=V
    sCS8ZzitJYVxsygp9lqFWII78DnyEN3/m+XHBg8DIjY/U2BeroBq4Oou2uSgM9HU
    7s/MuNU5Fxz17vJxfh6kUhrupf8/envs6t5HhGaPt4F87g9qNuVKn5XaEMSjeEPe
    vxrlXId0OkqMEo8v0Ty9Oxe7/atV00xavu1H65XNA/Lg0fI3GqwrSwoEEeml2r1O
    KoUoerbfqKhja+PJpN/XFeTPpq6FPURdk06y8eQ71wsUadC/QSx3yQ8CjkucK8xm
    EEzk/2SLnQ2iwSEUjQQkQRMcaLHCJO1q70nu+oCUGZzPZtTE+K3ekJpUO3tvtUf2
    DPDFNfsetaqxtabZPDXAA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=rSlEJD6u x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.213.50 (mail-vk0-f50.google.com);
    spf=pass smtp.mailfrom=green.hu@gmail.com smtp.helo=mail-vk0-f50.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=plz8fjUl;
    x-ptr=pass x-ptr-helo=mail-vk0-f50.google.com x-ptr-lookup=mail-vk0-f50.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=rSlEJD6u x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.213.50 (mail-vk0-f50.google.com);
    spf=pass smtp.mailfrom=green.hu@gmail.com smtp.helo=mail-vk0-f50.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=plz8fjUl;
    x-ptr=pass x-ptr-helo=mail-vk0-f50.google.com x-ptr-lookup=mail-vk0-f50.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AH8x2272ZT0eVeMGJfUyvmSBiNlxzFnrk+5zZ7g1aLVKMBkXD8LDaJt0M8NEGj4zBxA7EXfit5gxTICZhMgsrnkxT6U=
MIME-Version: 1.0
In-Reply-To: <1518537768.22190.42.camel@perches.com>
References: <cover.1518505384.git.greentime@andestech.com> <f7758221d49fd24fdff7c900aa5951a6c1c6a3cd.1518505384.git.greentime@andestech.com>
 <1518537768.22190.42.camel@perches.com>
From: Greentime Hu <green.hu@gmail.com>
Date: Wed, 14 Feb 2018 13:54:53 +0800
Message-ID: <CAEbi=3cYCAoqrw0JTQkEdnBNSpZUxZA+ZUSmrQd70S+xSro6Yw@mail.gmail.com>
Subject: Re: [PATCH v7 31/37] MAINTAINERS: Add nds32
To: Joe Perches <joe@perches.com>
Cc: Greentime <greentime@andestech.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>,
	Rob Herring <robh+dt@kernel.org>, netdev <netdev@vger.kernel.org>,
	Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>,
	Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-serial@vger.kernel.org,
	Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>, Greg KH <greg@kroah.com>, Guo Ren <ren_guo@c-sky.com>,
	Randy Dunlap <rdunlap@infradead.org>, David Miller <davem@davemloft.net>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-02-14 0:02 GMT+08:00 Joe Perches <joe@perches.com>:
> On Tue, 2018-02-13 at 17:09 +0800, Greentime Hu wrote:
>> Add a maintainer information for the nds32(Andes) architecture.
> []
>> diff --git a/MAINTAINERS b/MAINTAINERS
> []
>> @@ -868,6 +868,17 @@ X:       drivers/iio/*/adjd*
>>  F:   drivers/staging/iio/*/ad*
>>  F:   drivers/staging/iio/trigger/iio-trig-bfin-timer.c
>>
>> +ANDES ARCHITECTURE
>> +M:   Greentime Hu <green.hu@gmail.com>
>> +M:   Vincent Chen <deanbo422@gmail.com>
>> +T:   git https://github.com/andestech/linux.git
>> +S:   Supported
>> +F:   arch/nds32
>
> This should have a trailing /
>
> F:      arch/nds32/

Thank you Joe.
I will add this trailing /
>
>> +F:   Documentation/devicetree/bindings/interrupt-controller/andestech,ativic32.txt
>> +F:   Documentation/devicetree/bindings/nds32

And here

>> +K:   nds32
>
> Perhaps this should be
>
> K:      \bnds32
>
> as there are some existing uses of nds32 in the current tree.
>
> or maybe case insensitive like
>
> K:      (?i:\bnds32)
> or
> K:      (?:\bnds32|\bNDS32)
>

I think it might be better to keep it "nds32" becaue some intrinsic
functions are defined with __nds32__xxx.
