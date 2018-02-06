Return-Path: <arndbergmann@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-618430-1517906902-2-2800416997562707001
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_NONE -0.0001,
  RCVD_IN_MSPIKE_H3 -0.01, RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='74.125.82.195', Host='mail-ot0-f195.google.com', Country='US',
  FromHeader='de', MailFrom='com'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: arndbergmann@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517906901; b=ak5SDEn2Cp8EIVZaYFWLTcf/NwycZhGiKYdN4GOEX0sQgTh
    VUjxkubKjzFloYGH3axQ0AByIAXSjQ+4ZdDEbjLZoYJBx+ck+D/H27TLwt4ROHE5
    c52UmVPzEbELxemLhzp08gMuBBinWSxPRH5Zcw+7FIrVkjBC+8lT/cmgeBQvR/ba
    Mnmt98yFoR0Rmwuu0A4+lWBrwoh5KJOXjUYOb/MMbgtYj9qmBnqLH7F2SE+mr4zm
    6WHGckhqWRPGuRCjoqTXOOT+5gRouGgWAWDU9d3ozP/aIxNe/tCDrQuWIkyD3/ms
    9K7xe2DgwASntb9RdkR/akk1D/it9IPNozlxBVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:sender:in-reply-to
    :references:from:date:message-id:subject:to:cc:content-type; s=
    arctest; t=1517906901; bh=SsXGwX+Rn/BEIFJU9Z63GXe9XHguj5dy2vTVuH
    W6Q2Y=; b=ZqHfGHzgTwycqAVbTw9TTPEe0fhusu5hn8sVnpo0+HvlnxIZ3MTk1Y
    YCSg8ka0Ea66Xb//4/zLy5TZJbXCpUN1yn1vzDNO6yD1RF66fTMXz6pcHh+/eR65
    vwP190kX+4iJuczfkpXiQDwEeQpeqqywJ7yaG7EWhUwnorZkzV1r5VsOWblQ499T
    q++eP1eePkE5oxCOX7E5Sb1LTME3DGiN7HjFyzSyJy1w0JVDVGrBPL/HYWTnzIaY
    VlSL4WQBET4xFxsfS2SfGCypnyQrQILjhsBM4DL1K5TUb4MLx4SxNFvGXFjw34CF
    luKMm53fdgtwunGfqDNVDoeNuDP9iHyA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Bf2KL1U/ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=74.125.82.195 (mail-ot0-f195.google.com);
    spf=pass smtp.mailfrom=arndbergmann@gmail.com smtp.helo=mail-ot0-f195.google.com;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=HFuXf7Zj;
    x-ptr=pass x-ptr-helo=mail-ot0-f195.google.com x-ptr-lookup=mail-ot0-f195.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Bf2KL1U/ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=74.125.82.195 (mail-ot0-f195.google.com);
    spf=pass smtp.mailfrom=arndbergmann@gmail.com smtp.helo=mail-ot0-f195.google.com;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=HFuXf7Zj;
    x-ptr=pass x-ptr-helo=mail-ot0-f195.google.com x-ptr-lookup=mail-ot0-f195.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AH8x225Wz/jctmejyo5ewN+4PrFly6S5Zov9v2EfTSMJ4TQAIrwxasQWgZXJbpC1+DanxGdYiNCh4JqCVHg/zesI1gA=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <CAJsyPhwHmMrXmN2-NW3ZyvRvTWR0vio_bQO+GDBf30DVp=5LTw@mail.gmail.com>
References: <cover.1515766253.git.green.hu@gmail.com> <4a602db0a58cc858515c3c669d5ac34c567b061c.1515766253.git.green.hu@gmail.com>
 <CAK8P3a0GQDrj+7kc4YB1_ZC1vCWmMtSiYeKsNir_27FvY50Kmg@mail.gmail.com> <CAJsyPhwHmMrXmN2-NW3ZyvRvTWR0vio_bQO+GDBf30DVp=5LTw@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 6 Feb 2018 09:48:17 +0100
X-Google-Sender-Auth: hf72Rg4bj9t3u18JMJJ3KQu4tuc
Message-ID: <CAK8P3a2R02bNZF-BYW6mbC9jCT+zx-HUtw1y1HS5EifOuOting@mail.gmail.com>
Subject: Re: [PATCH v6 19/36] nds32: VDSO support
To: Vincent Chen <deanbo422@gmail.com>
Cc: Greentime Hu <green.hu@gmail.com>, Greentime <greentime@andestech.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
	Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>,
	Networking <netdev@vger.kernel.org>, DTML <devicetree@vger.kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>,
	Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-serial@vger.kernel.org,
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

On Tue, Feb 6, 2018 at 8:41 AM, Vincent Chen <deanbo422@gmail.com> wrote:
> 2018-01-18 18:28 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
>> On Mon, Jan 15, 2018 at 6:53 AM, Greentime Hu <green.hu@gmail.com> wrote:
>>> From: Greentime Hu <greentime@andestech.com>
>>>
>>> This patch adds VDSO support. The VDSO code is currently used for
>>> sys_rt_sigreturn() and optimised gettimeofday() (using the SoC timer counter).
>>>
>>> Signed-off-by: Vincent Chen <vincentc@andestech.com>
>>> Signed-off-by: Greentime Hu <greentime@andestech.com>
>>
>> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> Dear Arnd Bergmann:
>
> We find a small bug here which make LTP 20170929 clock_getres01
> fail. The bug is in __vdso_clock_getres() function. When argument res
> is NULL, -EFAULT error code is returned now. But, the returned
> value is 0 for SyS_clock_getres under the same conditions.
> Therefore, testcase thinks it is a bug.
>
> I will modify the code as below and add it in the next version patch
> if you think it is OK.
>
> @@ -209,7 +209,7 @@ static notrace int clock_getres_fallback( ...
>  {
>          if (res == NULL)
> -                return -EFAULT;
> +                return 0;
>

Ok. I don't know why that is the expected behavior (clock_getres
with a NULL argument makes little sense), but I can see that it
matches the regular syscall implementation.

      Arnd
