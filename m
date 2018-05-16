Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-700495-1526495602-2-16155328094027925771
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526495602; b=Oo+lp7h3R8soYHuUvRy9mF2v1fWrowIFx0Tj89i+1W9HcsgclH
    6QrPLp04FCwLpoWteN/kp7DVLjHIru5KelIfrqMzGe6jrXd0W+VpDHAgSJKz16Vl
    a+F3EBEsYyad8LP+SAFGrPstGfwoTAqAX93stVs521VCJ+fYnWQw15aQpRI6WRhn
    bAPWbVdm8hQEcoKIb7lFKE8uLS5MpuYUhcndlmzX616JWHNSOrqBJg+n5nan2qzh
    q5Bb2tcvzoFX0TUWFB7I3v5u6T8zTR0vwIdPu6QFB9nmAwhQO8bo1j2amQOkueLl
    uvsND7IUoUNcFhHUiM4C9goGClYMFv1K4bow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1526495602; bh=ncu08ESIBZo1ugX0nUKbgQpT9s1C4FBNIRwWYzGjfG
    c=; b=nGhhQ0CBlxKsUhK6x3m3Z94A1IBNpoBEJwqNu280jd2f+RdOg44+PNQO2q
    ndsBAEn6JMkiYPqFZx/iL2RIrZcTy1AQFkdjYmvg6AlSkx88ye2fcLK1gcbtalBt
    WZreloaxzdHX08iuaGo5n1M4U7Nqd+6ajPviljS2PDliLKVsXliuEigz81vyoUIV
    Cb7dBXNYldApTjmQ+G9OMgwzyhU+KAInMTR9OTgnnChR11GFVV3WkrrxnUmXY5GQ
    cOUegBo3ZQOyK8ygw+leRn5mUOIxn+1Q0eDEbwfyNalQ24Q3EmpxbJu5LNl5YH2e
    ueSlmSqLZyBYMXXiwfWDDOeJOg/Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=OzrYUI3T x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=ouh2sBC+;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux-m68k.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=OzrYUI3T x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=ouh2sBC+;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux-m68k.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfL6+AtX+mv0+tIrRzWJ50qm8OLou5RtVBNmw0mRBH4w2oJid+qKXVaBcb2zVW/4W3yzTnek59XiyseH1TisP80ifmh3eQt0B4z9OthwuDWzK4S78lUfk
    Lz6XcxlroI28MIQ0YgaAHc+ekaKHJB5+M/63iGHrGoX/hCySWw0RXYM9vFbR3aCf8btrjlE781nvIKc/TazBYAr7BfGviYZO7mHK6fDKr1n/T7kzr6pf0tVl
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=J1Y8HTJGAAAA:8 a=pGLkceISAAAA:8 a=tBb2bbeoAAAA:8 a=VwQbUJbxAAAA:8
    a=je38gQuDuE4cCbkG7ZcA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Oj-tNtZlA1e06AYgeCfH:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751312AbeEPSdE (ORCPT <rfc822;greg@kroah.com>);
        Wed, 16 May 2018 14:33:04 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:45969 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750786AbeEPSdB (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 16 May 2018 14:33:01 -0400
X-Google-Smtp-Source: AB8JxZo3PmnXi4/VSNOtylPvgzouo9BpG8vlAtckJR+jlsx3Jy438jCuU8LX/WCW0Afc4e0lb53QiAHgHOrKW5zAN3w=
MIME-Version: 1.0
In-Reply-To: <20180516.142102.1650229402143291732.davem@davemloft.net>
References: <20180515235619.27773-1-f.fainelli@gmail.com> <20180516.142102.1650229402143291732.davem@davemloft.net>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 16 May 2018 20:32:58 +0200
X-Google-Sender-Auth: SKD95pVAYXUQ-w4NkTdsaOj6bYM
Message-ID: <CAMuHMdUBk3xT1G0XLd3Y8AJxrCb5zbegNu07dwMsX3zGjvgUpA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/2] of: mdio: Fall back to mdiobus_register()
 with NULL device_node
To: David Miller <davem@davemloft.net>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
        netdev <netdev@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Fugang Duan <fugang.duan@nxp.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        =?UTF-8?Q?Antoine_T=C3=A9nart?= <antoine.tenart@free-electrons.com>,
        Tobias Jordan <Tobias.Jordan@elektrobit.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?=
        <niklas.soderlund+renesas@ragnatech.se>,
        Simon Horman <horms+renesas@verge.net.au>,
        Maxim Uvarov <muvarov@gmail.com>, Sekhar Nori <nsekhar@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:TI ETHERNET SWITCH DRIVER (CPSW)"
        <linux-omap@vger.kernel.org>, USB list <linux-usb@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi David,

On Wed, May 16, 2018 at 8:21 PM, David Miller <davem@davemloft.net> wrote:
> From: Florian Fainelli <f.fainelli@gmail.com>
> Date: Tue, 15 May 2018 16:56:17 -0700
>
>> This patch series updates of_mdiobus_register() such that when the device_node
>> argument is NULL, it calls mdiobus_register() directly. This is consistent with
>> the behavior of of_mdiobus_register() when CONFIG_OF=n.
>>
>> I only converted the most obvious drivers, there are others that have a much
>> less obvious behavior and specifically attempt to deal with CONFIG_ACPI.
>>
>> Changes in v2:
>>
>> - fixed build error in davincin_mdio.c (Grygorii)
>> - reworked first patch a bit: commit message, subject and removed useless
>>   code comment
>
> Based upon Andrew's response to Geert's feedback, I'm applying this series.

Thanks, his feedback made perfect sense.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
