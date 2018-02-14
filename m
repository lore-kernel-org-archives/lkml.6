Return-Path: <arndbergmann@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-3016048-1518618865-2-8838193257220009621
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_NONE -0.0001,
  RCVD_IN_MSPIKE_H3 -0.01, RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.85.220.194', Host='mail-qk0-f194.google.com', Country='US',
  FromHeader='de', MailFrom='com'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: arndbergmann@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518618865; b=fpuzG3v+KI2si8liIC4tgbNfDMqYMlsDNANvUJ0mm0h6jsQ
    uQSA2bWZWDUbnn/vEaA0WZmlpsNnLXDFAPvnZpojQy3Z4EIXz7jsTUKk7irT6mZL
    ZJfhhjisyfJF2eCDbRhPByphRbAC1JgBZm0CyC611yW+kz6S/hL8Gp62Ziuggn22
    JP5vuru2ptVd4VVJJUELZqXU7HIC+q6eQVt7+NAdFiSnd9blMNoapH3X+oW/W0hg
    NRGM/3Tw2BnCJYij7BrkN8AxSaIjNHkvQI+RUECXovDEUe/SiX86P9KrLRjmy0z8
    MoEohb0vWoqbSW2nJhDZ1QxdR3R4RhpN1oDoOag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:sender:in-reply-to
    :references:from:date:message-id:subject:to:cc:content-type; s=
    arctest; t=1518618865; bh=Jx1YVMCsPN4g7GO6D4r3qPngyRrr9BQGwUMpQY
    qrcic=; b=ETT8IHwfi8xi069shDFnmh347xa3xu2jqfFZDJjLqMe4Nk1Fl2cwRx
    2lifNqInbnmPJEf6+38gCIiDYLE/EhMW/U1HAHUHSvfVY3dOWYP4Mqs70y07mewd
    C5dPNWembJTIqqmB+E18JIALcW6CSmocejqSZ3Y0v1pr6oy7BX9WA7KTFIwN2Rg6
    jjIAQ/hDCb+gpokAE8ExK1v7SksQHTE9uxmIwTWdqKvZ+XfieXN3YXFgotsaN1/v
    uq3pKrFM/NaouecayrKBMCZ8sMdRFuGrCK3K8HUjzfeT3DmFxKz9lXij2/64r6PR
    NNHh//txOupM0h8XT9ayOjWBqLWLbgkg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=inrk2+df x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.85.220.194 (mail-qk0-f194.google.com);
    spf=pass smtp.mailfrom=arndbergmann@gmail.com smtp.helo=mail-qk0-f194.google.com;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=WNwmBato;
    x-ptr=pass x-ptr-helo=mail-qk0-f194.google.com x-ptr-lookup=mail-qk0-f194.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=inrk2+df x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.85.220.194 (mail-qk0-f194.google.com);
    spf=pass smtp.mailfrom=arndbergmann@gmail.com smtp.helo=mail-qk0-f194.google.com;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=WNwmBato;
    x-ptr=pass x-ptr-helo=mail-qk0-f194.google.com x-ptr-lookup=mail-qk0-f194.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AH8x226w/gFrmAErK01G0J0uG4Of240ndKch3MVuEwuiMigVDNQHQR792dwHA+2b/J5741hG10N95c0jGJwtY74yNic=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <5c26fda7b2ae143a0b14b18b66f5ddbc069b0a28.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com> <5c26fda7b2ae143a0b14b18b66f5ddbc069b0a28.1518505384.git.greentime@andestech.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 14 Feb 2018 15:34:22 +0100
X-Google-Sender-Auth: bn6Roz06unNEOp84kBd9KATXoHY
Message-ID: <CAK8P3a0C+ib=xb9pbeb33y+DynNKs2HNM4EUrMBsZo+X+ymgMQ@mail.gmail.com>
Subject: Re: [PATCH v7 30/37] nds32: Build infrastructure
To: Greentime Hu <green.hu@gmail.com>
Cc: Greentime <greentime@andestech.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
	Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>,
	Networking <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>,
	DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
	David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org,
	Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>, Greg KH <greg@kroah.com>, Guo Ren <ren_guo@c-sky.com>,
	Randy Dunlap <rdunlap@infradead.org>, David Miller <davem@davemloft.net>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>,
	Vincent Chen <vincentc@andestech.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 13, 2018 at 10:09 AM, Greentime Hu <green.hu@gmail.com> wrote:
> This patch adds Makefile, Kconfig and vmlinux.lds.S files required for building
> an nds32 kernel.
>
> Signed-off-by: Vincent Chen <vincentc@andestech.com>
> Signed-off-by: Greentime Hu <greentime@andestech.com>

With the latest changes

Acked-by: Arnd Bergmann <arnd@arndb.de>
