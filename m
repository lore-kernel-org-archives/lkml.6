Return-Path: <arndbergmann@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-3016048-1518618950-2-7566956103246707378
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
    t=1518618949; b=P0ZBZzHJbSIq/diNLCzkJc3q8FR98w7nPX+5mxQIdzv5GR4
    2MDKBtFMDGmQyucqEwnEp3NyehY5gCJnTzFBmnsJpu/NAfIQzAi1tp0ButzjEH+K
    xRKP4dYAPbeRwibSDGvMohYf7VJxnu4H0IeIJunP1Fzt0y3hCbyL6nxSDoClmZHO
    pkvsVT0KIUWzMyvgXqaIgOuqe6yA1muiIcd7ZYnvrR4UonHOmG7kRkPGOq52xjfG
    w+oE6u3KfZ8MqSAJkWCLmY3vwM7vtfwP0wZGJFvhJhwPeTNBvXERbCCqhAHSMVQA
    gwkKWOIu9C1nyLyILIiCIdq7SeMdYUALtFf1waA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:sender:in-reply-to
    :references:from:date:message-id:subject:to:cc:content-type; s=
    arctest; t=1518618949; bh=WGRF/QJ67TMMVRjWfgojOF5Dgv020rnanFx/e0
    yr3Zk=; b=bXlpXWV3kOHBC3mQ2DVyzXVwfFoY6xGFixfyqQr69y+OgPzn+WefRf
    eOs7v+D/EYOfsZKRbviC67wL+GIqthE0pTUSKvoIVs/wK1CnU+/Xz3yLRGbsSzS2
    /taQaMWFddkfSakeytsJgbmTj+GmNxkiHBR18kJdUKjwRMenf5FDbJ6WeApUtN7W
    8aP8RA4UbUcKeiH2uivp/OZMiwEARlOaIBMwVc+nkJroEQmVrJ8lvSVEd4tHnKgc
    uIMiR/JeezgZl405QH56MMJYhQjXdHblNsgJK3y5voQkglsl/WE+YiSNaHmFaoCJ
    MwkxhzLHxyC44jJKUer7Ur5jgobFfYTA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=aaQesrLR x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.85.220.193 (mail-qk0-f193.google.com);
    spf=pass smtp.mailfrom=arndbergmann@gmail.com smtp.helo=mail-qk0-f193.google.com;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=DnFO7rL4;
    x-ptr=pass x-ptr-helo=mail-qk0-f193.google.com x-ptr-lookup=mail-qk0-f193.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=aaQesrLR x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.85.220.193 (mail-qk0-f193.google.com);
    spf=pass smtp.mailfrom=arndbergmann@gmail.com smtp.helo=mail-qk0-f193.google.com;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=DnFO7rL4;
    x-ptr=pass x-ptr-helo=mail-qk0-f193.google.com x-ptr-lookup=mail-qk0-f193.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AH8x227NqqVOnAsvCXfwH1Rs/+XUNO87Gp96gQh7BOJPcknE4aG9NuxjgYzTFBSJ5OW/hszvWoPhE6B4F3z7XipIFLQ=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <7fe1c8908c84b873c98947b31bcce92daea6d67f.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com> <7fe1c8908c84b873c98947b31bcce92daea6d67f.1518505384.git.greentime@andestech.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 14 Feb 2018 15:35:45 +0100
X-Google-Sender-Auth: MNhq68IKGQVCLzWWfP_b7fye2Ag
Message-ID: <CAK8P3a3yfdZOWsv59j2d=SW6Rbwz+wyoVYGUBvFDTyANvxKVFw@mail.gmail.com>
Subject: Re: [PATCH v7 07/37] nds32: Kernel booting and initialization
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
> This patch includes the kernel startup code. It can get dtb pointer
> passed from bootloader. It will create a temp mapping by tlb
> instructions at beginning and goto start_kernel.
>
> Signed-off-by: Vincent Chen <vincentc@andestech.com>
> Signed-off-by: Greentime Hu <greentime@andestech.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
