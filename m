Return-Path: <arndbergmann@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-3010894-1518618778-2-3473935552752805625
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_NONE -0.0001,
  RCVD_IN_MSPIKE_H3 -0.01, RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.85.220.193', Host='mail-qk0-f193.google.com', Country='US',
  FromHeader='de', MailFrom='com'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: arndbergmann@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518618777; b=FgnrPLTH28A0Qb86sv7vuSw/Gc/RSILXZq3Dnu7CQKn9N55
    kLyheLEHvoKtT98Nd0E+emxVA3EUi0tsyiOxz2MUFt80eP0eHyz8VKRI1RTO9gZ0
    8lhIlJVfaLXote71r284CQS8bI3sQdf8qqWZDbBcuXpCODSo2JZWcTRhS7r6GXMO
    tPe1eMdxCBL46IvVbNCINywyaJEckbeH7r4x1u/+MMudFbRTRpmC4pJKUMIX66lH
    DduflmthIkJswZ+uMGCDDAVFO+j6lLli+OwI6m9LLWvN2W0tytWkwBSJ+j/M0UEg
    0UntHvlBGkhHuKIa9YgX0RejlZ7IGh2yixejNjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:sender:in-reply-to
    :references:from:date:message-id:subject:to:cc:content-type; s=
    arctest; t=1518618777; bh=z2nNFaCF8S6JSFxZoljWRRKjSPAr8oc+k607Gx
    3BTU0=; b=mCAlBBSW8QIZlF+snEZmR/wLMZtPOHWgdyeO1iOQVVH9zAnotEQsDw
    sz0p8/NQKQ+2Bk9Vx7iq8W7VCTwhfxwizavws/r3oNGrOh6OQ50qLtNsBfo7cRno
    xigqiF0Ev/hEoTCZtTMwaspSbEkmSxAexf3+x1MoSqVofaq6tH4Ituiw3uf5MZ+O
    XEGTa7YRHOt6kuz7KGnON2uJw4qwZMpeZudxMo4P/zEA/dhQHM4RdsbB529jDoit
    ywi7RG9PkzRtXUGuk5/JkoEDsaJSpaEhv82eVeCIwRxGN2zDNi5PeOPifzrMR5LQ
    amfS8OnLDzgGYWxreHnDG64RHfSytuBw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=MDBy6HFJ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.85.220.193 (mail-qk0-f193.google.com);
    spf=pass smtp.mailfrom=arndbergmann@gmail.com smtp.helo=mail-qk0-f193.google.com;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=fIcs8+IA;
    x-ptr=pass x-ptr-helo=mail-qk0-f193.google.com x-ptr-lookup=mail-qk0-f193.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=MDBy6HFJ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.85.220.193 (mail-qk0-f193.google.com);
    spf=pass smtp.mailfrom=arndbergmann@gmail.com smtp.helo=mail-qk0-f193.google.com;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=fIcs8+IA;
    x-ptr=pass x-ptr-helo=mail-qk0-f193.google.com x-ptr-lookup=mail-qk0-f193.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AH8x224iFf8esCcnhg3lZvyntfGO4YGT276rXl4d8LKci10pwzLQLN6TWKBW+cLVLDQ+ZqnQcjSUVxcjUDtZbfOhJZE=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <7f9139c13f0f84091245b8f5c70ba5d4308e8b36.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com> <7f9139c13f0f84091245b8f5c70ba5d4308e8b36.1518505384.git.greentime@andestech.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 14 Feb 2018 15:32:54 +0100
X-Google-Sender-Auth: x0auAUx_XFsj-YGrPFxdwCTjJXg
Message-ID: <CAK8P3a3S=q6cHsj4ge8jjm0Pbu6dgKhMfy1Gqk=pWoudKHaZVA@mail.gmail.com>
Subject: Re: [PATCH v7 23/37] nds32: Debugging support
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
> This patch adds ptrace support.
>
> Signed-off-by: Vincent Chen <vincentc@andestech.com>
> Signed-off-by: Greentime Hu <greentime@andestech.com>

This new version looks good to me,

Acked-by: Arnd Bergmann <arnd@arndb.de>
